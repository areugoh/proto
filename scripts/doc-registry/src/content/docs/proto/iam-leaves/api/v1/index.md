---





title: Web
---
<!-- ------  Overall Reference ------ -->

[hoguera/platform/proto/iam-leaves/api/v1/web.proto](#hoguera/platform/proto/iam-leaves/api/v1/web.proto)
<details>
<summary>Click to show</summary>

### Messages

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
| `GetSignupPage` <br /><br /> Request: [.google.protobuf.Empty](#google.protobuf.Empty) <br /> Response: [.google.api.HttpBody](#google.protobuf.Empty) | <para>GetSignupPage returns the HTMX template for new users to sign up. Check</para><para>https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/grpc_json_transcoder_filter#sending-arbitrary-content for more information on the return type.</para> |






<a name="hoguera/platform/proto/iam-leaves/api/v1/web.proto"></a>

<!-- ------  Filename ------ -->
## Web.Proto


<!-- ------  Messages ------ -->

<!-- ------  Enums ------ -->



