"""Build a tiny synthetic STAC Catalog standing in for MAAP's stage-in.

Writes test_data/input/: catalog.json, one Item, and a 60 m UTM 10N "B04"
GeoTIFF over San Francisco. Values are a gradient, not real reflectance.
Run inside the algorithm image, which already has rasterio and pystac:

  docker run --rm -v "$PWD/stac_clip_ogc/test_data:/data" -w /data \
      ghcr.io/marjo-luc/stac-clip-ogc:main python3 make_test_data.py
"""

import datetime
import os

import numpy as np
import pystac
import rasterio
from rasterio.transform import from_origin
from rasterio.warp import transform_bounds

OUT = "input"
BBOX_4326 = (-122.55, 37.70, -122.35, 37.85)
CRS = "EPSG:32610"
RES = 60.0

os.makedirs(OUT, exist_ok=True)
minx, miny, maxx, maxy = transform_bounds("EPSG:4326", CRS, *BBOX_4326)
width, height = int((maxx - minx) // RES), int((maxy - miny) // RES)
transform = from_origin(minx, maxy, RES, RES)
data = (np.add.outer(np.arange(height), np.arange(width)) % 4000).astype("uint16")

tif = os.path.join(OUT, "B04.tif")
with rasterio.open(
    tif, "w", driver="GTiff", width=width, height=height, count=1,
    dtype="uint16", crs=CRS, transform=transform, compress="deflate",
) as dst:
    dst.write(data, 1)

item = pystac.Item(
    id="synthetic-sf-b04",
    geometry={
        "type": "Polygon",
        "coordinates": [[
            [BBOX_4326[0], BBOX_4326[1]], [BBOX_4326[2], BBOX_4326[1]],
            [BBOX_4326[2], BBOX_4326[3]], [BBOX_4326[0], BBOX_4326[3]],
            [BBOX_4326[0], BBOX_4326[1]],
        ]],
    },
    bbox=list(BBOX_4326),
    datetime=datetime.datetime(2024, 6, 1, tzinfo=datetime.timezone.utc),
    properties={},
)
item.add_asset("B04", pystac.Asset(href="./B04.tif", media_type=pystac.MediaType.GEOTIFF, roles=["data"]))

catalog = pystac.Catalog(id="synthetic-input", description="Synthetic test input for stac-clip-ogc.")
catalog.add_item(item)
catalog.set_self_href(os.path.join(OUT, "catalog.json"))
item.set_self_href(os.path.join(OUT, f"{item.id}.json"))
catalog.save(catalog_type=pystac.CatalogType.SELF_CONTAINED)
print(f"Wrote {width}x{height} {tif} and {OUT}/catalog.json")
