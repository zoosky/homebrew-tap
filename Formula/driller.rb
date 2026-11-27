class Driller < Formula
  desc "HTTP load-testing tool with Ansible-style YAML plans"
  homepage "https://github.com/zoosky/driller"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/zoosky/driller/releases/download/0.14.1/driller-aarch64-apple-darwin.tar.gz"
      sha256 "7d38c029c5ad604b0d17d5d540d66d2675caf5b81d6c518af89ceae831eca73d"
    end
    on_intel do
      url "https://github.com/zoosky/driller/releases/download/0.14.1/driller-x86_64-apple-darwin.tar.gz"
      sha256 "87de96fcc007b60683ba9a9cadd216cee1b2b62c856e0e58a21250ee1fdc582b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/zoosky/driller/releases/download/0.14.1/driller-x86_64-unknown-linux-musl.tar.gz"
      sha256 "15ed1619b2caea44edbe3d2c1c9e1f07e625ac07ff8fc16aa87ff0caadeb9ef6"
    end
  end

  def install
    bin.install "driller"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/driller --version")
  end
end
