# Proto
> :books: **More information**: visit the Docs Registry

## Release

1. Run [Release new version](https://github.com/garajonai/proto/actions/workflows/changelog-tag.yaml) workflow.
   1. Provide a new version or let the workflow determine the next minor version.
2. Create and approve a new PR with the changelog file from the release branch with the `changelog_vM.m.p` format.
3. Merge the PR to the main branch.

## Pseudo version

Any PR with the `pseudo-version` label will trigger a pseudo version release.
