#!/usr/bin/env python3
"""Entrypoint that maps the OGC ``--<name> value`` inputs onto papermill
parameters and executes the notebook.

Each argparse flag here must match an input `name` in algorithm_config.yml, and
each parameter key must match a variable in the notebook's `parameters` cell.
"""

import argparse
import os

import papermill as pm

NOTEBOOK_PATH = "/app/stac_clip.ipynb"
OUTPUT_DIR = "output"


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Execute the stac_clip notebook with papermill."
    )
    parser.add_argument(
        "--input_catalog",
        required=True,
        help="Path to the staged STAC Catalog directory.",
    )
    parser.add_argument(
        "--asset_name",
        required=True,
        help="Key of the raster asset in the STAC Item to clip, e.g. B04.",
    )
    parser.add_argument(
        "--bbox",
        required=True,
        help="Clip bounding box as 'MINX MINY MAXX MAXY' in EPSG:4326.",
    )
    parser.add_argument(
        "--output_file",
        default="clipped.tif",
        help="Name of the clipped COG inside output/ (default: clipped.tif).",
    )
    args = parser.parse_args()

    # The notebook writes results into ./output; keep the executed copy there too.
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    executed_notebook = os.path.join(OUTPUT_DIR, "executed_stac_clip.ipynb")

    pm.execute_notebook(
        NOTEBOOK_PATH,
        executed_notebook,
        parameters={
            "input_catalog": args.input_catalog,
            "asset_name": args.asset_name,
            "bbox": args.bbox,
            "output_file": args.output_file,
        },
    )


if __name__ == "__main__":
    main()
