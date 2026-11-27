class Driller < Formula
  desc "HTTP load-testing tool with Ansible-style YAML plans"
  homepage "https://github.com/zoosky/driller"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/zoosky/driller/releases/download/0.14.3/driller-aarch64-apple-darwin.tar.gz"
      sha256 "a6eb783bba4c01d69b797be4ae593efd0518800a5887c4b065c401a1ed07cee7"
    end
    on_intel do
      url "https://github.com/zoosky/driller/releases/download/0.14.3/driller-x86_64-apple-darwin.tar.gz"
      sha256 "b7e89a6e976b8eda53f103c8ab4d17bc1ec677f4e9a1bca51ee572d690b8fb94"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/zoosky/driller/releases/download/0.14.3/driller-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d2c6a6359f89e8ad39db5df8874d349446cd450f79f8bc306204c388de514f3e"
    end
  end

  def install
    bin.install "driller"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/driller --version")
  end
end
