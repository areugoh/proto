## Webauthn, cross-platform key

> Description of the payloads on [rfc6749](https://datatracker.ietf.org/doc/html/rfc6749)

### IAM-roots service

```plantuml
@startuml structure-details
skinparam monochome false
skinparam BoxPadding 10
skinparam defaultTextAlignment center

rectangle iam-roots #line.dashed {
    node "BFF" as BFF
    node "Token \n(authorize service)" as T
    node "Webauthn \n(registration service)" as WA

    BFF -d-> T
    BFF -d-> WA
}
```

#### BFF (Backend For Frontend)

Service that handles the user interaction, it is the only service that can interact with the user. It's configure to
allow GRPC and REST calls.

#### Token

Service that handles the authorization. if the user is authenticated, it will return a token that can be used to access
the resources. If the user is not authenticated, it will return a redirect to the `iam-leaves` screen, triggering the
webauthn flow to either sign in or sign up the user.

#### Webauthn

Service that handles the registration and authentication of the user. FIDO or Passkey are the only supported authenticator
methods at the moment. If another method is required, it will live in a different service.

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
IAMR --> F: with PoA
deactivate IAMR
```

### Login

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


IAML <-> U: fill login details
IAML -> IAMR: POST /login/webauthn/start \nwith user_info
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



deactivate IAML
```
