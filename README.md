# Stepin Tools

## How do I install KBRE?

More details: https://github.com/stepin/kbre .

`brew install stepin/tools/kbre`

Or `brew tap stepin/tools` and then `brew install kbre`.

Or, in a [`brew bundle`](https://github.com/Homebrew/homebrew-bundle) `Brewfile`:

```ruby
tap "stepin/tools"
brew "kbre"
```

## Build

```shell
brew tap stepin/tools

# Manual steps -- not required, it will be done by CICD
brew install --build-bottle kbre
brew bottle kbre

# Check style
brew audit --new kbre
brew style --fix kbre
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
