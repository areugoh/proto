# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [proto/api/v1/mobile.proto](#proto_api_v1_mobile-proto)
    - [Animal](#platform-api-v1-Animal)
    - [AnimalsRequest](#platform-api-v1-AnimalsRequest)
    - [AnimalsResponse](#platform-api-v1-AnimalsResponse)
    - [AreaRequest](#platform-api-v1-AreaRequest)
    - [AreaResponse](#platform-api-v1-AreaResponse)
    - [Location](#platform-api-v1-Location)
    - [LocationRequest](#platform-api-v1-LocationRequest)
    - [LocationResponse](#platform-api-v1-LocationResponse)
    - [V1Response](#platform-api-v1-V1Response)
  
    - [Condition](#platform-api-v1-Condition)
  
    - [API](#platform-api-v1-API)
  
- [Scalar Value Types](#scalar-value-types)



<a name="proto_api_v1_mobile-proto"></a>
<p align="right"><a href="#top">Top</a></p>

## proto/api/v1/mobile.proto



<a name="platform-api-v1-Animal"></a>

### Animal
Animals


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  |  |
| inDanger | [bool](#bool) |  |  |
| description | [string](#string) |  |  |






<a name="platform-api-v1-AnimalsRequest"></a>

### AnimalsRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| location | [Location](#platform-api-v1-Location) |  |  |






<a name="platform-api-v1-AnimalsResponse"></a>

### AnimalsResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| animals | [Animal](#platform-api-v1-Animal) | repeated |  |






<a name="platform-api-v1-AreaRequest"></a>

### AreaRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| location | [Location](#platform-api-v1-Location) |  |  |






<a name="platform-api-v1-AreaResponse"></a>

### AreaResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  |  |
| condition | [Condition](#platform-api-v1-Condition) |  |  |
| temperature | [float](#float) |  |  |
| distance | [double](#double) |  |  |






<a name="platform-api-v1-Location"></a>

### Location
Location


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| longitude | [int32](#int32) |  |  |
| latitude | [int32](#int32) |  |  |
| name | [string](#string) |  |  |






<a name="platform-api-v1-LocationRequest"></a>

### LocationRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| ip | [string](#string) |  |  |






<a name="platform-api-v1-LocationResponse"></a>

### LocationResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| location | [Location](#platform-api-v1-Location) |  |  |






<a name="platform-api-v1-V1Response"></a>

### V1Response
BFF


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| location | [Location](#platform-api-v1-Location) |  |  |
| nearestAquaticLocation | [AreaResponse](#platform-api-v1-AreaResponse) |  |  |
| animals | [Animal](#platform-api-v1-Animal) | repeated |  |





 


<a name="platform-api-v1-Condition"></a>

### Condition
Area

| Name | Number | Description |
| ---- | ------ | ----------- |
| GOOD | 0 |  |
| MODERATE | 1 |  |
| CONTAMINATED | 2 |  |
| UNKNOWN | 3 |  |
| RADIATION | 4 |  |
| DANGER | 5 |  |
| PROTECTED | 6 |  |


 

 


<a name="platform-api-v1-API"></a>

### API
Service

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| GetAnimals | [AnimalsRequest](#platform-api-v1-AnimalsRequest) | [AnimalsResponse](#platform-api-v1-AnimalsResponse) | Internal |
| GetArea | [AreaRequest](#platform-api-v1-AreaRequest) | [AreaResponse](#platform-api-v1-AreaResponse) |  |
| GetLocation | [LocationRequest](#platform-api-v1-LocationRequest) | [LocationResponse](#platform-api-v1-LocationResponse) |  |
| GetV1 | [.google.protobuf.Empty](#google-protobuf-Empty) | [V1Response](#platform-api-v1-V1Response) | BFF |

 



## Scalar Value Types

| .proto Type | Notes | C++ | Java | Python | Go | C# | PHP | Ruby |
| ----------- | ----- | --- | ---- | ------ | -- | -- | --- | ---- |
| <a name="double" /> double |  | double | double | float | float64 | double | float | Float |
| <a name="float" /> float |  | float | float | float | float32 | float | float | Float |
| <a name="int32" /> int32 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="int64" /> int64 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="uint32" /> uint32 | Uses variable-length encoding. | uint32 | int | int/long | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="uint64" /> uint64 | Uses variable-length encoding. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum or Fixnum (as required) |
| <a name="sint32" /> sint32 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sint64" /> sint64 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="fixed32" /> fixed32 | Always four bytes. More efficient than uint32 if values are often greater than 2^28. | uint32 | int | int | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="fixed64" /> fixed64 | Always eight bytes. More efficient than uint64 if values are often greater than 2^56. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum |
| <a name="sfixed32" /> sfixed32 | Always four bytes. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sfixed64" /> sfixed64 | Always eight bytes. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="bool" /> bool |  | bool | boolean | boolean | bool | bool | boolean | TrueClass/FalseClass |
| <a name="string" /> string | A string must always contain UTF-8 encoded or 7-bit ASCII text. | string | String | str/unicode | string | string | string | String (UTF-8) |
| <a name="bytes" /> bytes | May contain any arbitrary sequence of bytes. | string | ByteString | str | []byte | ByteString | string | String (ASCII-8BIT) |

