---
title: Scopes and Permissions
sidebar:
  order: 1
---

## Types of Scopes

We use scopes that refer to the object they grant access to, followed by the class of actions on that object they allow (e.g. `session:read`).
Additionally, some scopes have an optional perspective which is either `user` or `admin`, which influences how the action appears (e.g. `session:write:admin`.
At the same time, some scopes require a namespace which is the source of the object (e.g. `greenspace:weather:read`).

There are currently two types of scopes:

- **read**: Reading the full information about a single resource.
- **write**: Modifying the resource in any way e.g. creating, editing, or deleting.

## OAuth Scopes to API methods

| Scope | Description | API method | Public |
| ----- | ----------- | ---------- | ------ |
| `session:read` | Read the full information about a single session. | `GetSession` | :green_circle: |
