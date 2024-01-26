---














title: Account_management, Error, User_account, Webauthn
---
<!-- ------  Overall Reference ------ -->

[hoguera/platform/proto/iam-roots/api/v1/account_management.proto](#hoguera/platform/proto/iam-roots/api/v1/account_management.proto)
<details>
<summary>Click to show</summary>

### Messages

### Enums


</details>

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

[hoguera/platform/proto/iam-roots/api/v1/user_account.proto](#hoguera/platform/proto/iam-roots/api/v1/user_account.proto)
<details>
<summary>Click to show</summary>

### Messages
  - [DeleteUserInfoRequest](#hoguera.platform.iamroots.api.v1.DeleteUserInfoRequest)
  - [DeleteUserInfoResponse](#hoguera.platform.iamroots.api.v1.DeleteUserInfoResponse)
  - [GetUserInfoRequest](#hoguera.platform.iamroots.api.v1.GetUserInfoRequest)
  - [GetUserInfoResponse](#hoguera.platform.iamroots.api.v1.GetUserInfoResponse)
  - [InsertUserInfoRequest](#hoguera.platform.iamroots.api.v1.InsertUserInfoRequest)
  - [InsertUserInfoResponse](#hoguera.platform.iamroots.api.v1.InsertUserInfoResponse)
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
  - [RevokeConnectionRequest](#hoguera.platform.iamroots.api.v1.RevokeConnectionRequest)
  - [RevokeConnectionResponse](#hoguera.platform.iamroots.api.v1.RevokeConnectionResponse)
  - [StartRegistrationRequest](#hoguera.platform.iamroots.api.v1.StartRegistrationRequest)
  - [StartRegistrationResponse](#hoguera.platform.iamroots.api.v1.StartRegistrationResponse)

### Enums


</details>


<!-- ------  Service and Methods ------ -->
## Services






### UserAccount
*Description comment will be shown here*

| Method Name | Description |
| ----------- | ------------|
| `GetUserInfo` <br /><br /> Request: [GetUserInfoRequest](#hoguera.platform.iamroots.api.v1.GetUserInfoRequest) <br /> Response: [GetUserInfoResponse](#hoguera.platform.iamroots.api.v1.GetUserInfoRequest) | <para></para> |
| `InsertUserInfo` <br /><br /> Request: [InsertUserInfoRequest](#hoguera.platform.iamroots.api.v1.InsertUserInfoRequest) <br /> Response: [InsertUserInfoResponse](#hoguera.platform.iamroots.api.v1.InsertUserInfoRequest) | <para></para> |
| `DeleteUserInfo` <br /><br /> Request: [DeleteUserInfoRequest](#hoguera.platform.iamroots.api.v1.DeleteUserInfoRequest) <br /> Response: [DeleteUserInfoResponse](#hoguera.platform.iamroots.api.v1.DeleteUserInfoRequest) | <para></para> |




### Webauthn
*Description comment will be shown here*

| Method Name | Description |
| ----------- | ------------|
| `StartRegistration` <br /><br /> Request: [StartRegistrationRequest](#hoguera.platform.iamroots.api.v1.StartRegistrationRequest) <br /> Response: [StartRegistrationResponse](#hoguera.platform.iamroots.api.v1.StartRegistrationRequest) | <para></para> |
| `FinishRegistration` <br /><br /> Request: [FinishRegistrationRequest](#hoguera.platform.iamroots.api.v1.FinishRegistrationRequest) <br /> Response: [FinishRegistrationResponse](#hoguera.platform.iamroots.api.v1.FinishRegistrationRequest) | <para></para> |
| `RevokeConnection` <br /><br /> Request: [RevokeConnectionRequest](#hoguera.platform.iamroots.api.v1.RevokeConnectionRequest) <br /> Response: [RevokeConnectionResponse](#hoguera.platform.iamroots.api.v1.RevokeConnectionRequest) | <para></para> |






<a name="hoguera/platform/proto/iam-roots/api/v1/account_management.proto"></a>

<!-- ------  Filename ------ -->
## Account_management.Proto


<!-- ------  Messages ------ -->

<!-- ------  Enums ------ -->




<a name="hoguera/platform/proto/iam-roots/api/v1/error.proto"></a>

<!-- ------  Filename ------ -->
## Error.Proto


<!-- ------  Messages ------ -->
<a name="hoguera.platform.iamroots.api.v1.PreconditionErrorDetail"></a>
### PreconditionErrorDetail
PreconditionErrorDetail is the error detail for precondition errors.





<!-- ------  Enums ------ -->

<a name="hoguera.platform.iamroots.api.v1.PreconditionErrorDetail.GenericErrorType"></a>

### PreconditionErrorDetail.GenericErrorType
Error type for Generic


| Name | Number | Description |
| ---- | ------ | ----------- |
| UNKNOWN | 0 | <para>Default code</para> |
| MISSING_PARAMETER | 1 | <para>The request is missing a required parameter</para> |
| INVALID_PARAMETER | 2 | <para>The request has an invalid parameter</para> |



<a name="hoguera.platform.iamroots.api.v1.PreconditionErrorDetail.TokenErrorType"></a>

### PreconditionErrorDetail.TokenErrorType
Error type for Token


| Name | Number | Description |
| ---- | ------ | ----------- |
| TOKEN_EXPIRED | 0 | <para>Token is expired</para> |
| REFRESH_TOKEN_INVALID | 1 | <para>Refresh token is not valid</para> |
| TOKEN_INVALID | 2 | <para>Token is not valid</para> |



<a name="hoguera.platform.iamroots.api.v1.PreconditionErrorDetail.UserErrorType"></a>

### PreconditionErrorDetail.UserErrorType
Error type for User


| Name | Number | Description |
| ---- | ------ | ----------- |
| USER_ALREADY_CONNECTED | 0 | <para>User already connected</para> |
| USER_NOT_CONNECTED | 1 | <para>User not connected</para> |
| USER_NOT_FOUND | 2 | <para>User not found</para> |
| USER_ALREADY_EXISTS | 3 | <para>User already exists</para> |
| UNAUTHORIZED | 4 | <para>User is not authorized to perform this action</para> |



<a name="hoguera.platform.iamroots.api.v1.PreconditionErrorDetail.WebauthnErrorType"></a>

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





<a name="hoguera/platform/proto/iam-roots/api/v1/user_account.proto"></a>

<!-- ------  Filename ------ -->
## User_account.Proto


<!-- ------  Messages ------ -->
<a name="hoguera.platform.iamroots.api.v1.DeleteUserInfoRequest"></a>
### DeleteUserInfoRequest
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.DeleteUserInfoResponse"></a>
### DeleteUserInfoResponse
*Description comment will be shown here (markdown supported)*




<a name="hoguera.platform.iamroots.api.v1.GetUserInfoRequest"></a>
### GetUserInfoRequest
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.GetUserInfoResponse"></a>
### GetUserInfoResponse
*Description comment will be shown here (markdown supported)*




<a name="hoguera.platform.iamroots.api.v1.InsertUserInfoRequest"></a>
### InsertUserInfoRequest
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| email | [string](#string) |  | <para></para> |
| subject | [string](#string) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.InsertUserInfoResponse"></a>
### InsertUserInfoResponse
*Description comment will be shown here (markdown supported)*




<a name="hoguera.platform.iamroots.api.v1.User"></a>
### User
Candidate to be rewritten


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) |  | <para></para> |
| name | [string](#string) |  | <para></para> |
| display_name | [string](#string) |  | <para></para> |





<!-- ------  Enums ------ -->




<a name="hoguera/platform/proto/iam-roots/api/v1/webauthn.proto"></a>

<!-- ------  Filename ------ -->
## Webauthn.Proto


<!-- ------  Messages ------ -->
<a name="hoguera.platform.iamroots.api.v1.AttestationResponse"></a>
### AttestationResponse
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| client_data_json | [string](#string) |  | <para></para> |
| attestation_object | [string](#string) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.AuthenticatorSelection"></a>
### AuthenticatorSelection
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| authenticator_attachment | [string](#string) |  | <para></para> |
| require_resident_key | [bool](#bool) |  | <para></para> |
| user_verification | [string](#string) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.FinishRegistrationRequest"></a>
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




<a name="hoguera.platform.iamroots.api.v1.FinishRegistrationResponse"></a>
### FinishRegistrationResponse
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| status | [string](#string) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.PuKeyCredParams"></a>
### PuKeyCredParams
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| type | [string](#string) |  | <para></para> |
| alg | [int32](#int32) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.PublicKey"></a>
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




<a name="hoguera.platform.iamroots.api.v1.ReplyingParty"></a>
### ReplyingParty
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) |  | <para></para> |
| name | [string](#string) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.RevokeConnectionRequest"></a>
### RevokeConnectionRequest
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| email | [string](#string) |  | <para></para> |
| id | [string](#string) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.RevokeConnectionResponse"></a>
### RevokeConnectionResponse
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| status | [string](#string) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.StartRegistrationRequest"></a>
### StartRegistrationRequest
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| email | [string](#string) |  | <para></para> |




<a name="hoguera.platform.iamroots.api.v1.StartRegistrationResponse"></a>
### StartRegistrationResponse
*Description comment will be shown here (markdown supported)*


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| public_key | [PublicKey](#hoguera.platform.iamroots.api.v1.PublicKey) |  | <para></para> |





<!-- ------  Enums ------ -->



