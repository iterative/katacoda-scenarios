# Experiment with bigrams

Let's say that now we want to try a modified feature extraction.  Edit
`src/featurization.py` to enable bigrams and increase the number of
features. Open it with a text editor (`vim` or `nano`) and set
`max_features = 6000` and `ngrams = 2` in global variables at the top (lines 28-29).

It should look like this:

```
max_features = 6000
ngrams = 2
```

This `sed` command does the modification automatically:

```
sed -i src/featurization.py \
    -e 's/max_features = params.*/max_features = 6000/; s/ngrams = params.*/ngrams = 2/'
```{{execute}}

`git status -s`{{execute}}

`git diff src/featurization.py`{{execute}}

`dvc status`{{execute}}

Try to reproduce the last stage:

`dvc repro evaluate`{{execute}}

Notice that it will reproduce the stages `featurize`,
`train` and `evaluate`.

`dvc status`{{execute}}

`dvc repro evaluate`{{execute}}

`dvc metrics show`{{execute}}

Commit changes to git:

`git status -s`{{execute}}

`git diff`{{execute}}

`git add .`{{execute}}

`git commit -m "Using bigrams"`{{execute}}

Set also a new tag:

```
git tag -a "bigrams-experiment" \
    -m "Bigrams experiment"
```{{execute}}
