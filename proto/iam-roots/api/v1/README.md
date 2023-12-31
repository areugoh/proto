# Documentation
<a name="top"/>


## Reference

[hoguera/platform/proto/iam-roots/api/v1/error.proto](#hoguera/platform/proto/iam-roots/api/v1/error.proto)
<details>
<summary>Click to show</summary>

### Messages
  - [PreconditionErrorDetail](#hoguera.platform.iamroots.api.v1.PreconditionErrorDetail)

### Enums
  - [PreconditionErrorDetail.GenericErrorType](#hoguera.platform.iamroots.api.v1.PreconditionErrorDetail.GenericErrorType)
  - [PreconditionErrorDetail.TokenErrorType](#hoguera.platform.iamroots.api.v1.PreconditionErrorDetail.TokenErrorType)
  - [PreconditionErrorDetail.UserErrorType](#hoguera.platform.iamroots.api.v1.PreconditionErrorDetail.UserErrorType)
  - [PreconditionErrorDetail.WebauthnErrorType](#hoguera.platform.iamroots.api.v1.PreconditionErrorDetail.WebauthnErrorType)


</details>

[hoguera/platform/proto/iam-roots/api/v1/profile.proto](#hoguera/platform/proto/iam-roots/api/v1/profile.proto)
<details>
<summary>Click to show</summary>

### Messages
  - [User](#hoguera.platform.iamroots.api.v1.User)

### Enums


</details>

[hoguera/platform/proto/iam-roots/api/v1/webauthn.proto](#hoguera/platform/proto/iam-roots/api/v1/webauthn.proto)
<details>
<summary>Click to show</summary>

### Messages
  - [AttestationResponse](#hoguera.platform.iamroots.api.v1.AttestationResponse)
  - [AuthenticatorSelection](#hoguera.platform.iamroots.api.v1.AuthenticatorSelection)
  - [FinishRegistrationRequest](#hoguera.platform.iamroots.api.v1.FinishRegistrationRequest)
  - [FinishRegistrationResponse](#hoguera.platform.iamroots.api.v1.FinishRegistrationResponse)
  - [PuKeyCredParams](#hoguera.platform.iamroots.api.v1.PuKeyCredParams)
  - [PublicKey](#hoguera.platform.iamroots.api.v1.PublicKey)
  - [ReplyingParty](#hoguera.platform.iamroots.api.v1.ReplyingParty)
  - [StartRegistrationResponse](#hoguera.platform.iamroots.api.v1.StartRegistrationResponse)
  - [StartRegistrationResquest](#hoguera.platform.iamroots.api.v1.StartRegistrationResquest)

### Enums


</details>



## Services

 <!-- end services -->

 <!-- end services -->


<a name="hoguera.platform.iamroots.api.v1.Webauthn"/>

### Webauthn
*Description comment will be shown here*

| Method Name | Description |
| ----------- | ------------|
| `StartRegistration` <br /><br /> Request: [StartRegistrationResquest](#hoguera.platform.iamroots.api.v1.StartRegistrationResquest) <br /> Response: [StartRegistrationResponse](#hoguera.platform.iamroots.api.v1.StartRegistrationResquest) | <para></para> |
| `FinishRegistration` <br /><br /> Request: [FinishRegistrationRequest](#hoguera.platform.iamroots.api.v1.FinishRegistrationRequest) <br /> Response: [FinishRegistrationResponse](#hoguera.platform.iamroots.api.v1.FinishRegistrationRequest) | <para></para> |

 <!-- end services -->
 <!-- end files -->



<a name="hoguera/platform/proto/iam-roots/api/v1/error.proto"/>
<p align="right"><a href="#top">Top</a></p>

## hoguera/platform/proto/iam-roots/api/v1/error.proto



<a name="hoguera.platform.iamroots.api.v1.PreconditionErrorDetail"/>

### PreconditionErrorDetail
PreconditionErrorDetail is the error detail for precondition errors.







<a name="hoguera.platform.iamroots.api.v1.PreconditionErrorDetail.GenericErrorType"/>

### PreconditionErrorDetail.GenericErrorType
Error type for Generic


| Name | Number | Description |
| ---- | ------ | ----------- |
| UNKOWN | 0 | <para>Default code</para> |
| MISSING_PARAMETER | 1 | <para>The request is missing a required parameter</para> |
| INVALID_PARAMETER | 2 | <para>The request has an invalid parameter</para> |




<a name="hoguera.platform.iamroots.api.v1.PreconditionErrorDetail.TokenErrorType"/>

### PreconditionErrorDetail.TokenErrorType
Error type for Token


| Name | Number | Description |
| ---- | ------ | ----------- |
| TOKEN_EXPIRED | 0 | <para>Token is expired</para> |
| REFRESH_TOKEN_INVALID | 1 | <para>Refresh token is not valid</para> |
| TOKEN_INVALID | 2 | <para>Token is not valid</para> |




<a name="hoguera.platform.iamroots.api.v1.PreconditionErrorDetail.UserErrorType"/>

### PreconditionErrorDetail.UserErrorType
Error type for User


| Name | Number | Description |
| ---- | ------ | ----------- |
| USER_ALREADY_CONNECTED | 0 | <para>User already connected</para> |
| USER_NOT_CONNECTED | 1 | <para>User not connected</para> |
| USER_NOT_FOUND | 2 | <para>User not found</para> |
| USER_ALREADY_EXISTS | 3 | <para>User already exists</para> |
| UNAUTHORIZED | 4 | <para>User is not authorized to perform this action</para> |




<a name="hoguera.platform.iamroots.api.v1.PreconditionErrorDetail.WebauthnErrorType"/>

### PreconditionErrorDetail.WebauthnErrorType
Error type for Webauthn


<details>
<summary>Click to show</summary>

| Name | Number | Description |
| ---- | ------ | ----------- |
| UNSPECIFIED | 0 | <para>Default code</para> |
| ATTESTATION_VERIFY | 1 | <para>Registration failed</para> |
| ASSERTION_VERIFY | 2 | <para>Authentication failed</para> |
| UNAPPROVED_KEY | 3 | <para>Authenticating with a key that is not approved</para> |
| EXPIRED_KEY | 4 | <para>Approving expired key</para> |
| NOT_YET_VALID_KEY | 5 | <para>Approving key that is not yet valid</para> |
| DELETED_KEY | 6 | <para>Approving deleted key</para> |
| NO_APPROVED_KEYS | 7 | <para>Authenticating with a key when the user does not have any approved keys</para> |
| UNDELETABLE_KEY | 8 | <para>Attempting to delete an undeletable key</para> |

</details>


 <!-- end enums -->

 <!-- end HasExtensions -->



<a name="hoguera/platform/proto/iam-roots/api/v1/profile.proto"/>
<p align="right"><a href="#top">Top</a></p>

## hoguera/platform/proto/iam-roots/api/v1/profile.proto



<a name="hoguera.platform.iamroots.api.v1.User"/>

### User
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) |  | <para></para> |
| name | [string](#string) |  | <para></para> |
| display_name | [string](#string) |  | <para></para> |






 <!-- end enums -->

 <!-- end HasExtensions -->



<a name="hoguera/platform/proto/iam-roots/api/v1/webauthn.proto"/>
<p align="right"><a href="#top">Top</a></p>

## hoguera/platform/proto/iam-roots/api/v1/webauthn.proto



<a name="hoguera.platform.iamroots.api.v1.AttestationResponse"/>

### AttestationResponse
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| client_data_json | [string](#string) |  | <para></para> |
| attestation_object | [string](#string) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.AuthenticatorSelection"/>

### AuthenticatorSelection
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| authenticator_attachment | [string](#string) |  | <para></para> |
| require_resident_key | [bool](#bool) |  | <para></para> |
| user_verification | [string](#string) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.FinishRegistrationRequest"/>

### FinishRegistrationRequest
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| email | [string](#string) |  | <para></para> |
| id | [string](#string) |  | <para></para> |
| raw_id | [bytes](#bytes) |  | <para></para> |
| type | [string](#string) |  | <para></para> |
| transports | [string](#string) | repeated | <para></para> |
| response | [AttestationResponse](#hoguera.platform.iamroots.api.v1.AttestationResponse) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.FinishRegistrationResponse"/>

### FinishRegistrationResponse
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| status | [string](#string) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.PuKeyCredParams"/>

### PuKeyCredParams
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| type | [string](#string) |  | <para></para> |
| alg | [int32](#int32) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.PublicKey"/>

### PublicKey
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| challenge | [bytes](#bytes) |  | <para></para> |
| rp | [ReplyingParty](#hoguera.platform.iamroots.api.v1.ReplyingParty) |  | <para></para> |
| user | [User](#hoguera.platform.iamroots.api.v1.User) |  | <para></para> |
| pub_key_cred_params | [PuKeyCredParams](#hoguera.platform.iamroots.api.v1.PuKeyCredParams) | repeated | <para></para> |
| authenticator_selection | [AuthenticatorSelection](#hoguera.platform.iamroots.api.v1.AuthenticatorSelection) |  | <para></para> |
| timeout | [int32](#int32) |  | <para></para> |
| attestation | [string](#string) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.ReplyingParty"/>

### ReplyingParty
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) |  | <para></para> |
| name | [string](#string) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.StartRegistrationResponse"/>

### StartRegistrationResponse
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| public_key | [PublicKey](#hoguera.platform.iamroots.api.v1.PublicKey) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.StartRegistrationResquest"/>

### StartRegistrationResquest
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| email | [string](#string) |  | <para></para> |






 <!-- end enums -->

 <!-- end HasExtensions -->


