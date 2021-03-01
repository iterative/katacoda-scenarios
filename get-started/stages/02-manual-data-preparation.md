# Manual Data Preparation 

The script `src/prepare.py` splits the data into datasets for training and
testing. You can click the button to open the file in the editor.

`stages/src/prepare.py`{{open}}

As a next step, we build a stage based on this script. Let's see what happens
when we run the script:

`python3 src/prepare.py data/data.xml`{{execute}}

It splits the data into datasets for training and testing. We check the
contents:

`head data/prepared/train.tsv`{{execute}}

`head data/prepared/test.tsv`{{execute}}

Our goal is to create a project that classifies the questions and assigns tags
to them. This is a sample of Stack Overflow data. We use DVC to automate such
tasks and provide fully reproducible data and pipeline repositories.

