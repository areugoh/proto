# Client-rust

> **Warning:** This repository is automatically generated. Please don't make any changes here.

This repository contains the client libraries for the [garajonai](https://github.com/garajonai) services.
It's **automatically generated** from the [proto](https://github.com/garajonai/proto) repository.

## Installation

> **Note:** You can see the latest version [here](https://github.com/garajonai/client-rust/tags).

```bash
$ cargo add --git ssh://git@github.com:garajonai/client-rust.git --tag v1.0.0
```

Your Cargo file should looks like this with `workspaces`:

```toml
[package]
name = "example"
version = "0.1.0"
edition = "2021"

[dependencies]
client-rust = { git = "ssh://git@github.com:garajonai/client-rust.git", tag = "v1.0.0" }

[workspace]
members = [ "client-rust" ]
```
