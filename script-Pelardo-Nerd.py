import argparse
import urllib.request
import gzip
import io
from collections import defaultdict

DEBIAN_MIRROR_URL = "http://ftp.uk.debian.org/debian/dists/stable/main/"

def download_contents(arch):
    url = f"http://ftp.uk.debian.org/debian/dists/stable/main/Contents-{arch}.gz"
    print("Downloading Contents file from %s for arch %s\n" % (url,arch))
    response = urllib.request.urlopen(url)
    contents = gzip.decompress(response.read()).decode("utf-8")
    return contents

def get_top_packages(contents):
    packages = {}
    for line in contents.splitlines():
        try:
            filename, package = line.split(' ')
            if package in packages:
                packages[package] += 1
            else:
                packages[package] = 1
        except ValueError:
            continue
    return sorted(packages.items(), key=lambda x: x[1], reverse=True)[:10]

def output_stats(top_packages):
    print("Top 10 packages:")
    for i, (package, count) in enumerate(top_packages):
        print(f"{i+1}. {package} {count}")

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('arch', help='The architecture of the Contents index file to download')
    args = parser.parse_args()
    contents = download_contents(args.arch)
    top_packages = get_top_packages(contents)
    output_stats(top_packages)


# import argparse
# import urllib.request
# import gzip
# import io
# from collections import defaultdict

# DEBIAN_MIRROR_URL = "http://ftp.uk.debian.org/debian/dists/stable/main/"

# def download_contents(arch):
#     """
#     Download Contents file for the specified architecture.

#     :param arch: The architecture of the Contents index file to download
#     :return: The decompressed contents of the file as a string
#     """
#     url = f"http://ftp.uk.debian.org/debian/dists/stable/main/Contents-{arch}.gz"
#     print("Downloading Contents file from %s for arch %s\n" % (url,arch))
#     response = urllib.request.urlopen(url)
#     contents = gzip.decompress(response.read()).decode("utf-8")
#     return contents

# def get_top_packages(contents):
#     """
#     Parse the contents file and return the top 10 packages.

#     :param contents: The contents of the Contents index file as a string
#     :return: A list of tuples with the top 10 packages and their file counts
#     """
#     packages = {}
#     for line in contents.splitlines():
#         try:
#             filename, package = line.split(' ')
#             if package in packages:
#                 packages[package] += 1
#             else:
#                 packages[package] = 1
#         except ValueError:
#             continue
#     return sorted(packages.items(), key=lambda x: x[1], reverse=True)[:10]

# def output_stats(top_packages):
#     """
#     Print the top 10 packages and their file counts.

#     :param top_packages: A list of tuples with the top 10 packages and their file counts

#     """
#     print("Top 10 packages:")
#     for i, (package, count) in enumerate(top_packages):
#     print(f"{i+1}. {package} {count}")

#     if name == 'main':
#     parser = argparse.ArgumentParser()
#     parser.add_argument('arch', help='The architecture of the Contents index file to download')
#     args = parser.parse_args()
#     contents = download_contents(args.arch)
#     top_packages = get_top_packages(contents)
#     output_stats(top_packages)

# # This script downloads the Contents index file for the specified architecture from a Debian mirror, parses the file, and outputs the top 10 packages with the highest number of files in the given architecture.

# # The script consists of three main functions:

# #     download_contents(arch): Downloads and decompresses the Contents index file for the given architecture (arch).
# #     get_top_packages(contents): Parses the contents of the index file, counts the number of files for each package, and returns the top 10 packages with the most files.
# #     output_stats(top_packages): Prints the top 10 packages and their file counts.

# # To run the script, provide the desired architecture as a command-line argument:

# # bash

# # python script_name.py arch

# # Replace script_name with the actual name of the script and arch with the architecture you want to download the Contents index file for (e.g., amd64, i386, etc.).
