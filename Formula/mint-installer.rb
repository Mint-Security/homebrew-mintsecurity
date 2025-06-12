class MintInstaller < Formula
  desc "Interactive Mint Supervisor installer"
  homepage "https://github.com/Mint-Security/MintSupervisorMCP"
  url "https://github.com/Mint-Security/MintSupervisorMCP/archive/refs/tags/v1.0.5.tar.gz"
  sha256 "582ca5944075fd73eb429e218819a1cb5e45416a0ec7e274287876f460f42481"
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
