#!/usr/bin/env python3
"""Convert a color image to greyscale."""

import argparse
from pathlib import Path

from PIL import Image

OUTPUT_DIR = Path("output")


def to_greyscale(input_path: Path, output_path: Path) -> None:
    with Image.open(input_path) as img:
        # "L" is 8-bit luminance: L = 0.299R + 0.587G + 0.114B.
        img.convert("L").save(output_path)


def main() -> None:
    parser = argparse.ArgumentParser(description="Convert an image to greyscale.")
    parser.add_argument(
        "--input_image", type=Path, required=True, help="image to convert"
    )
    parser.add_argument(
        "--output_file",
        default="greyscale.png",
        help="name of the file written inside the output directory",
    )
    args = parser.parse_args()

    # CWL collects results by globbing ./output*, so everything goes in there.
    OUTPUT_DIR.mkdir(exist_ok=True)
    output_path = OUTPUT_DIR / args.output_file

    to_greyscale(args.input_image, output_path)
    print(f"wrote {output_path}")


if __name__ == "__main__":
    main()
