# xixu-me/tap

<!-- README-I18N:START -->

**English** | [汉语](./README.zh.md)

<!-- README-I18N:END -->

A [Homebrew](https://brew.sh) tap maintained by me.

## Contents

This tap provides formulae and casks. See [`Formula/`](./Formula/) and [`Casks/`](./Casks/) for the current definitions.

## Installation

Add the tap when you want to browse or install several packages from it:

```sh
brew tap xixu-me/tap
```

You can also install a formula or cask directly with its fully qualified name:

```sh
brew install xixu-me/tap/<formula>
brew install --cask xixu-me/tap/<cask>
```

To list the entries provided by this tap:

```sh
brew search xixu-me/tap/
```

## Trust and security

Homebrew tap definitions are executable Ruby code and can run with your user privileges. Review a tap before using it, and prefer trusting only the package you need:

```sh
brew tap xixu-me/tap
brew trust --formula xixu-me/tap/<formula>
brew trust --cask xixu-me/tap/<cask>
```

Installing a fully qualified formula or cask, as shown above, trusts that individual item. Trust the whole tap only when you accept all current and future packages from it:

```sh
brew trust xixu-me/tap
```

See Homebrew's [Taps documentation](https://docs.brew.sh/Taps) and [Tap Trust documentation](https://docs.brew.sh/Tap-Trust) for details.

> [!WARNING]
> Only use this tap if you trust its source and the upstream projects referenced by its formulae and casks.

## Updating and removing the tap

Homebrew updates tapped repositories with `brew update`. To refresh this tap explicitly:

```sh
brew update
brew tap --repair
```

Remove the tap and its local checkout with:

```sh
brew untap xixu-me/tap
```

Removing a tap does not uninstall packages that were already installed from it.

## Development

Formulae and casks live in `Formula/` and `Casks/`. Run the relevant checks for changed definitions before opening a pull request:

```sh
brew audit --strict --online xixu-me/tap/<formula>
brew test xixu-me/tap/<formula>
```

GitHub Actions runs tap syntax checks on pushes and pull requests. Pull requests also audit, fetch, install, and uninstall changed casks. Scheduled workflows check for upstream formula and cask updates, while reviewed pull requests can publish bottles.
