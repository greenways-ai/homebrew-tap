# Contributing formulae

This tap distributes installable Greenways command-line releases. It is not a mirror of every source repository.

## Admission requirements

A formula must have:

- a public upstream repository and OSI-approved licence;
- a stable semantic-version tag;
- an executable that works without a checkout of the upstream repository;
- immutable source or release assets;
- a meaningful `test do` block;
- successful installation on both macOS and Linux.

Do not point a stable formula at `main`, a moving branch, an untagged commit without an explicit version, or an asset that can be replaced in place.

## Updating a formula

1. Cut and publish the upstream tag.
2. Pin the tag and exact commit or publish platform archives with SHA-256 checksums.
3. Update only the formula metadata and build adaptations required by that release.
4. Run `ruby -c Formula/<name>.rb` for a quick syntax check.
5. Let the tap workflow run Homebrew style, audit, install, linkage and formula tests on macOS and Linux.

Release-producing repositories should update this tap as the final step after their own release smoke tests pass. The tap update must never run before the release source or assets are publicly retrievable.

## Local validation

```sh
brew tap greenways-ai/tap
brew style greenways-ai/tap
brew audit --strict greenways-ai/tap/hoplite
brew install --build-from-source greenways-ai/tap/hoplite
brew test greenways-ai/tap/hoplite
```
