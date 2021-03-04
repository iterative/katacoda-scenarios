# Associate variables with stages

In order to measure the effects of parameter changes, DVC tracks them as another
factor in stages. Parameters have their own block `params` in `dvc.yaml`.

You can view `dvc.yaml` by clicking the link below. (Please do not change
anything as we'll edit it automatically.)

`project/dvc.yaml`{{open}}

Now we'll add the following section in place of the comment in `dvc.yaml` for
params in
`prepare.py`.

<pre class="file" data-filename="project/dvc.yaml" data-target="insert" data-marker="# PREPARE PARAMS">
params:
    - split
    - seed
</pre>

For featurization, we have two other variables: 


<pre class="file" data-filename="project/dvc.yaml" data-target="insert" data-marker="# FEATURIZE PARAMS">
params:
    - max_features
    - ngrams
</pre>

Let's run the pipeline again and see the effects of these changes on `dvc.lock`:

`dvc repro`{{execute}}

Diffing `dvc.lock`, you can see how the parameter values are tracked:

`git diff dvc.lock`{{execute}}

Note that, we didn't specify parameters values in `dvc.yaml`. DVC retrieved them
from `params.yaml` and begin tracking. 

As a last step we add and commit the changes in the repository.

```
git add dvc.yaml dvc.lock
git commit -m "Added parameters to pipeline"
```