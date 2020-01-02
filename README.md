# Docker MakeMKV

Provides a docker container to convert source ISO or Disk into mkv format using [MakeMKV](http://www.makemkv.com/), with a prompt for which title to use.

# Usage

## Building the container

The container requires a version number for the [MakeMKV](http://www.makemkv.com/) version to be used, as new versions become available the container needs to be rebuilt.

Version can be supplied as follows:
```bash
docker build --build-arg makemkv_version=1.14.7 --tag makemkv .
```

# Running the container

When running the container there are 3 required parameters:
- Volume **/iso_in**: provide a volume containing the source (ISO or Disk)
- Volume **/iso_out**: provide a volume to contain the resulting MKV
- Environment Variable **SOURCE_TYPE**: Source type, should be one of *file* or *disk*

```bash
docker run -v /path/to/input:/iso_in -v /path/to/output:/iso_out -e SOURCE_TYPE=file -it makemkv
```

Once MakeMKV has scanned the source, a list of titles will be available, and the container will wait for an input specifying which title to proceed with (Currently only one title can be selected)
