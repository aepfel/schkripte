#!/bin/bash
echo $SHELL
echo $BASH_VERSION
venvname="venv"
pipd="./$venvname/bin"
progs=(Flask Flask-Script Jinja2 MarkupSafe Werkzeug==0.16.0 itsdangerous Flask-SQLAlchemy image)
#create venv
python3 -m venv --without-pip $venvname

#get pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
$pipd/python3 get-pip.py

#install modules
for p in "${progs[@]}"
do
	echo "$p"
	$pipd/pip install $p
done
#clean
rm get-pip.py

#source pyinterpret/bin/activate


