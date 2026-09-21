cwlVersion: v1.2
$graph:
- class: Workflow
  label: color-to-greyscale
  doc: Converts a color image to a single-band greyscale GeoTIFF using GDAL, applying
    the ITU-R BT.601 luma weights to the first three bands.
  id: color-to-greyscale
  inputs:
    input_image:
      doc: Color image to convert. Any GDAL-readable raster; the first three bands
        are read as R, G, B. A single-band input is passed through unchanged.
      label: Input image
      type: File
    output_file:
      doc: Name of the output GeoTIFF, written inside the output directory. Does not
        change where results are collected from.
      label: Output filename
      type: string?
      default: greyscale.tif
  outputs:
    out:
      type: Directory
      outputSource: process/outputs_result
  steps:
    process:
      run: '#main'
      in:
        input_image: input_image
        output_file: output_file
      out:
      - outputs_result
- class: CommandLineTool
  id: main
  requirements:
    DockerRequirement:
      dockerPull: ghcr.io/marjo-luc/color-to-greyscale:main
    NetworkAccess:
      networkAccess: true
    ResourceRequirement:
      ramMin: 2048
      coresMin: 1
      outdirMax: 1024
  baseCommand: run.py
  inputs:
    input_image:
      type: File
      inputBinding:
        position: 1
        prefix: --input_image
    output_file:
      type: string?
      inputBinding:
        position: 2
        prefix: --output_file
      default: greyscale.tif
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
s:commitHash: dc856a8327a5d99c2dbe2651973c70f611d58345
s:dateCreated: 2026-09-21
s:license: https://raw.githubusercontent.com/marjo-luc/test-algos/refs/heads/main/LICENSE
s:softwareVersion: 1.0.0
s:version: main
s:releaseNotes: None
s:keywords: ogc, gdal, raster, greyscale, image-processing
$namespaces:
  s: https://schema.org/
$schemas:
- https://raw.githubusercontent.com/schemaorg/schemaorg/refs/heads/main/data/releases/9.0/schemaorg-current-http.rdf
