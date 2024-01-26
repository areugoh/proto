---





title: Iamrootsapi
---
<!-- ------  Overall Reference ------ -->

[hoguera/platform/proto/iam-roots/api/v1/iamrootsapi/iamrootsapi.proto](#hoguera/platform/proto/iam-roots/api/v1/iamrootsapi/iamrootsapi.proto)
<details>
<summary>Click to show</summary>

### Messages
  - [FinishWebauthnRegistrationRequest](#hoguera.platform.iamroots.api.v1.iamrootsapi.FinishWebauthnRegistrationRequest)
  - [FinishWebauthnRegistrationResponse](#hoguera.platform.iamroots.api.v1.iamrootsapi.FinishWebauthnRegistrationResponse)
  - [StartWebauthnRegistrationRequest](#hoguera.platform.iamroots.api.v1.iamrootsapi.StartWebauthnRegistrationRequest)
  - [StartWebauthnRegistrationResponse](#hoguera.platform.iamroots.api.v1.iamrootsapi.StartWebauthnRegistrationResponse)

### Enums


</details>


<!-- ------  Service and Methods ------ -->
## Services


### IamRootsApi
*Description comment will be shown here*

| Method Name | Description |
| ----------- | ------------|
| `StartWebauthnRegistration` <br /><br /> Request: [StartWebauthnRegistrationRequest](#hoguera.platform.iamroots.api.v1.iamrootsapi.StartWebauthnRegistrationRequest) <br /> Response: [StartWebauthnRegistrationResponse](#hoguera.platform.iamroots.api.v1.iamrootsapi.StartWebauthnRegistrationRequest) | <para></para> |
| `FinishWebauthnRegistration` <br /><br /> Request: [FinishWebauthnRegistrationRequest](#hoguera.platform.iamroots.api.v1.iamrootsapi.FinishWebauthnRegistrationRequest) <br /> Response: [FinishWebauthnRegistrationResponse](#hoguera.platform.iamroots.api.v1.iamrootsapi.FinishWebauthnRegistrationRequest) | <para></para> |






<a name="hoguera/platform/proto/iam-roots/api/v1/iamrootsapi/iamrootsapi.proto"></a>

<!-- ------  Filename ------ -->
## Iamrootsapi.Proto


<!-- ------  Messages ------ -->
<a name="hoguera.platform.iamroots.api.v1.iamrootsapi.FinishWebauthnRegistrationRequest"></a>
### FinishWebauthnRegistrationRequest
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| email | [string](#string) |  | <para></para> |
| id | [string](#string) |  | <para></para> |
| raw_id | [bytes](#bytes) |  | <para></para> |
| type | [string](#string) |  | <para></para> |
| transports | [string](#string) | repeated | <para></para> |
| response | [hoguera.platform.iamroots.api.v1.AttestationResponse](#hoguera.platform.iamroots.api.v1.AttestationResponse) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.iamrootsapi.FinishWebauthnRegistrationResponse"></a>
### FinishWebauthnRegistrationResponse
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| status | [string](#string) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.iamrootsapi.StartWebauthnRegistrationRequest"></a>
### StartWebauthnRegistrationRequest
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| email | [string](#string) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.iamrootsapi.StartWebauthnRegistrationResponse"></a>
### StartWebauthnRegistrationResponse
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| public_key | [hoguera.platform.iamroots.api.v1.PublicKey](#hoguera.platform.iamroots.api.v1.PublicKey) |  | <para></para> |





<!-- ------  Enums ------ -->


