#!/bin/bash
# A bash script to start a new python project

if [ $# -ne 1 ];
then
	echo 'Error! project name not supplied: npp [name_project]'
	exit 1
fi

#Files content

gitignore_content='venv\n*.pyc'
setup_content='#!usr/bin/env python\nraise NotImplementedError("Setup not implemented yet.")'

#-----------------------------------------------------------------------------------------------
# DIRECTORY STRUCTURE
#-----------------------------------------------------------------------------------------------

#\project
#	\project
#		\domain
#			\core
#			\model
#			\service
#			\factory
#		\application
#		\infrastructure
#			\interface
#			\persistence
#	\bin
#	\docs
#	\fixtures
#	\tests

#Creating project folders
mkdir $1
cd $1

mkdir $1 bin docs fixtures tests
cd $1
mkdir domain application infrastructure
cd domain
mkdir core model service factory
cd ..
cd infrastructure
mkdir interface persistence
cd ../..

#-----------------------------------------------------------------------------------------------
# VIRTUAL ENVIRONMENT
#-----------------------------------------------------------------------------------------------

#Virtualenv initialization
virtualenv -p /usr/bin/python3 venv
source venv/bin/activate

#-----------------------------------------------------------------------------------------------
# TESTING
#-----------------------------------------------------------------------------------------------

#installi testing tools
pip install pytest
pip install pytest-cov


#-----------------------------------------------------------------------------------------------
# DOCUMENTATION
#-----------------------------------------------------------------------------------------------

#generating the documentation
#add an index.rst and conf.py in my docs directory
sphinx-quickstart -q --p $1 -a ciherraiz -v 0.0 docs


#-----------------------------------------------------------------------------------------------
# CONFIGURATION FILES
#-----------------------------------------------------------------------------------------------

#creating __init__.py files for packages
touch $1/__init__.py 
touch $1/domain/__init__.py 
touch $1/domain/core/__init__.py $1/domain/model/__init__.py $1/domain/service/__init__.py $1/domain/factory/__init__.py


#creating README.md
touch README.md 

#creating LICENSE.txt
touch LICENSE.txt 

#creating [project]-admin.py
touch bin/$1-admin.py

#creating setup file

cat > setup.py << EOF

"""A setuptools based setup module.
See:
https://packaging.python.org/en/latest/distributing.html
https://github.com/pypa/sampleproject
"""

# Always prefer setuptools over distutils
from setuptools import setup, find_packages
# To use a consistent encoding
from codecs import open
from os import path

here = path.abspath(path.dirname(__file__))

# Get the long description from the relevant file
with open(path.join(here, 'README.md'), encoding='utf-8') as f:
    long_description = f.read()

setup(
    name='$1',
    version='0.0.0',
    description='$1 project description',
    long_description=long_description,
    url='https://github.com/ciherraiz/$1',
    author='ciherraiz',
    author_email='ciherraiz@yahoo.es',
    license='MIT',

    classifiers=[
        'Development Status :: 3 - Alpha',
	'License :: OSI Approved :: MIT License',
	'Programming Language :: Python :: 3.4',
    ],

    keywords='$1',
    packages=['$1'],
)
EOF

#creating egg.link and develop eggs to become global available 

python setup.py develop

#creating others files
touch README.md LICENSE.txt bin/$1-admin.py



#creating requirements.txt
pip freeze > requirements.txt


#-----------------------------------------------------------------------------------------------
# VERSION CONTROL SYSTEM
#-----------------------------------------------------------------------------------------------

#Git initialization
git init
echo -e $gitignore_content > .gitignore


#first commit

git add README.md LICENSE.txt requirements.txt setup.py
git add docs/Makefile docs/conf.py docs/index.rst
git add bin/$1-admin.py
git add $1/__init__.py $1/domain/__init__.py 
git add $1/domain/core/__init__.py $1/domain/model/__init__.py $1/domain/service/__init__.py $1/domain/factory/__init__.py
git commit -am 'Initial repository setup'
git status

git remote add origin https://github.com/ciherraiz/npp.git
git push -u origin master 
