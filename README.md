# alpine-edit

[Microsoft edit](https://devblogs.microsoft.com/commandline/edit-is-now-open-source/) packaged as a Docker container to run on a Mac

To run `edit` against the files in your current directory, run this:
```bash
docker run --platform linux/arm64 -it --rm -v $(pwd):/workspace ghcr.io/simonw/alpine-edit
```
