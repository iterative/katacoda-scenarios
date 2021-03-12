# Associate variables with stages

To measure the effects of parameter changes, DVC tracks them as another
factor in stages. Parameters have their own block `params` in `dvc.yaml`.

You can view `dvc.yaml` by clicking the link below. (Please do not change
anything as we'll edit it automatically.)

`dvc.yaml`{{open}}

Now we'll add the following section in place of the `# PREPARE PARAMS` comment:

<pre class="file" data-filename="dvc.yaml" data-target="insert" data-marker="# PREPARE PARAMS">
params:
    - prepare.split
    - prepare.seed
</pre>

For featurization, we have two other parameters: 

<pre class="file" data-filename="dvc.yaml" data-target="insert" data-marker="# FEATURIZE PARAMS">
params:
    - featurize.max_features
    - featurize.ngrams
</pre>

Run the pipeline again and see the effects of these changes on `dvc.lock`:

`dvc repro`{{execute}}

Diffing `dvc.lock`, you can see how the parameter values are tracked:

`git diff dvc.lock`{{execute}}

(You can quit from diff by pressing `q`)

Note that we didn't specify parameter values in `dvc.yaml`. DVC retrieved them
from `params.yaml` and begin tracking in `dvc.lock`.

As the last step, we add and commit the changes to the repository.

```
git add dvc.yaml dvc.lock

git commit -m "Added parameters to pipeline"
```{{execute}}
