class Yqr < Formula
  desc "A jq-style CLI for YAML: query and surgically edit while preserving comments, quoting, and formatting byte-for-byte"
  homepage "https://zoosky.github.io/yqr/"
  version "0.14.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zoosky/yqr/releases/download/v0.14.0/yqr-aarch64-apple-darwin.tar.xz"
      sha256 "a0ca3b49c01b7adca38e8ea29e7740fbd8eb2b48626a33b4650c6276496113c5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zoosky/yqr/releases/download/v0.14.0/yqr-x86_64-apple-darwin.tar.xz"
      sha256 "cc8f9a0015ca8873e376c74a12460bf07ae7220fa7e4da310f073bb3c1c31686"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/zoosky/yqr/releases/download/v0.14.0/yqr-x86_64-unknown-linux-musl.tar.xz"
    sha256 "9e3a2f361e5ada24155736afcdf68de79b18a347efe97f5b78820e395ba819ca"
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
