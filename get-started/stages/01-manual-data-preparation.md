# Manual Data Preparation 

The script `src/prepare.py` splits the data into train and test sets. (Click links to open in the editor)

`src/prepare.py`{{open}}

We first run this script without DVC to see what happens:

`python3 src/prepare.py data/data.xml`{{execute}}

It splits the data into train and test sets. We check the contents:

`ls -l data/prepared`{{execute}}

We use DVC to automate the tasks required to build a classifier and provide a
fully reproducible pipeline.

Let's delete the artifacts before reproducing them with DVC.

`rm -fr data/prepared`{{execute}}
