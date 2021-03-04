# Compare experiments across the tags

In this step we'll update `params.yaml` file by increasing the maximum number of
features from `500` to `2000` and `ngrams` to 2. We'll observe the change in AUC
afterwards.

Now open `params.yaml` in the editor: 

`project/params.yaml`{{open}}

Now click on the next button to update `max_features` value.

<pre class="file" data-filename="project/params.yaml" data-target="insert" data-marker="max_features: 500">
max_features: 2000
</pre>

and the next button to update `ngrams` value:

<pre class="file" data-filename="project/params.yaml" data-target="insert" data-marker="ngrams: 1">
ngrams: 2
</pre>

Now, let's run the pipeline again to get a new model and its metrics: 

`dvc repro`{{execute}}

It runs only the affected parts of the pipeline and writes a new `scores.json`. 

We can get the difference as an ordinary text file with Git: 

`git diff scores.json`{{execute}}

Nevertheless, `dvc metric` output allows making sense of the output better. 

`dvc metrics show`{{execute}}

Before that, we commit the changes and tag the snapshot. 

```
git add params.yaml scores.json prc.json
git commit -m "New experiment with ngrams=2 and max_features=2000"
git tag -a "exp-ngrams=2-features=2000" \
    -m "New experiment with ngrams=2 and max_features=2000"
```{{execute}}

Now we can compare the result of the experiment with the baseline:

`dvc metrics diff -T`{{execute}}

The option `-T, --all-tags` tells it to show the value of the
metric for all the tags. 

In the next step, we'll plot the values to see the change in performance when
we change the maximum features.