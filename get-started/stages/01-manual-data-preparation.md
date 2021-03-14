# Manual Data Preparation 

The script `src/prepare.py` splits the data into train and test
sets. 

`src/prepare.py`{{open}}

We first run this script without DVC to see what happens:

`python3 src/prepare.py data/data.xml`{{execute}}

It splits the data into train and test sets.

`ls -l data/prepared`{{execute}}

Let's delete the artifacts before reproducing them with DVC.

`rm -fr data/prepared`{{execute}}
