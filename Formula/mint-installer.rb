class MintInstaller < Formula
  desc "Interactive Mint Supervisor installer"
  homepage "https://github.com/Mint-Security/MintSupervisorMCP"
  url "https://github.com/Mint-Security/MintSupervisorMCP/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "886f0572d7db5887ca898b8afececdda7349e6a4b2eeb73e0e14342ee38ede9b"
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
