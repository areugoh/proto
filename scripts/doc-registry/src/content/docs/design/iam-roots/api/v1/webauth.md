---
title: Webauthn Flow
description: IAM Roots design
---

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
participant "iam-xylem\n(TBD)" as IAMX
database "repository" as R
end box

autonumber

note over U
User is unauthenticated
end note


U -> F: action triggered


activate F
F -> IAMX: GET /authorize \nwith prompt=create, scope=openid
deactivate F
activate IAMX
IAMX -> IAML: 302 /signup
deactivate IAMX


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
IAMR -> R: Update user_info \nwith credential
activate R
R --> IAMR
deactivate R
IAMR -> IAMR: update challengeSession
IAMR --> IAML: with authorization_code
deactivate IAMR
IAML -> IAMX: GET /authorize \nwith authorization_code, client_id, secret_id, scope=openid
deactivate IAML
activate IAMX
IAMX --> F: with access_token, id_token, (opt refresh_token)
deactivate IAMX

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
participant "iam-xylem\n(TBD)" as IAMX
database "repository" as R
end box

autonumber

note over U
User is unauthenticated
end note


U -> F: action triggered


activate F
F -> IAMX: GET /authorize \nwith scope=openid
deactivate F

activate IAMX
IAMX -> IAML: 302 /signin
deactivate IAMX
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
IAMR --> IAML: with authorization_code
deactivate IAMR

IAML -> IAMX: GET /authorize \nwith authorization_code, client_id, secret_id, scope=openid
deactivate IAML
activate IAMX
IAMX --> F: with access_token, id_token, (opt refresh_token)
deactivate IAMX

note over U
User is authenticated
end note
```
