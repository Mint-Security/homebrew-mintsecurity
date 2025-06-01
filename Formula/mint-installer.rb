class MintInstaller < Formula
  desc "Interactive Mint Supervisor installer"
  homepage "https://github.com/Mint-Security/MintSupervisorMCP"
  url "https://github.com/Mint-Security/MintSupervisorMCP/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "0665d99adfa3c77eb0f2dbb1f03e9cde1170dc1ea54f98c295cc973c1b2e7d6e"
  license "Proprietary"

  depends_on "python@3.12"

  def install
    libexec.install %w[main.py src claude-desktop.zip default.zip claude-code.zip]
  
    (bin/"mint-installer").write <<~EOS
      #!/bin/bash
      cd "#{libexec}"
      exec "/opt/homebrew/opt/python@3.12/libexec/bin/python" main.py "$@"
    EOS
  end

  test do
    # Check the wrapper script can run and respond to something basic
    system "#{bin}/mint-installer", "--help"
  end
end
