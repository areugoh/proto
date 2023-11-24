# Proto

## Release

> **Warning:** Make sure you merged the changelog_* branch into main before releasing

```bash
# Make sure you are in main branch and you have the latest changes
$ git switch main && git fetch --tags

$ make plugin # if you need to build the plugins
$ make dep # will install all of the needed dependencies

$ make release # will create a new release in the client repositories
# if you want to release for a specific client you can do
$ make release/go

# if you want to release for a specific version you can do
$ NEXT_VERSION=vx.x.x make release
```
