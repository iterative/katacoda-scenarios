# Experiment with bigrams

Let's say that now we want to try a modified feature extraction.
Edit `src/featurization.py` to enable bigrams and increase the
number of features. Open it with a text editor (`vim` or `nano`)
and set `max_features=6000` and `ngram_range=(1, 2)` in
`CountVectorizer`, line 78, like this:

```
bag_of_words = CountVectorizer(
    stop_words='english',
    max_features=6000,
    ngram_range=(1, 2))
```

```
sed -i src/featurization.py \
    -e 's/max_features.*/max_features=6000, ngram_range=(1, 2))/'
```{{execute}}

`git status -s`{{execute}}

`git diff src/featurization.py`{{execute}}

`dvc status`{{execute}}

Try to reproduce the last stage:

`dvc repro evaluate.dvc`{{execute}}

Notice that it will reproduce the stages `featurize.dvc`,
`train.dvc` and `evaluate.dvc`.

`dvc status`{{execute}}

`dvc repro evaluate.dvc`{{execute}}

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
