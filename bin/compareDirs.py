#!/usr/bin/env python

import sys
import os
import re


# -----------------------------------------------------------------------------
def isSourceFile(filename):
    (f, e) = os.path.splitext(filename)
    return e in ['.c', '.cpp', '.cxx', '.cc']

# -----------------------------------------------------------------------------
def isHeaderFile(filename):
    (f, e) = os.path.splitext(filename)
    return e in ['.h', '.hpp']

# -----------------------------------------------------------------------------
def isMakefile(f):
    return f == 'Makefile'

# -----------------------------------------------------------------------------
def shouldBeCompared(f1, f2):

    if isSourceFile(f1) and isSourceFile(f2):
        # only verify filenames without extension
        return os.path.splitext(f1)[0] == os.path.splitext(f2)[0]

    if f1 == f2:
        return isHeaderFile(f1) or isMakefile(f1)

#-------------------------------------------------------------------------------
def fileByFileDiff(dir1, dir2, diffTool="meld"):

    for f1 in os.listdir(dir1):
        for f2 in os.listdir(dir2):
            stop = False

            if shouldBeCompared(f1, f2):
                file1 = os.path.join(dir1, f1)
                file2 = os.path.join(dir2, f2)

                fd1 = open(file1, 'r')
                fd2 = open(file2, 'r')

                if fd1.read() != fd2.read():
                    print "Diffing " + file1 + " and " + file2

                    command = diffTool + " " + file1 + " " + file2
                    retcode = os.system(command)

                    # Traps CTRL-C
                    # 2:   tkdiff, kdiff3
                    # 256: meld

                    if retcode == 2 and diffTool in ['tkdiff', 'kdiff3']:
                        stop = True

                    if retcode == 256 and diffTool in ['meld']:
                        stop = True

                fd1.close()
                fd2.close()

                if stop:
                    print "Aborted"
                    return

# MAIN
# -----------------------------------------------------------------------------

if __name__ == "__main__":

    if len(sys.argv) < 2:
        print "Usage: " + os.path.basename(sys.argv[0]) + "<dir1> <dir2> [<difftool>]"
        sys.exit()

    dir1 = sys.argv[1]
    dir2 = sys.argv[2]

    tool = 'tkdiff'

    if len(sys.argv) > 3 and sys.argv[3] in ['meld', 'kdiff3', 'tkdiff', 'sdiff', 'diff']:
        tool = sys.argv[3]

    if not os.path.isdir(dir1) or not os.path.isdir(dir2):
        sys.exit()

    fileByFileDiff(dir1, dir2, tool)
