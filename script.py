#!/usr/bin/python3
import os
import base64
import shutil
def main():
    os.chdir("/home/loki/chunks")
    os.mkdir("/home/loki/<temporary-directory>")
    os.mkdir("/home/loki/<temporary-directory>/fake")
    for count, filename in enumerate(os.listdir("/home/loki/chunks")):
        if filename != "index":
            full_filename = str(filename)
            srcDir = "/home/loki/chunks"
            dstDir = "/home/loki/<temporary-directory>"
            b64_filename = base64.b64decode(full_filename)
            b64_filename = b64_filename.decode("utf-8")
            src = f"{srcDir}/{full_filename}"
            dst = f"{dstDir}/{b64_filename}"
            shutil.copyfile(src,dst)
            #os.rename(src, dst)
if __name__ == '__main__':
    main()