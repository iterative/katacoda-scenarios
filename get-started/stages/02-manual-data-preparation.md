# Manual Data Preparation 

The script `src/prepare.py` splits the data into train and test sets. You can
click the link below to open the preparation script in the editor.

`stages/src/prepare.py`{{open}}

We first run this script without DVC to see what happens:

`python3 src/prepare.py data/data.xml`{{execute}}

It splits the data into train and test sets. We check the contents:

`head data/prepared/train.tsv`{{execute}}

`head data/prepared/test.tsv`{{execute}}

Our goal is to create a project that classifies the questions and assigns tags
to them. In a world _without_ DVC tasks like data preparation, training,
testing, evaluation etc. are run manually, and this is prone to errors all we
know from working with too many moving parts.  

We use DVC to automate the tasks required to build a classifier and provide a
fully reproducible pipeline.

Let's delete the artifacts before reproducing them with DVC.

`rm -fr data/prepared`{{execute}}
