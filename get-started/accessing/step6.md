# Data, model, artifact registries

No commands to run or try here. We just want to zoom out now and show one of the
possible scenarios DVC enables with the commands like `dvc get`, `dvc import`,
and `dvc.api`.

The idea is to use one or more dedicated Git (DVC-enabled) repositories to keep
and update models, datasets, or any artifacts for that sake. They are being
used in other projects, in production, etc:

<p align="center">
<img src="/dvc/courses/get-started/accessing/assets/data-registry.png">
</p>

It's based on Git and Git workflow to provide the versioning mechanism, it's
simple in a sense that no additional infrastructure required (no databases,
no external proprietary services). It's flexible - since we can store datasets,
intermediate results, models it means that the same mechanism covers data
registries, model zoos, feature stores.

If you want to read more about the benefits, the workflow, refer to the
[Data Registries](https://dvc.org/doc/use-cases/data-registries) use case.
