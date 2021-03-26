# Manual Data Preparation 

The script `src/prepare.py` splits the data into train and test
sets. 

`example-get-started/src/prepare.py`{{open}}

We first run this script without DVC to see what happens:

`python3 src/prepare.py data/data.xml`{{execute}}

Let's see the output:

`ls -l data/prepared`{{execute}}

We delete the artifacts before reproducing them with DVC.

`rm -fr data/prepared`{{execute}}
