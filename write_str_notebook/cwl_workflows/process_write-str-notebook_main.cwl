cwlVersion: v1.2
$graph:
- class: Workflow
  label: write-str-notebook
  doc: Writes a user-supplied string verbatim to a UTF-8 text file in the output directory,
    executed via a Jupyter notebook through papermill.
  id: write-str-notebook
  inputs:
    text:
      doc: String to write. Stored verbatim as UTF-8, with no trailing newline added.
      label: Text
      type: string
    output_path:
      doc: Name of the text file, written inside the output directory. Does not change
        where results are collected from.
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
      dockerPull: ghcr.io/marjo-luc/write-str-notebook:main
    NetworkAccess:
      networkAccess: true
    ResourceRequirement:
      ramMin: 512
      coresMin: 1
      outdirMax: 128
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
s:commitHash: 0508a67df8b4250a4c5e0e6422661bc358626425
s:dateCreated: 2026-09-23
s:license: https://www.apache.org/licenses/LICENSE-2.0.txt
s:softwareVersion: 1.0.0
s:version: main
s:releaseNotes: None
s:keywords: ogc, text, utility, example, notebook
$namespaces:
  s: https://schema.org/
$schemas:
- https://raw.githubusercontent.com/schemaorg/schemaorg/refs/heads/main/data/releases/9.0/schemaorg-current-http.rdf
