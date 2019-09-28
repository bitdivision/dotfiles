#!/usr/bin/env python

import base64, hashlib, sys

if len(sys.argv) != 2 or sys.argv[1] == "-h":
    print("Please run as:\n./gen_pass.py <userid>")
    sys.exit(1)

print(base64.b64encode(hashlib.sha256(sys.argv[1].encode()).digest()))
