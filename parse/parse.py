#!/usr/bin/env python3
from bs4 import BeautifulSoup
import logging
import sys
import argparse
from typing import Tuple, List

def parse_args():
    parser = argparse.ArgumentParser(description='Parse DEHS XML file containing Debian package update information')
    parser.add_argument('-n', '--no-updates', help='disable listing updated packages', action='store_true')
    parser.add_argument('-e', '--errors', help='enable listing error packages', action='store_true')
    parser.add_argument('-v', '--versions', help='print version information (human readable)', action='store_true')
    parser.add_argument('infile', nargs='?', type=argparse.FileType('r'), default=sys.stdin,
                        help='file containing uscan DEHS xml')

    return parser.parse_args()

def parse_input(infile: str) -> Tuple[List[str], List[str], List[str]]:

    update = []
    update_full = []
    error = []

    soup = BeautifulSoup(infile, "html.parser")

    for dehs in soup.find_all('dehs'):
        if dehs.package:
            package = dehs.package.text
            if dehs.warnings:
                warnings = dehs.warnings.text.strip()
                error.append(f"{package} failed: {warnings}")
            else:
                debian_version = dehs.find('debian-uversion').text
                upstream_version = dehs.find('upstream-version').text
                status = dehs.find('status').text.strip()
                if status == 'newer package available':
                    update.append(package)
                    update_full.append(f"{package} new version! was {debian_version} now {upstream_version}")
        else:
            if dehs.warnings:
                warnings = dehs.warnings.text.strip()
                error.append(warnings)

    return update, update_full, error


def render(args, update: List[str], update_full: List[str], error: List[str]):
    if not args.no_updates:
        if args.versions:
            for u in update_full:
                print(u)
        else:
            for u in update:
                print(u)

    if args.errors:
        for e in error:
            print(e)

def main():
    args = parse_args()
    update, update_full, error = parse_input(args.infile)
    render(args, update, update_full, error)


if __name__ == '__main__':
    main()
