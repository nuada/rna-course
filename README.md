# Usage

## Docker
Command to create new container:
```
[[ -d $(pwd)/tmp ]] || mkdir $(pwd)/tmp
exec docker run -i -t \
        --name rna-course \
        --volume=$(pwd):/home/docker \
        --volume=$(pwd)/tmp:/tmp \
        ubuntu:14.04 bash
```

To configure container execute `apply` script:
```
root@xxxxxxxxxxxx:/# /home/docker/apply
```
