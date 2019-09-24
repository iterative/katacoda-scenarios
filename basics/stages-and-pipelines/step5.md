# Build pipeline with script

In the previous steps we have used some long `dvc run` commands, with
lots of options, to define stages. Sometimes we also had to redefine
some stages in order to fix or improve something. Doing all this
manually is long and tedious and error-prone. The recommended Linux
practice in such cases is to record all the commands in a bash script,
which can then be used to build the whole pipeline at once.

Some of the benefits of this approach are these:
- Typing mistakes while building the pipeline are avoided.
- Modification of the pipeline becomes easier and consistent (using
  find/replace).
- Building pipelines becomes flexible (bash variables can be used).
- Pipelines become reusable (other projects can copy/paste and
  customize them)

