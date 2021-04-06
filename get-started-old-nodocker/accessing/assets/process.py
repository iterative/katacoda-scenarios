import dvc.api


count = 0
with dvc.api.open(
        'get-started/data.xml',
        repo='https://github.com/iterative/dataset-registry'
        ) as f:
        for line in f:
            count += 1

print(f"Total number of lines is {count}")
