class Yqr < Formula
  desc "A jq-style CLI for YAML: query and surgically edit while preserving comments, quoting, and formatting byte-for-byte"
  homepage "https://zoosky.github.io/yqr/"
  version "0.14.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zoosky/yqr/releases/download/v0.14.2/yqr-aarch64-apple-darwin.tar.xz"
      sha256 "9b2875a33b283490de0c8d3dac511cb73f944e3f4cd5d8e5792aec418f3b9114"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zoosky/yqr/releases/download/v0.14.2/yqr-x86_64-apple-darwin.tar.xz"
      sha256 "1b2eae993614341d78e62dedf65505b7bc4cf179070a764053807d2f0bccb36e"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/zoosky/yqr/releases/download/v0.14.2/yqr-x86_64-unknown-linux-musl.tar.xz"
    sha256 "aa9a251c2373703bbf5477e3b6dac02dde53c95c65f76c817d51b82e4815d2e8"
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
