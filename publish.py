import os
import subprocess
import sys

import pystache
import pypandoc
import yaml


def out_file(typ, target, ext="pdf"):
    return "{}_{}.{}".format(typ, target, ext)


def get_args(typ, target):
    with open("{}s/{}.yml".format(typ, target)) as f:
        y = yaml.safe_load(f)

    return y


def render(tpl, typ, trgt):
    args = get_args(typ, trgt)

    out = out_file(typ, trgt)
    with open(out, "w+") as f:
        f.write(pystache.render(tpl, args))
    subprocess.run(['xelatex', out], stdout=subprocess.PIPE)

    for f in (out_file(typ, trgt, ext=f) for f in ['aux', 'log']):
        os.remove(f)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("usage: python publish.py <invoice|offer> <number>")
    if sys.argv[1] not in ["invoice", "offer"]:
        print("Expected invoice or offer, but got ", sys.argv[1])
    else:
        with open("{}.tex".format(sys.argv[1])) as f:
            render(f.read(), sys.argv[1], sys.argv[2])
