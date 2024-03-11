---
title: Webauthn Flow
description: IAM Roots Account design
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
participant "iam-leaves-screen\n(profile.garajonai.com)" as IAML
end box

box Server #f6f6f6
participant "iam-roots-account\n(account.garajonai.com)" as IAMG
participant "iam-roots-auth\n(auth.garajonai.com)" as IAMT
database "repository" as R
end box

autonumber

note over U
User is unauthenticated
end note


U -> F: action triggered


activate F
F -> IAMT: GET /authorize \nwith prompt=create, scope=openid
deactivate F
activate IAMT
IAMT -> IAML: 302 /signup
deactivate IAMT


activate IAML
U <-> IAML: fill registration details
IAML -> IAMG: POST /registation/webauthn/start \nwith user_info

activate IAMG
IAMG -> R: Register user_info
activate R
R --> IAMG
deactivate R
IAMG -> IAMG: create challengeSession
IAMG -> IAML: challenge ID \nwith PublicKey
deactivate IAMG

IAML -> IAML: credential creation
IAML -> A: verification
activate A
A <-> U: gesture
A --> IAML: with attestation
deactivate A

IAML -> IAMG: POST /registration/webauthn/finish \nwith authenticatiorAttestation, user_key
activate IAMG
IAMG -> R: get user info
activate R
R --> IAMG
deactivate R
IAMG -> IAMG: get challengeSession
IAMG -> R: Update user_info \nwith credential
activate R
R --> IAMG
deactivate R
IAMG -> IAMG: update challengeSession
IAMG --> IAML: with authorization_code
deactivate IAMG
IAML -> IAMT: GET /authorize \nwith authorization_code, client_id, secret_id, scope=openid
deactivate IAML
activate IAMT
IAMT --> F: with access_token, id_token, (opt refresh_token)
deactivate IAMT

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
participant "iam-leaves-screen\n(profile.garajonai.com)" as IAML
end box

box Server #f6f6f6
participant "iam-roots-account\n(account.garajonai.com)" as IAMG
participant "iam-roots-auth\n(auth.garajonai.com)" as IAMT
database "repository" as R
end box

autonumber

note over U
User is unauthenticated
end note


U -> F: action triggered


activate F
F -> IAMT: GET /authorize \nwith scope=openid
deactivate F

activate IAMT
IAMT -> IAML: 302 /signin
deactivate IAMT
activate IAML


IAML <-> U: fill sign in details
IAML -> IAMG: POST /challenge/webauthn/start \nwith user_info
activate IAMG
IAMG -> R: get user info
activate R
R --> IAMG
deactivate R
IAMG -> IAMG: create challengeSession
IAMG -> IAML: challenge ID \nwith PublicKey
deactivate IAMG


IAML -> IAML: credential creation
IAML -> A: verification
activate A
A <-> U: gesture
A --> IAML: with attestation
deactivate A


IAML -> IAMG: POST /challenge/webauthn/finish \nwith authenticatiorAttestation, user_key
activate IAMG
IAMG -> R: get user info
activate R
R --> IAMG
deactivate R
IAMG -> IAMG: get challengeSession
IAMG -> IAMG: update challengeSession
IAMG --> IAML: with authorization_code
deactivate IAMG

IAML -> IAMT: GET /authorize \nwith authorization_code, client_id, secret_id, scope=openid
deactivate IAML
activate IAMT
IAMT --> F: with access_token, id_token, (opt refresh_token)
deactivate IAMT

note over U
User is authenticated
end note
```
