# Proto

## Release

Release new version by executing [Release new version](https://github.com/areugoh/proto/actions/workflows/changelog-tag.yaml) workflow.

- If the `new_version` is omitted, the workflow will try to determine the new version based on the latest tag. It will increment the minor version by default.
- If the `new_version` is provided, the workflow will create a new tag with the provided version.

The workflow will create a new tag and a new release branch with a changelog file. The branch will be named `changelog_vM.m.p`.
When the PR is created, approve and merge it to the main branch, the workflow will create a new release for all the protobuf clients.

### Steps

1. Run [Release new version](https://github.com/areugoh/proto/actions/workflows/changelog-tag.yaml) workflow.
   1. Provide a new version or let the workflow determine the next minor version.
2. Create and approve a new PR with the changelog file from the release branch with the `changelog_vM.m.p` format.
3. Merge the PR to the main branch.

## Pseudo version

Any PR with the `pseudo-version` label will trigger a pseudo version release. The pseudo version will be based on the PR's merge commit SHA.
The version will be in the format of `vM.m.p-pre.<sha>`, where `<sha>` is the short SHA of the commit.

If the pseudo version is successfully released, the workflow will comment on the PR with the pseudo version links of
all the client:

---

#### $(PSEUDO_VERSION)
Your pseudo version `$(PSEUDO_VERSION)` is ready to use!
Follow the instructions in the README.md of each client to use it.

- :hamster: **GO**: https://github.com/areugoh/client-go/releases/tag/$(PSEUDO_VERSION)
- :crab: **RUST**: https://github.com/areugoh/client-rust/releases/tag/$(PSEUDO_VERSION)
- :penguin: **NODEJS**: https://github.com/areugoh/client-nodejs/tree/$(PSEUDO_VERSION)

> :warning: **WARNING**: This version is not stable and can be changed at any time.
> To recreate this version, remove the `pseudo-version` label from the PR and add it again.

---

## OpenAPI

As part of the BFF, we need to generate an OpenAPI spec for the REST API.
A new version of the documentation will be generated on every new tag with `vM.m.p` format.
The documentation will be available in [gh-pages](https://areugoh.github.io/proto), where you could search for any server in the proto library.

We only generate the documentation for the latest version so you won't be able to search for any of the previous or pseudo versions.
