class Yqr < Formula
  desc "A jq-style CLI for YAML: query and surgically edit while preserving comments, quoting, and formatting byte-for-byte"
  homepage "https://zoosky.github.io/yqr/"
  version "0.12.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zoosky/yqr/releases/download/v0.12.0/yqr-aarch64-apple-darwin.tar.xz"
      sha256 "93b1692b4319e5c204576126f2ef4067f87a4c49e2af15f2cd75c9c47318a6af"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zoosky/yqr/releases/download/v0.12.0/yqr-x86_64-apple-darwin.tar.xz"
      sha256 "373e6d48e09d4d4718a6d3726fbe46feda17437c698d57d3af0c9d18642399af"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/zoosky/yqr/releases/download/v0.12.0/yqr-x86_64-unknown-linux-musl.tar.xz"
    sha256 "531ab74e08594b23fcd8a0e0e8c1beecad18da2a341e48c09b89cce08285bade"
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "x86_64-apple-darwin":               {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "yqr"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "yqr"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "yqr"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
