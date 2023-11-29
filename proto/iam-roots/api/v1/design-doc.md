# IAM-roots

[toc]

## Overview

```plantuml
@startuml structure-details
skinparam monochome false
skinparam BoxPadding 10
skinparam defaultTextAlignment center

rectangle iam-roots #line.dashed {
    node "BFF" as BFF
    node "Token \n(authorization service)" as T
    node "Webauthn \n(authentication service)" as WA
    node "Profile \n(user service)" as P

    BFF -d-> T
    BFF -d-> WA
    BFF -d-> P
}
```

### BFF (Backend For Frontend)

Service that handles the user interaction, it is the only service that can interact with the user. It's configure to
allow GRPC and REST calls.

### Token

Service that handles the authorization. if the user is authenticated, it will return a token that can be used to access
the resources. If the user is not authenticated, it will return a redirect to the `iam-leaves` screen, triggering the
webauthn flow to either sign in or sign up the user. The token is a JWT token that contains the user information and
the permissions that the user has. The token is signed with a private key that is only known by the `iam-roots` service.
The following are the expected actions on the token service:

- `authorize`
- `token/refresh`
- `token/revoke`
- `token/validate`
- `token/verify`

### Webauthn

Service that handles the registration and authentication of the user. FIDO or Passkey are the only supported authenticator
methods at the moment. If another method is required, it will live in a different service. The following are the expected
actions on the webauthn service:

- `challenge`
- `registration`

### Profile

Service that handles the user information.
The following are the expected actions on the profile service:

- `user/registration`
- `user/update info`
- `user/delete`
- `user/get info`

## Webauthn/Token, cross-platform flow

> Description of the payloads on [rfc6749](https://datatracker.ietf.org/doc/html/rfc6749)

### Register

```plantuml
@startuml registration-details
skinparam dpi 160
skinparam monochome false
skinparam BoxPadding 10

actor User as U

box Client #f6f6f6
participant "frontend\n(namespace)" as F
control "authenticator" as A
participant "iam-leaves-screen\n(account.TBD.com)" as IAML
end box

box Server #f6f6f6
participant "iam-roots\n(TBD)" as IAMR
database "repository" as R
end box

autonumber

note over U
User is unauthenticated
end note


U -> F: action triggered


activate F
F -> IAMR: GET /authorize \nwith prompt=create
deactivate F


activate IAMR
IAMR -> IAMR: construct cookie
IAMR -> IAML: 302 /signup
deactivate IAMR


activate IAML
U <-> IAML: fill registration details
IAML -> IAMR: POST /registation/webauthn/start \nwith user_info

activate IAMR
IAMR -> R: Register user_info
activate R
R --> IAMR
deactivate R
IAMR -> IAMR: create challengeSession
IAMR -> IAML: challenge ID \nwith PublicKey
deactivate IAMR

IAML -> IAML: credential creation
IAML -> A: verification
activate A
A <-> U: gesture
A --> IAML: with attestation
deactivate A

IAML -> IAMR: POST /registration/webauthn/finish \nwith authenticatiorAttestation, user_key
activate IAMR
IAMR -> R: get user info
activate R
R --> IAMR
deactivate R
IAMR -> IAMR: get challengeSession
IAMR -> R: Update user_info \nwith credentail
activate R
R --> IAMR
deactivate R
IAMR -> IAMR: update challengeSession
IAMR --> IAML
deactivate IAMR
IAML -> IAMR: GET /authorize \nwith session
deactivate IAML
activate IAMR
IAMR --> F: with access_token, id_token, (opt refresh_token)
deactivate IAMR

note over U
User is authenticated
end note
```

### Sign in

```plantuml
@startuml registration-details
skinparam dpi 160
skinparam monochome false
skinparam BoxPadding 10

actor User as U

box Client #f6f6f6
participant "frontend\n(namespace)" as F
control "authenticator" as A
participant "iam-leaves-screen \n(account.TBD.com)" as IAML
end box

box Server #f6f6f6
participant "iam-roots \n(TBD)" as IAMR
database "repository" as R
end box

autonumber

note over U
User is unauthenticated
end note


U -> F: action triggered


activate F
F -> IAMR: GET /authorize \nwithnamespace=<appname>
deactivate F


activate IAMR
IAMR -> IAMR: construct cookie
IAMR -> IAML: 302 /signin
deactivate IAMR
activate IAML


IAML <-> U: fill sign in details
IAML -> IAMR: POST /challenge/webauthn/start \nwith user_info
activate IAMR
IAMR -> R: get user info
activate R
R --> IAMR
deactivate R
IAMR -> IAMR: create challengeSession
IAMR -> IAML: challenge ID \nwith PublicKey
deactivate IAMR


IAML -> IAML: credential creation
IAML -> A: verification
activate A
A <-> U: gesture
A --> IAML: with attestation
deactivate A


IAML -> IAMR: POST /challenge/webauthn/finish \nwith authenticatiorAttestation, user_key
activate IAMR
IAMR -> R: get user info
activate R
R --> IAMR
deactivate R
IAMR -> IAMR: get challengeSession
IAMR -> IAMR: update challengeSession
IAMR --> IAML
deactivate IAMR

IAML -> IAMR: GET /authorize \nwith session
deactivate IAML
activate IAMR
IAMR --> F: with access_token, id_token, (opt refresh_token)
deactivate IAMR

note over U
User is authenticated
end note
```
