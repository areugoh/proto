# Documentation
<a name="top"/>


## Reference

[hoguera/platform/proto/greenspace/api/v1/mobile.proto](#hoguera/platform/proto/greenspace/api/v1/mobile.proto)
<details>
<summary>Click to show</summary>

### Messages
  - [Animal](#hoguera.platform.greenspace.api.v1.Animal)
  - [AnimalsRequest](#hoguera.platform.greenspace.api.v1.AnimalsRequest)
  - [CoastRequest](#hoguera.platform.greenspace.api.v1.CoastRequest)
  - [CoastResponse](#hoguera.platform.greenspace.api.v1.CoastResponse)
  - [LocationRequest](#hoguera.platform.greenspace.api.v1.LocationRequest)
  - [LocationResponse](#hoguera.platform.greenspace.api.v1.LocationResponse)
  - [V1Response](#hoguera.platform.greenspace.api.v1.V1Response)

### Enums
  - [Condition](#hoguera.platform.greenspace.api.v1.Condition)


</details>



## Services


<a name="hoguera.platform.greenspace.api.v1.Bff"/>

### Bff
BFF service

| Method Name | Description |
| ----------- | ------------|
| `GetV1` <br /><br /> Request: [.google.protobuf.Empty](#google.protobuf.Empty) <br /> Response: [V1Response](#google.protobuf.Empty) | <para></para> |


<a name="hoguera.platform.greenspace.api.v1.Internal"/>

### Internal
Internal service

| Method Name | Description |
| ----------- | ------------|
| `GetAnimals` <br /><br /> Request: [AnimalsRequest](#hoguera.platform.greenspace.api.v1.AnimalsRequest) <br /> Response: [Animal](#hoguera.platform.greenspace.api.v1.AnimalsRequest) | <para></para> |
| `GetCoast` <br /><br /> Request: [CoastRequest](#hoguera.platform.greenspace.api.v1.CoastRequest) <br /> Response: [CoastResponse](#hoguera.platform.greenspace.api.v1.CoastRequest) | <para></para> |
| `GetLocation` <br /><br /> Request: [LocationRequest](#hoguera.platform.greenspace.api.v1.LocationRequest) <br /> Response: [LocationResponse](#hoguera.platform.greenspace.api.v1.LocationRequest) | <para></para> |

 <!-- end services -->
 <!-- end files -->



<a name="hoguera/platform/proto/greenspace/api/v1/mobile.proto"/>
<p align="right"><a href="#top">Top</a></p>

## hoguera/platform/proto/greenspace/api/v1/mobile.proto



<a name="hoguera.platform.greenspace.api.v1.Animal"/>

### Animal
Animals


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | <para></para> |
| in_danger | [bool](#bool) |  | <para></para> |
| description | [string](#string) |  | <para></para> |




<a name="hoguera.platform.greenspace.api.v1.AnimalsRequest"/>

### AnimalsRequest
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| location | [LocationResponse](#hoguera.platform.greenspace.api.v1.LocationResponse) |  | <para></para> |




<a name="hoguera.platform.greenspace.api.v1.CoastRequest"/>

### CoastRequest
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| location | [LocationResponse](#hoguera.platform.greenspace.api.v1.LocationResponse) |  | <para></para> |




<a name="hoguera.platform.greenspace.api.v1.CoastResponse"/>

### CoastResponse
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | <para></para> |
| condition | [Condition](#hoguera.platform.greenspace.api.v1.Condition) |  | <para></para> |
| temperature | [float](#float) |  | <para></para> |
| distance | [double](#double) |  | <para></para> |




<a name="hoguera.platform.greenspace.api.v1.LocationRequest"/>

### LocationRequest
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| ip | [string](#string) |  | <para></para> |




<a name="hoguera.platform.greenspace.api.v1.LocationResponse"/>

### LocationResponse
Location


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| longitude | [int32](#int32) |  | <para></para> |
| latitude | [int32](#int32) |  | <para></para> |
| name | [string](#string) |  | <para></para> |




<a name="hoguera.platform.greenspace.api.v1.V1Response"/>

### V1Response
BFF


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| location | [LocationResponse](#hoguera.platform.greenspace.api.v1.LocationResponse) |  | <para></para> |
| nearest_aquatic_location | [CoastResponse](#hoguera.platform.greenspace.api.v1.CoastResponse) |  | <para></para> |
| animals | [Animal](#hoguera.platform.greenspace.api.v1.Animal) | repeated | <para></para> |







<a name="hoguera.platform.greenspace.api.v1.Condition"/>

### Condition
Coast


<details>
<summary>Click to show</summary>

| Name | Number | Description |
| ---- | ------ | ----------- |
| GOOD | 0 | <para></para> |
| MODERATE | 1 | <para></para> |
| CONTAMINATED | 2 | <para></para> |
| UNKNOWN | 3 | <para></para> |
| RADIATION | 4 | <para></para> |
| DANGER | 5 | <para></para> |
| PROTECTED | 6 | <para></para> |

</details>


 <!-- end enums -->

 <!-- end HasExtensions -->


