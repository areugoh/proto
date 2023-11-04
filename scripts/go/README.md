# Client-go

## Installation

> **Note:** You can see the latest version [here](https://github.com/areugoh/client-go/tags).

```bash
$ go get github.com/areugoh/client-go@vx.x.x
# or if you already have it in your go.mod but you want to update it
$ go get -u github.com/areugoh/client-go@vx.x.x
```

## Usage

> **Note:** You can see the proto docs in each package. For example, [here](https://github.com/areugoh/proto/blob/main/proto/greenspace/api/v1/README.md).

```go
package main

import (
    "fmt"
    "log"

    # inporting greenspace namespace as an example
	pb "github.com/areugoh/client-go/greenspace/api/v1"
)

func main() {
    # ... create client ...

    # create a new request
    req := &pb.CoastRequest{
        Location: &pb.LocationResponse{
            Longitude: 35.4729335,
            Latitude:  139.6146366,
            Name:      "Yokohama",
        },
    }

    # send the request to the server
    res, err := client.GetCoast(ctx, req)
    if err != nil {
        log.Fatalf("Failed to create greenspace: %v", err)
    }

    # print the response
    fmt.Println(res)
}
```
