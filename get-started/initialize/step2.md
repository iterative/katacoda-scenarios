# Install DVC

`snap install --classic dvc`{{execute}}

`dvc version`{{execute}}

> DVC provides other ways to install it - `pip`, `conda`, self-contained
> packages. Please, refer to the [install](https://dvc.org/doc/install) page.

**Optional:** Install bash completion for `dvc`:

```
dvc completion -s bash | sudo tee /etc/bash_completion.d/dvc
```{{execute}}

`source /etc/bash_completion`{{execute}}

Now you can use `Tab` key to learn available commands and options. Please type
`dvc ` (with space) and press `Tab` key to see a list of possible commands. 

We'll learn all these commands in the upcoming scenarios! 
