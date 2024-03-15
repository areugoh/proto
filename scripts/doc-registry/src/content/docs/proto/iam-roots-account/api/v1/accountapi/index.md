---





title: Accountapi
---
<!-- ------  Overall Reference ------ -->

[garajonai/platform/proto/iam-roots-account/api/v1/accountapi/accountapi.proto](#garajonai/platform/proto/iam-roots-account/api/v1/accountapi/accountapi.proto)
<details>
<summary>Click to show</summary>

### Messages
  - [FinishWebauthnRegistrationRequest](#garajonai.platform.iamrootsaccount.api.bff.v1.FinishWebauthnRegistrationRequest)
  - [FinishWebauthnRegistrationResponse](#garajonai.platform.iamrootsaccount.api.bff.v1.FinishWebauthnRegistrationResponse)
  - [StartWebauthnRegistrationRequest](#garajonai.platform.iamrootsaccount.api.bff.v1.StartWebauthnRegistrationRequest)
  - [StartWebauthnRegistrationResponse](#garajonai.platform.iamrootsaccount.api.bff.v1.StartWebauthnRegistrationResponse)

### Enums


</details>


<!-- ------  Service and Methods ------ -->
## Services


### IAMRootsAccountApi
IAMRootsAccountApi BFF service

| Method Name | Description |
| ----------- | ------------|
| `StartWebauthnRegistration` <br /><br /> Request: [StartWebauthnRegistrationRequest](#garajonai.platform.iamrootsaccount.api.bff.v1.StartWebauthnRegistrationRequest) <br /> Response: [StartWebauthnRegistrationResponse](#garajonai.platform.iamrootsaccount.api.bff.v1.StartWebauthnRegistrationRequest) | <para>StartWebauthnRegistration starts a WebAuthn registration process</para> |
| `FinishWebauthnRegistration` <br /><br /> Request: [FinishWebauthnRegistrationRequest](#garajonai.platform.iamrootsaccount.api.bff.v1.FinishWebauthnRegistrationRequest) <br /> Response: [FinishWebauthnRegistrationResponse](#garajonai.platform.iamrootsaccount.api.bff.v1.FinishWebauthnRegistrationRequest) | <para>FinishWebauthnRegistration finishes a WebAuthn registration process</para> |






<a name="garajonai/platform/proto/iam-roots-account/api/v1/accountapi/accountapi.proto"></a>

<!-- ------  Filename ------ -->
## Accountapi.Proto


<!-- ------  Messages ------ -->
<a name="garajonai.platform.iamrootsaccount.api.bff.v1.FinishWebauthnRegistrationRequest"></a>
### FinishWebauthnRegistrationRequest
FinishWebauthnRegistrationRequest is the request message for FinishWebauthnRegistration


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| email | [string](#string) |  | <para></para> |
| id | [string](#string) |  | <para></para> |
| raw_id | [bytes](#bytes) |  | <para></para> |
| type | [string](#string) |  | <para></para> |
| transports | [string](#string) | repeated | <para></para> |
| response | [garajonai.platform.iamrootsaccount.api.v1.AttestationResponse](#garajonai.platform.iamrootsaccount.api.v1.AttestationResponse) |  | <para></para> |




<a name="garajonai.platform.iamrootsaccount.api.bff.v1.FinishWebauthnRegistrationResponse"></a>
### FinishWebauthnRegistrationResponse
FinishWebauthnRegistrationResponse is the response message for FinishWebauthnRegistration


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| status | [string](#string) |  | <para></para> |




<a name="garajonai.platform.iamrootsaccount.api.bff.v1.StartWebauthnRegistrationRequest"></a>
### StartWebauthnRegistrationRequest
StartWebauthnRegistrationRequest is the request message for StartWebauthnRegistration


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| email | [string](#string) |  | <para></para> |




<a name="garajonai.platform.iamrootsaccount.api.bff.v1.StartWebauthnRegistrationResponse"></a>
### StartWebauthnRegistrationResponse
StartWebauthnRegistrationResponse is the response message for StartWebauthnRegistration


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| public_key | [garajonai.platform.iamrootsaccount.api.v1.PublicKey](#garajonai.platform.iamrootsaccount.api.v1.PublicKey) |  | <para></para> |





<!-- ------  Enums ------ -->



