#!/usr/bin/python
import inspect as i


def ii(obj):
    for p in dir(obj):
        print p
        i.getdoc(obj.__getattribute__(p))
