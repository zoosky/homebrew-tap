class Driller < Formula
  desc "HTTP load-testing tool with Ansible-style YAML plans"
  homepage "https://github.com/zoosky/driller"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/zoosky/driller/releases/download/0.14.2/driller-aarch64-apple-darwin.tar.gz"
      sha256 "6168e68b693330663c8de2cf4d1efb910bcd5f0210dc9a18d8a2b3b56f9bb7da"
    end
    on_intel do
      url "https://github.com/zoosky/driller/releases/download/0.14.2/driller-x86_64-apple-darwin.tar.gz"
      sha256 "c90d073029cf2c651c017f77780a4485f4b03b5c0f0065b053d75175f0a553b3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/zoosky/driller/releases/download/0.14.2/driller-x86_64-unknown-linux-musl.tar.gz"
      sha256 "af5e4afe5043af4de93f0e3c413c26dda11f5ba2946ec0487888fd12e9f3fb59"
    end
  end

  def install
    bin.install "driller"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/driller --version")
  end
end
