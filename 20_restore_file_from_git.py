#!/usr/bin/python3.6

from subprocess import check_output, call

file_name = str(input('Enter the file name: '))

commit = check_output(["git", "rev-list", "-n", "1", "HEAD", "--", file_name])
clean_commit = commit.rstrip()
print(clean_commit)

call(["git", "checkout", clean_commit, file_name])
