# Protocol Documentation
<a name="top"></a>

## Table of Contents

- [proto/api/v1/mobile.proto](#proto_api_v1_mobile-proto)
    - [Animal](#platform-api-v1-Animal)
    - [AnimalsRequest](#platform-api-v1-AnimalsRequest)
    - [CoastRequest](#platform-api-v1-CoastRequest)
    - [CoastResponse](#platform-api-v1-CoastResponse)
    - [LocationRequest](#platform-api-v1-LocationRequest)
    - [LocationResponse](#platform-api-v1-LocationResponse)
    - [V1Response](#platform-api-v1-V1Response)
  
    - [Condition](#platform-api-v1-Condition)
  
    - [Bff](#platform-api-v1-Bff)
    - [Internal](#platform-api-v1-Internal)
  
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
| in_danger | [bool](#bool) |  |  |
| description | [string](#string) |  |  |






<a name="platform-api-v1-AnimalsRequest"></a>

### AnimalsRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| location | [LocationResponse](#platform-api-v1-LocationResponse) |  |  |






<a name="platform-api-v1-CoastRequest"></a>

### CoastRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| location | [LocationResponse](#platform-api-v1-LocationResponse) |  |  |






<a name="platform-api-v1-CoastResponse"></a>

### CoastResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  |  |
| condition | [Condition](#platform-api-v1-Condition) |  |  |
| temperature | [float](#float) |  |  |
| distance | [double](#double) |  |  |






<a name="platform-api-v1-LocationRequest"></a>

### LocationRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| ip | [string](#string) |  |  |






<a name="platform-api-v1-LocationResponse"></a>

### LocationResponse
Location


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| longitude | [int32](#int32) |  |  |
| latitude | [int32](#int32) |  |  |
| name | [string](#string) |  |  |






<a name="platform-api-v1-V1Response"></a>

### V1Response
BFF


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| location | [LocationResponse](#platform-api-v1-LocationResponse) |  |  |
| nearest_aquatic_location | [CoastResponse](#platform-api-v1-CoastResponse) |  |  |
| animals | [Animal](#platform-api-v1-Animal) | repeated |  |





 


<a name="platform-api-v1-Condition"></a>

### Condition
Coast

| Name | Number | Description |
| ---- | ------ | ----------- |
| GOOD | 0 |  |
| MODERATE | 1 |  |
| CONTAMINATED | 2 |  |
| UNKNOWN | 3 |  |
| RADIATION | 4 |  |
| DANGER | 5 |  |
| PROTECTED | 6 |  |


 

 


<a name="platform-api-v1-Bff"></a>

### Bff
BFF service

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| GetV1 | [.google.protobuf.Empty](#google-protobuf-Empty) | [V1Response](#platform-api-v1-V1Response) |  |


<a name="platform-api-v1-Internal"></a>

### Internal
Internal service

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| GetAnimals | [AnimalsRequest](#platform-api-v1-AnimalsRequest) | [Animal](#platform-api-v1-Animal) stream |  |
| GetCoast | [CoastRequest](#platform-api-v1-CoastRequest) | [CoastResponse](#platform-api-v1-CoastResponse) |  |
| GetLocation | [LocationRequest](#platform-api-v1-LocationRequest) | [LocationResponse](#platform-api-v1-LocationResponse) |  |

 



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
