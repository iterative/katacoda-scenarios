#!/bin/bash
set -o verbose

##### get the search term and create a directory for it
search_term=${1:-diff}
rm -rf $search_term
mkdir $search_term
cd $search_term

##### get the root directory of the workspace
root=$(dvc root)

##### don't execute any commands yet, just (re)define the pipeline
extra_options="--no-exec --overwrite-dvcfile"

##### db_status.dvc: count the number of records in the database
sql="sqlite3 ~/data.sqlite"
query="SELECT COUNT(*) FROM files;"
dvc run \
    -f db_status.dvc \
    -O db_status.txt \
    $extra_options \
    "$sql '$query' > db_status.txt"

##### db.dvc download the data from the database
query="SELECT name FROM files;"
dvc run \
    -f db.dvc \
    -d db_status.txt \
    -o data3.txt \
    $extra_options \
    "$sql '$query' > data3.txt"

##### stage1.dvc: concatenate the data files
dvc run \
    -f stage1.dvc \
    -d $root/data1.txt \
    -d $root/data2.txt \
    -d data3.txt \
    -o joint-list.txt \
    $extra_options \
    "cat $root/data1.txt $root/data2.txt data3.txt > joint-list.txt"

##### stage2.dvc: sort the data
dvc run \
    -f stage2.dvc \
    -d joint-list.txt \
    -o sorted-list.txt \
    $extra_options \
    'sort --unique joint-list.txt > sorted-list.txt'

##### stage3.dvc: find the results and the metrics
dvc run \
    -f stage3.dvc \
    -d sorted-list.txt \
    -o result.txt \
    -M count.txt \
    $extra_options \
    "grep $search_term sorted-list.txt > result.txt \
     && cat result.txt | wc -l > count.txt"
