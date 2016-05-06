#!/usr/bin/env python
from __future__ import print_function
from setuptools import setup
from setuptools.extension import Library
from distutils.command.build import build
from distutils.command.install_lib import install_lib
from distutils.command.clean import clean
from distutils.cmd import Command
import sys
import os
import subprocess

try:
    import fontTools
except:
    print("*** Warning: compreffor requires fontTools, see:")
    print("    https://github.com/behdad/fonttools")

CURR_DIR = os.path.abspath(os.path.dirname(os.path.realpath(__file__)))
CXX_SOURCES = os.path.join(CURR_DIR, 'cxx-src')

setup(
    name="compreffor",
    version="0.1.0",
    description="A CFF subroutinizer for fontTools.",
    author="Sam Fishman",
    license="Apache 2.0",
    packages=["compreffor"],
    ext_modules=[
        Library(
            "compreffor.compreff",
            sources=[
                os.path.join(CXX_SOURCES, "cffCompressor.cc"),
                ],
            extra_compile_args=[
                "-std=c++0x", "-fopenmp", "-W", "-Wall", "-Wno-unused",
                "-Wno-unused-parameter", "-g",
            ],
            extra_link_args=["-fopenmp"],
            define_macros=[('DEBUG', None),],
            export_symbols=["compreff", "unload"],
            depends=[
                os.path.join(CXX_SOURCES, "cffCompressor.h"),
            ],
            language="c++",
        ),
    ],
    zip_safe=False,
)
