# Changelog

All notable changes per release. Versions follow [semver](https://semver.org).

## v0.1.4 — 2026-08-01

Documentation only — the image and what it serves are unchanged.

- The repo now ships a `docker-compose.yml` quick start. Until now it contained
  no compose file at all, so anyone cloning it had to retype the example out of
  the README before they could bring the service up.
- The file matches the README example: it pulls `psyb0t/safe-stremio-web:latest`,
  maps host port 8080 to port 80 in the container, and restarts always.
- The `USERNAME` and `PASSWORD` values in it are placeholders. Change them
  before exposing the service to anything, or the basic auth in front of the UI
  is worth nothing.

## v0.1.3 — 2026-08-01

Infrastructure only — the image and what it serves are unchanged.

- Split the CI surface: `pipeline.yml` keeps building and publishing the image,
  and everything that leaves this host now lives in `mirror-and-archive.yml`
  beside it.
- Every branch and tag push mirrors the repo to GitLab and Codeberg. Pull
  requests are turned off on both mirrors — they are force-pushed from GitHub,
  so anything merged there would be destroyed by the next sync; issues and
  forking stay enabled.
- Pushes to the default branch and to tags, plus a monthly schedule, archive the
  repo to the Wayback Machine, Software Heritage and archive.org, with outlinks
  captured.
- Added `issue-pull.yml`: issues opened on either mirror are pulled back into
  GitHub every six hours and closed here when the original closes. The schedule
  jitters up to ten minutes to avoid hammering both mirrors at once; a manual
  run does not.

## v0.1.2 — 2026-07-27

- Added a GitHub Actions CI status badge to the README.

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
