# Congratulations!

In this scenario, we learned how to access data registries via DVC. We can
download model and data files with `dvc get` or import them to DVC repositories
with `dvc import`. DVC also has an API that streams large files directly into
the memory with `dvc.api.open`. 

DVC allows to have a central registry for all the data and model files and
using them in different projects. It's based on Git, and provides flexibility
without requiring additional infrastructure. 

<p align="center">
<img src="/dvc/courses/get-started/accessing/assets/data-registry.png">
</p>

If you want to read more about the workflow, refer to the
[Data Registries](https://dvc.org/doc/use-cases/data-registries) use case.
