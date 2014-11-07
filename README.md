# Usage

## Ubuntu 14.04
To configure Ubuntu 14.04 use command:
```
curl https://raw.githubusercontent.com/nuada/rna-course/master/apply | bash -s
```

## Docker
Create image:
```
docker build -t nuada/rna-course .
```

Create new container:
```
docker run -t -i nuada/rna-course
```

When using large datasets, all files should be stored outside container:
```
docker run -t -i --volume=/data:/data nuada/rna-course
```
