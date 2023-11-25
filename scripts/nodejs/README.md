# Client-nodejs

> **Warning:** This repository is automatically generated. Please don't make any changes here.

This repository contains the client libraries for the [areugoh](https://github.com/areugoh) services.
It's **automatically generated** from the [proto](https://github.com/areugoh/proto) repository.

## Installation

Update your `~/.npmrc` file to include the following line.

```bash
# ~/.npmrc
registry=https://registry.npmjs.org/
@areugoh:registry=https://npm.pkg.github.com/
//npm.pkg.github.com/:_authToken=<MD_TO_REQUEST_TOKEN>
```
Then install the package.

```bash
$ npm install @areugoh/client-nodejs@latest
```

## Usage

> **Note:** You can see the proto docs in each package. For example, [here](https://github.com/areugoh/proto/blob/main/proto/greenspace/api/v1/README.md).

```javascript
import { credentials } from "@grpc/grpc-js";
import { GreenSpaceClient } from '@areugoh/client-nodejs/proto/greenspace/api/v1/mobile_grpc_pb';

const client = new GreenSpaceClient('localhost:50051', credentials.createInsecure());
// ...
```

For more detailed example check [grpc_tools_node_protoc_ts client.js](https://github.com/agreatfool/grpc_tools_node_protoc_ts/blob/v5.0.0/examples/src/grpcjs/client.ts).
