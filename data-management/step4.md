# Move a tracked file around

1. Let's start tracking again `file1.txt`:

   `dvc add file1.txt`{{execute}}
   
   `tree -a`{{execute}}

   `dvc status`{{execute}}
   
2. If we want to rename `file1.txt` to `file2.txt`, we can try it like
   this:
   
   `mv file1.txt file2.txt`{{execute}}
   
   `mv file1.txt.dvc file2.txt.dvc`{{execute}}
   
   However, the file `file2.txt.dvc` it still tracking `file1.txt`
   (which is encoded in its field `path:`), so it appears like the
   file has been deleted:

   `dvc status`{{execute}}
   
   `cat file2.txt.dvc`{{execute}}
   
   Let's try to fix this by correcting the field `path:`:
   
   `
   sed -i file2.txt.dvc \
       -e s/file1.txt/file2.txt/
   `{{execute}}
       
   `cat file2.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   We see that still there is something not quite right. There is a
   second checksum on `file2.txt.dvc` (besides that of the data file
   `file2.txt`), and that one is out of sync. Let's try this:
   
   `dvc commit file2.txt.dvc`{{execute}}
   
   `dvc status`{{execute}}
   
   `tree -a`{{execute}}
   
   The command `dvc commit` does two things: saves the latest version
   of `file2.txt` to cache (which has not change, so nothing to save),
   and updates the file `file2.txt.dvc`. The second step fixes our
   discrepancy with the checksum.

3. The steps above are long and tedious and error-prone. There is a
   much simpler way for renaming data files. For renaming `file2.txt`
   back to `file1.txt`, we can do this:
   
   `dvc move file2.txt file1.txt`{{execute}}
   
   `tree -a`{{execute}}
   
   `dvc status`{{execute}}
   
   You see that besides the data file it has also renamed the tracking
   file `file2.txt.dvc` to `file1.txt.dvc`, updating its checksum
   accordingly.

4. Besides renaming, `dvc move` can also be used to relocate tracked
   files to another directory, like this:
   
   `mkdir dir1`{{execute}}
   
   `dvc move file1.txt dir1/`{{execute}}
   
   `tree -a`{{execute}}
   
   `dvc status`{{execute}}
   
   For the case of relocating tracked files to another directory
   (without changing their names), a plain `mv` command would work as
   well, as long as we keep the data file and the tracking file in the
   same directory:
   
   `mv dir1/file1.txt .`{{execute}}
   
   `mv dir1/file1.txt.dvc .`{{execute}}
   
   `rmdir dir1/`{{execute}}
   
   `tree -a`{{execute}}
   
   `dvc status`{{execute}}
   
   However it is better to always use `dvc move`, for being
   consistent.
   
5. Note that `dvc move` renames or relocates both files because the
   tracking file has the same name as the data file (with the
   extension `.dvc` appended to it). If this is not the case, then
   only the data file will be renamed:

   `mv file1.txt.dvc file1.dvc`{{execute}}
   
   `ls`{{execute}}
   
   `dvc status`{{execute}}
   
   As a side note, renaming a tracking file doesn't break anything, as
   long as it is not relocated to another directory.
   
   `dvc move file1.txt file2.txt`{{execute}}
   
   `ls`{{execute}}
   
   `dvc status`{{execute}}
   
   So, `file1.dvc` has not been renamed and this has to be done
   manually:
   
   `mv file1.dvc file2.dvc`{{execute}}
   
   `ls`{{execute}}
   
   `dvc status`{{execute}}

   Let's move it back to the original name:
   
   `mv file2.dvc file2.txt.dvc`{{execute}}
   
   `dvc move file2.txt file1.txt`{{execute}}
   
   `dvc status`{{execute}}
   
   `tree -a`
