---
title: Pseudo version
description: Example of a pseudo version release comment in a PR
---

#### $(PSEUDO_VERSION)
Your pseudo version `$(PSEUDO_VERSION)` is ready to use!
Follow the instructions in the README.md of each client to use it.

- :hamster: **GO**: https://github.com/garajonai/client-go/releases/tag/$(PSEUDO_VERSION)
- :crab: **RUST**: https://github.com/garajonai/client-rust/releases/tag/$(PSEUDO_VERSION)
- :penguin: **NODEJS**: https://github.com/garajonai/client-nodejs/tree/$(PSEUDO_VERSION)

> :warning: **WARNING**: This version is not stable and can be changed at any time.
> To recreate this version, remove the `pseudo-version` label from the PR and add it again.
