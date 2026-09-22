#!/usr/bin/env python3
"""Write a string to a file in the output directory."""

import argparse
import os

OUTPUT_DIR = "output"


def main():
    parser = argparse.ArgumentParser(description="Write a string to a file.")
    parser.add_argument("--text", required=True, help="string to write")
    parser.add_argument(
        "--output_file", default="output.txt", help="file to write it to"
    )
    args = parser.parse_args()

    # CWL collects results by globbing ./output*, so everything goes in there.
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    output_path = os.path.join(OUTPUT_DIR, args.output_file)

    with open(output_path, "w", encoding="utf-8") as f:
        f.write(args.text)


if __name__ == "__main__":
    main()
