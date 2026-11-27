# Homebrew tap for zoosky's tools

```sh
brew install zoosky/tap/yqr       # YAML query and editing tool with a fidelity guarantee
brew install zoosky/tap/driller   # HTTP load-testing tool with Ansible-style YAML plans
```

Both formulae install each tool's prebuilt release binaries.

- `Formula/yqr.rb` is generated and pushed by yqr's release pipeline (dist,
  from the release's prebuilt binaries). Don't edit it by hand: the next
  release overwrites it. Issues: https://github.com/zoosky/yqr
- `Formula/driller.rb` is bumped after each driller release (version, URLs and
  SHA-256s from the release's `.sha256` assets). Issues:
  https://github.com/zoosky/driller
