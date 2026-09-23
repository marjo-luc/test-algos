#!/usr/bin/env python3
"""Entrypoint that maps the OGC ``--<name> value`` inputs onto papermill
parameters and executes the write_string_to_file notebook.

Each argparse flag here must match an input `name` in algorithm_config.yml, and
each parameter key must match a variable in the notebook's `parameters` cell.
"""

import argparse
import os

import papermill as pm

NOTEBOOK_PATH = "/app/write_string_to_file.ipynb"
OUTPUT_DIR = "output"


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Execute the write_string_to_file notebook with papermill."
    )
    parser.add_argument(
        "--text",
        required=True,
        help="String to write verbatim as UTF-8, with no trailing newline added.",
    )
    parser.add_argument(
        "--output_path",
        default="output.txt",
        help="Name of the text file, written inside output/ (default: output.txt).",
    )
    args = parser.parse_args()

    # The notebook writes results into ./output; keep the executed copy there too.
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    executed_notebook = os.path.join(OUTPUT_DIR, "executed_write_string_to_file.ipynb")

    pm.execute_notebook(
        NOTEBOOK_PATH,
        executed_notebook,
        parameters={
            "text": args.text,
            "output_path": args.output_path,
        },
    )


if __name__ == "__main__":
    main()
