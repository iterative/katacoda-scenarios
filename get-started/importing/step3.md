# Update the imported file:

If we want to check whether there is any new version of the imported
file, and if yes download it again, we can use `dvc update`:
   
`dvc status data.xml.dvc`{{execute}}
   
`dvc update data.xml.dvc`{{execute}}

In this case there is no change and nothing is downloaded.
   
The file `data.xml.dvc`, which is created by `dvc import`, is
_locked_, which means that DVC will not try to refresh its data file
(`data.xml`). So the only way to update this data file is with `dvc
update`.
