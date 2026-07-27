# Changelog

All notable changes per release. Versions follow [semver](https://semver.org).

## v0.1.1 — 2026-07-27

- Added self-hosted version and license badges plus a Docker Hub pulls badge; wired a badges job into pipeline.yml.

## v0.1.0 — 2026-07-27

First tagged release.

- Serves a specific Stremio Web build behind nginx (with optional HTTP basic
  auth), unzipped from the upstream `stremio-web.zip` release asset at build
  time via the `STREMIO_VERSION` build arg.
- Pins Stremio Web `v5.0.0-beta.38` (refreshed from the previously-untagged
  `v5.0.0-beta.8`) on base image `alpine:3.22`.
- Image builds clean and serves the Stremio Web page (HTTP 200) verified.
