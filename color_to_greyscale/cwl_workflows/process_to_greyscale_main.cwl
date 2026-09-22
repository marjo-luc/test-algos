cwlVersion: v1.2
$graph:
- class: Workflow
  label: to_greyscale
  doc: Converts a color image to an 8-bit greyscale image using the ITU-R BT.601 luma
    weights (L = 0.299R + 0.587G + 0.114B). Reads any format Pillow supports; the
    output format follows the extension of the output filename.
  id: to_greyscale
  inputs:
    input_image:
      doc: Color image to convert. Any format Pillow can read (PNG, JPEG, TIFF, ...).
        A single-band image is passed through unchanged.
      label: Input image
      type: File
    output_file:
      doc: Name of the greyscale image, written inside the output directory. The extension
        selects the output format. Does not change where results are collected from.
      label: Output filename
      type: string?
      default: greyscale.png
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
      dockerPull: ghcr.io/marjo-luc/to_greyscale:main
    NetworkAccess:
      networkAccess: true
    ResourceRequirement:
      ramMin: 2048
      coresMin: 1
      outdirMax: 1024
  baseCommand: color_to_greyscale.py
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
      default: greyscale.png
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
s:commitHash: 0508a67df8b4250a4c5e0e6422661bc358626425
s:dateCreated: 2026-09-22
s:license: https://raw.githubusercontent.com/marjo-luc/test-algos/refs/heads/main/LICENSE
s:softwareVersion: 1.0.0
s:version: main
s:releaseNotes: None
s:keywords: ogc, image-processing, greyscale, pillow
$namespaces:
  s: https://schema.org/
$schemas:
- https://raw.githubusercontent.com/schemaorg/schemaorg/refs/heads/main/data/releases/9.0/schemaorg-current-http.rdf
