# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
# import os
# import sys
# sys.path.insert(0, os.path.abspath('.'))


# -- Project information -----------------------------------------------------

project = 'F5 Volterra WAF 101'
copyright = '2022, Eric Chen'
author = 'Eric Chen'

# The full version, including alpha/beta/rc tags
release = ''


# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
]

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = 'alabaster'

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']

import f5_sphinx_theme
html_theme = 'f5_sphinx_theme'
html_sidebars = {'**': ['searchbox.html', 'localtoc.html', 'globaltoc.html']}
import json

aws_region = "us-west-2"
volterra_tenant = "f5-sales-public"
aws_site = "shared-lab-awsnet"
wildcard_dns = ".aws.lab.f5demos.com"
student_name = "**[your namespace]**"
tenant_domain = "**[your namespace].f5-amer-ent.f5demos.com**"
try:
    f = open('../terraform/terraform.auto.tfvars.json')
    d = json.load(f)
    aws_region = d['aws_region']
except:
    pass
rst_prolog = """
.. |aws_region| replace:: %s
.. |aws_zone| replace:: %sa
.. |student_name| replace:: %s
.. |volterra_tenant| replace:: %s
.. |aws_site| replace:: %s
.. |wildcard_dns| replace:: %s
.. |tenant_domain| replace:: %s
""" %(aws_region,aws_region,student_name,volterra_tenant,aws_site,wildcard_dns, tenant_domain)

