# Compare experiments across the tags

In this step, we'll update `params.yaml` file by increasing the maximum number of
features from `500` to `1500` and `ngrams` to 2. We'll observe the change in metrics
afterwards.

Now open `params.yaml` in the editor: 

`example-get-started/params.yaml`{{open}}

Now click on the next button to update `max_features` value.

<pre class="file" data-filename="project/params.yaml" data-target="insert" data-marker="max_features: 500">
max_features: 1500
</pre>

and also update `ngrams` value:

<pre class="file" data-filename="project/params.yaml" data-target="insert" data-marker="ngrams: 1">
ngrams: 2
</pre>

We use `dvc params diff` to observe the change in params:

`dvc params diff`{{execute}}

Now, let's run the pipeline again to get a new model and its metrics: 

`dvc repro`{{execute}}

It runs only the affected parts of the pipeline and writes a new `scores.json`. 

Let's see the current metrics with:

`dvc metrics show`{{execute}}

We can get the difference as an ordinary text file with Git: 

`git diff scores.json`{{execute}}

Nevertheless, `dvc metric` output allows making sense of the output much better.

`dvc metrics diff`{{execute}}

Before that, we commit the changes and tag the snapshot.

```
git add params.yaml scores.json prc.json
git commit -m "New experiment with ngrams=2 and max_features=1500"
git tag -a "exp-ngrams=2-features=1500" \
    -m "New experiment with ngrams=2 and max_features=1500"
```{{execute}}

In the next step, we'll plot the values to see the change in performance when
we change the maximum features.
