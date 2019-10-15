# Setup the workspace

1. Clone the [example repo](https://github.com/iterative/example-get-started)
   from GitHub:

   `git clone https://github.com/iterative/example-get-started`{{execute}}

   `cd example-get-started`{{execute}}
   
   `tree -a -I .git`{{execute}}
   
2. Check the tags (which represent different steps of the project and
   different iterations of solving the problem):
   
   `git tag`{{execute}}

   - `baseline-experiment` -- the first simple version of the model
   - `bigrams-experiment` -- uses bigrams to improve the model
