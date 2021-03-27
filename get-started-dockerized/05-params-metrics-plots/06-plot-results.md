# Plotting experiment results

DVC has a language-agnostic way of producing plots using [Vega-Lite][vegalite].
In the previous step we asked `dvc stage add` to store precision, recall and
thresholds to `prc.json`, and ROC points to `roc.json`.

These are JSON files produced by `evaluate.py` to show the performance
characteristics of the classifier.

[vegalite]: https://vega.github.io/vega-lite/

Before viewing the plots, we specify the plot axes. We need to this only once,
and DVC saves the plot configuration.

```
dvc plots modify prc.json -x recall -y precision
dvc plots modify roc.json -x fpr -y tpr 
```{{execute}}

Let's produce the plots for the current parameters with

`dvc plots show`{{execute}}

You can view `plots.html` file you have generated here:

https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/example-get-started/plots.html

DVC can also generate plots to show the change across commits. 

`dvc plots diff`{{execute}}

This shows the effect of the updated parameters across commits. The generated file is
the same and can be viewed at the same URL. 

https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/example-get-started/plots.html

