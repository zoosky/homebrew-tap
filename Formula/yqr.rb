class Yqr < Formula
  desc "A jq-style CLI for YAML: query and surgically edit while preserving comments, quoting, and formatting byte-for-byte"
  homepage "https://zoosky.github.io/yqr/"
  version "0.15.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zoosky/yqr/releases/download/v0.15.0/yqr-aarch64-apple-darwin.tar.xz"
      sha256 "5a9c7d6b5f71b1127ba1821c77dced0a93dfbccd1614b04d7c377f35a229f3b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zoosky/yqr/releases/download/v0.15.0/yqr-x86_64-apple-darwin.tar.xz"
      sha256 "b586caa98ab157abe85619b62c6b59fd0b63e94a7e431db621b45a614b385d0d"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/zoosky/yqr/releases/download/v0.15.0/yqr-x86_64-unknown-linux-musl.tar.xz"
    sha256 "96cc84e5466bb4a08fd9583c34b9f29666c53c0be82bf9cee075870bdfe07f2d"
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
