---





title: Mobile
---
<!-- ------  Overall Reference ------ -->

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


<!-- ------  Service and Methods ------ -->
## Services


### GreenSpace
GreenSpace is the service that provides all the information for NASA's GreenSpace app.

| Method Name | Description |
| ----------- | ------------|
| `GetAnimals` <br /><br /> Request: [AnimalsRequest](#hoguera.platform.greenspace.api.v1.AnimalsRequest) <br /> Response: [Animal](#hoguera.platform.greenspace.api.v1.AnimalsRequest) | <para>GetAnimals returns the animals that are in danger in the coast as a stream.</para> |
| `GetCoast` <br /><br /> Request: [CoastRequest](#hoguera.platform.greenspace.api.v1.CoastRequest) <br /> Response: [CoastResponse](#hoguera.platform.greenspace.api.v1.CoastRequest) | <para>GetCoast returns the nearest coast to the user location.</para> |
| `GetLocation` <br /><br /> Request: [LocationRequest](#hoguera.platform.greenspace.api.v1.LocationRequest) <br /> Response: [LocationResponse](#hoguera.platform.greenspace.api.v1.LocationRequest) | <para>GetLocation returns the location of the user.</para> |
| `GetV1` <br /><br /> Request: [.google.protobuf.Empty](#google.protobuf.Empty) <br /> Response: [V1Response](#google.protobuf.Empty) | <para>GetV1 is the BFF endpoint. It returns the location of the user, the nearest coast and the animals in danger.</para> |






<a name="hoguera/platform/proto/greenspace/api/v1/mobile.proto"></a>

<!-- ------  Filename ------ -->
## Mobile.Proto


<!-- ------  Messages ------ -->
<a name="hoguera.platform.greenspace.api.v1.Animal"></a>
### Animal
Animals the animals that are in danger in the coast.


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | <para></para> |
| in_danger | [bool](#bool) |  | <para></para> |
| description | [string](#string) |  | <para></para> |




<a name="hoguera.platform.greenspace.api.v1.AnimalsRequest"></a>
### AnimalsRequest
AnimalsRequest the user location is required to get the nearest animals living in the coast.


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| location | [LocationResponse](#hoguera.platform.greenspace.api.v1.LocationResponse) |  | <para></para> |




<a name="hoguera.platform.greenspace.api.v1.CoastRequest"></a>
### CoastRequest
CoastRequest the user location is required to get the nearest coast.


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| location | [LocationResponse](#hoguera.platform.greenspace.api.v1.LocationResponse) |  | <para></para> |




<a name="hoguera.platform.greenspace.api.v1.CoastResponse"></a>
### CoastResponse
CoastResponse the nearest coast to the user location.


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  | <para>The name of the coast. e.g. "Playa de la Concha"</para> |
| condition | [Condition](#hoguera.platform.greenspace.api.v1.Condition) |  | <para>The condition of the water. e.g. "GOOD"</para> |
| temperature | [float](#float) |  | <para>The temperature of the water in Celsius. e.g. 20</para> |
| distance | [double](#double) |  | <para>The distance in kilometers to the coast. e.g. 4.1</para> |




<a name="hoguera.platform.greenspace.api.v1.LocationRequest"></a>
### LocationRequest
LocationRequest the IP of the user is required to get the location.


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| ip | [string](#string) |  | <para></para> |




<a name="hoguera.platform.greenspace.api.v1.LocationResponse"></a>
### LocationResponse
Location


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| longitude | [float](#float) |  | <para></para> |
| latitude | [float](#float) |  | <para></para> |
| name | [string](#string) |  | <para>The name of the location. e.g. "San Sebastian"</para> |




<a name="hoguera.platform.greenspace.api.v1.V1Response"></a>
### V1Response
V1Response the response of the V1 endpoint. It contains the location of the user, the nearest coast and the animals
in danger. It serves as a wrapper for the other responses. It is used to avoid multiple requests to the API and
follow the BFF pattern.


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| location | [LocationResponse](#hoguera.platform.greenspace.api.v1.LocationResponse) |  | <para></para> |
| nearest_aquatic_location | [CoastResponse](#hoguera.platform.greenspace.api.v1.CoastResponse) |  | <para></para> |
| animals | [Animal](#hoguera.platform.greenspace.api.v1.Animal) | repeated | <para></para> |





<!-- ------  Enums ------ -->

<a name="hoguera.platform.greenspace.api.v1.Condition"></a>

### Condition
Condition, the condition of the water. In house algorithm to define the condition.


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




