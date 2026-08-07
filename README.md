# Greenways Homebrew Tap

Official Homebrew formulae for tagged command-line tools in the Greenways open-source ecosystem. The formulae build from pinned source revisions so the same installation commands work on macOS and Linux.

## Install

Use the fully qualified formula name. Homebrew adds the tap automatically and trusts only the selected formula:

```sh
brew install greenways-ai/tap/hoplite
```

The equivalent explicit tap flow is:

```sh
brew tap greenways-ai/tap
brew trust --formula greenways-ai/tap/hoplite
brew install hoplite
```

## Formulae

| Formula | Command | Description | Release |
| --- | --- | --- | --- |
| `hoplite` | `hoplite` | Hara application server built into nginx | `v0.1.0` |

## Verify

```sh
hoplite eval '(+ 19 23)'
hoplite version
```

The evaluation command should print `42`.

## Upgrade

```sh
brew update
brew upgrade greenways-ai/tap/hoplite
```

## Release policy

Stable formulae must point to a tagged upstream release and an immutable commit. Every formula is syntax-checked, audited, built and tested on macOS and Linux before merge. Projects without a tagged executable release remain outside the tap until that release contract exists.

See [CONTRIBUTING.md](CONTRIBUTING.md) for the upstream release and formula-update requirements.
