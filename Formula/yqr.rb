class Yqr < Formula
  desc "A jq-style CLI for YAML: query and surgically edit while preserving comments, quoting, and formatting byte-for-byte"
  homepage "https://zoosky.github.io/yqr/"
  version "0.13.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zoosky/yqr/releases/download/v0.13.1/yqr-aarch64-apple-darwin.tar.xz"
      sha256 "d1ab75a9e883bafeadb90e7bf8f8c401ae62f2381e99a95d25c67e0d1387de5d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zoosky/yqr/releases/download/v0.13.1/yqr-x86_64-apple-darwin.tar.xz"
      sha256 "1ab9cc544da9d613a29daf9ff4d5d297416c29b977dbadd0f54dc4f28fb2f974"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/zoosky/yqr/releases/download/v0.13.1/yqr-x86_64-unknown-linux-musl.tar.xz"
    sha256 "2f249e46926cde6494a671281dd69c6a6daef03c92f3d1a1958cb830db946746"
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
