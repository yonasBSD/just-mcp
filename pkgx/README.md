# pkgx packaging for just-mcp

This directory documents how just-mcp is packaged for [pkgx](https://pkgx.sh) and also mirrors the `package.yml` that should land in the
[`pkgxdev/pantry`](https://github.com/pkgxdev/pantry) repository under `projects/github.com/promptexecution/just-mcp`.

## Pantry manifest

`pkgx/projects/github.com/promptexecution/just-mcp/package.yml` downloads the release tarballs created by `.github/workflows/build-binaries.yml` for each
platform, extracts the executable, and moves it into `{{ prefix }}/bin`. The manifest pulls the version number from the `PromptExecution/just-mcp`
GitHub tags (`strip: /^v/`) so every release in this repo automatically becomes available to pkgx once the values are pushed to the pantry
and the archives are uploaded to GitHub Releases.

## Installation instructions

Once the package lands in the pantry you can invoke the shipped binary like this:

```bash
pkgx just-mcp --stdio
```

`pkgx` will download the architecture-specific tarball (for example `just-mcp-x86_64-unknown-linux-gnu.tar.gz`), extract it to `~/.pkgx`, and run the
`just-mcp --stdio` command. If you want the binary on your `PATH` permanently, add `${PKGX_DIR:-$HOME/.pkgx}/bin` to your shell profile so the
`just-mcp` binary is reusable after the first invocation.

## Keeping pkgx in sync with releases

- The GitHub release must include the tarballs listed in `.github/workflows/build-binaries.yml` so the manifest can download the matching asset.
- The pantry entry should stay in sync with the latest tag; updating the release will automatically expose `pkgx just-mcp` for that version.
- You can test the manifest locally by setting `PKGX_PANTRY_PATH=$(pwd)` inside the pantry repo and running `pkgx just-mcp --version` once the
  package builds.
