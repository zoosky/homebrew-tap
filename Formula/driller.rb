class Driller < Formula
  desc "HTTP load-testing tool with Ansible-style YAML plans"
  homepage "https://github.com/zoosky/driller"
  version "0.14.0"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/zoosky/driller/releases/download/0.14.0/driller-aarch64-apple-darwin.tar.gz"
      sha256 "005bb4c3802b722251eff0ee2321480cf13bb2f610ec9d8b7794a73f1a439c97"
    end
    on_intel do
      url "https://github.com/zoosky/driller/releases/download/0.14.0/driller-x86_64-apple-darwin.tar.gz"
      sha256 "b8b29901cd4735fb82775f8b35ff50a71c731ca147dfe74573f8ec103764bf0b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/zoosky/driller/releases/download/0.14.0/driller-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e432e2b906b7e76630cce6e936bbc04e358fd98c6d36b8153ea6c60213233580"
    end
  end

  def install
    bin.install "driller"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/driller --version")
  end
end
