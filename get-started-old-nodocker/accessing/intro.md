Okay, now that we've learned how to track data and models with DVC and how to
version them with Git, next question is:

* How can we use these artifacts outside of the project?
* How do I download a model to deploy it?
* How do I download a specific version of a model?
* How do I reuse datasets across different projects?

> These questions tend to come up when you browse the files that DVC saves to
> remote storage, e.g.
> `s3://dvc-public/remote/get-started/fb/89904ef053f04d64eafcc3d70db673` 😱
> instead of the original files, name such as `model.pkl` or `data.xml`.

Let's learn how any DVC tracked ML model, dataset or file can be accessed:

* From CLI with `dvc get`
* From Python API with `dvc.api.open`
* From another repository with `dvc import`
