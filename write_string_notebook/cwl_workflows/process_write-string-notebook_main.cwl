cwlVersion: v1.2
$graph:
- class: Workflow
  label: write-string-notebook
  doc: Writes a given text string to an output file.
  id: write-string-notebook
  inputs:
    text:
      doc: The text string to write to the output file.
      label: Text
      type: string
    output_path:
      doc: 'Name of the output file, written inside output/ (default: output.txt).'
      label: Output filename
      type: string?
      default: output.txt
  outputs:
    out:
      type: Directory
      outputSource: process/outputs_result
  steps:
    process:
      run: '#main'
      in:
        text: text
        output_path: output_path
      out:
      - outputs_result
- class: CommandLineTool
  id: main
  requirements:
    DockerRequirement:
      dockerPull: ghcr.io/marjo-luc/write-string-notebook:main
    NetworkAccess:
      networkAccess: true
    ResourceRequirement:
      ramMin: 512
      coresMin: 1
      outdirMax: 50
  baseCommand: run.py
  inputs:
    text:
      type: string
      inputBinding:
        position: 1
        prefix: --text
    output_path:
      type: string?
      inputBinding:
        position: 2
        prefix: --output_path
      default: output.txt
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
s:commitHash: 3356bfc5cd7638bfa89e108ee28051ba63b5a6a5
s:dateCreated: 2026-09-23
s:license: https://raw.githubusercontent.com/marjo-luc/test-algos/refs/heads/main/LICENSE
s:softwareVersion: 1.0.0
s:version: main
s:releaseNotes: None
s:keywords: ogc, notebook, papermill
$namespaces:
  s: https://schema.org/
$schemas:
- https://raw.githubusercontent.com/schemaorg/schemaorg/refs/heads/main/data/releases/9.0/schemaorg-current-http.rdf
