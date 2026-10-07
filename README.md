# iCV OmniSpace SIP Connector

## Project scope

This repository is for a version-pinned Asterisk/PJSIP source build intended to provide a generic, server-side SIP connector for iCV OmniSpace. It is connector-only: it is not a SIP carrier, provider, or customer-facing PBX service.

## Status

- The source-build project is documented; implementation is not complete.
- The Asterisk release and source reference are pending separate version-specific review and approval.
- No container image has been built or published.
- The connector has not been deployed to the KVM 2 VPS.
- No provider registration or calls have been attempted.

## Security

- This repository contains no SIP account credentials, passwords, provider tokens, or customer SIP data.
- Do not commit secrets or runtime account configuration here.
- Runtime credentials must use an approved protected server-side secret path.

## Compatibility target

The intended target is standard SIP/PJSIP registration to existing providers. Provider-specific APIs and webhooks, a new carrier, and a new SIP provider are out of scope.
