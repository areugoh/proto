---





title: Web
---
<!-- ------  Overall Reference ------ -->

[garajonai/platform/proto/iam-leaves/api/v1/web.proto](#garajonai/platform/proto/iam-leaves/api/v1/web.proto)
<details>
<summary>Click to show</summary>

### Messages
  - [SignupPageRequest](#garajonai.platform.iamleaves.api.v1.SignupPageRequest)

### Enums


</details>


<!-- ------  Service and Methods ------ -->
## Services


### AccountService
AccountService is the service for managing the templates of IAM user interactions.
It will communicate with the IAM family services to render the HTMX templates for the ACCOUNT page,
which includes but not limited to;
sign in, sign up, profile management and session management.

| Method Name | Description |
| ----------- | ------------|
| `GetSignupPage` <br /><br /> Request: [SignupPageRequest](#garajonai.platform.iamleaves.api.v1.SignupPageRequest) <br /> Response: [.google.api.HttpBody](#garajonai.platform.iamleaves.api.v1.SignupPageRequest) | <para>GetSignupPage returns the HTMX template for new users to sign up. Check</para><para>https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/grpc_json_transcoder_filter#sending-arbitrary-content for more information on the return type.</para> |






<a name="garajonai/platform/proto/iam-leaves/api/v1/web.proto"></a>

<!-- ------  Filename ------ -->
## Web.Proto


<!-- ------  Messages ------ -->
<a name="garajonai.platform.iamleaves.api.v1.SignupPageRequest"></a>
### SignupPageRequest
SignupPageRequest is the customitation of the Signup layout. All the fields are optional.


#### Fields

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| namespace | [string](#string) |  | <para>Namespace is the name of the organization.</para> |
| logo | [string](#string) |  | <para>Logo is the URL of the logo of the organization.</para> |





<!-- ------  Enums ------ -->



