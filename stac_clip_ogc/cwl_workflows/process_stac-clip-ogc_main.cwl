cwlVersion: v1.2
$graph:
- class: Workflow
  label: stac-clip-ogc
  doc: Clips one raster asset from a staged STAC Catalog to a bounding box and returns
    the result as a Cloud-Optimized GeoTIFF in a new STAC Catalog.
  id: stac-clip-ogc
  inputs:
    input_catalog:
      doc: Staged STAC Catalog directory containing a catalog.json and at least one
        Item
      label: Input STAC Catalog
      type: Directory
    asset_name:
      doc: Key of the raster asset in the STAC Item to clip, e.g. B04
      label: Asset name
      type: string
    bbox:
      doc: Clip bounding box as 'MINX MINY MAXX MAXY' (min lon, min lat, max lon,
        max lat), space-separated, in EPSG:4326
      label: Bounding box
      type: string
    output_file:
      doc: Name of the clipped Cloud-Optimized GeoTIFF (written inside the output
        directory)
      label: Output filename
      type: string?
      default: clipped.tif
  outputs:
    out:
      type: Directory
      outputSource: process/outputs_result
  steps:
    process:
      run: '#main'
      in:
        input_catalog: input_catalog
        asset_name: asset_name
        bbox: bbox
        output_file: output_file
      out:
      - outputs_result
- class: CommandLineTool
  id: main
  requirements:
    DockerRequirement:
      dockerPull: ghcr.io/marjo-luc/stac-clip-ogc:main
    NetworkAccess:
      networkAccess: true
    ResourceRequirement:
      ramMin: 4096
      coresMin: 1
      outdirMax: 2048
  baseCommand: run.py
  inputs:
    input_catalog:
      type: Directory
      inputBinding:
        position: 1
        prefix: --input_catalog
    asset_name:
      type: string
      inputBinding:
        position: 2
        prefix: --asset_name
    bbox:
      type: string
      inputBinding:
        position: 3
        prefix: --bbox
    output_file:
      type: string?
      inputBinding:
        position: 4
        prefix: --output_file
      default: clipped.tif
  outputs:
    outputs_result:
      outputBinding:
        glob: ./output*
      type: Directory
s:author:
- class: s:Person
  s:name: Marjorie Lucas
s:contributor:
- class: s:Person
  s:name: Marjorie Lucas
s:citation: https://github.com/marjo-luc/test-algos.git
s:codeRepository: https://github.com/marjo-luc/test-algos.git
s:commitHash: 1beee9f096f6386cfc5cf87cd6b34e60fb4051ef
s:dateCreated: 2026-10-01
s:license: https://raw.githubusercontent.com/marjo-luc/test-algos/refs/heads/main/LICENSE
s:softwareVersion: 1.0.0
s:version: main
s:releaseNotes: None
s:keywords: ogc, stac, raster, clip, cog
$namespaces:
  s: https://schema.org/
$schemas:
- https://raw.githubusercontent.com/schemaorg/schemaorg/refs/heads/main/data/releases/9.0/schemaorg-current-http.rdf
