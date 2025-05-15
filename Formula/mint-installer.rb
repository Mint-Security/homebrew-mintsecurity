class MintInstaller < Formula
  desc "Interactive Mint Supervisor installer"
  homepage "https://github.com/Mint-Security/MintSupervisorMCP"
  url "https://github.com/Mint-Security/MintSupervisorMCP/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "5e7d0ac66e8fa791fa904c5839d36ffdb2910a5631ad2c20773a67e3ec67fb3e"
  license "Proprietary"

  depends_on "python@3.12"

  def install
    libexec.install "main.py"
    libexec.install "src"
    libexec.install "claude-desktop.zip"
    libexec.install "default.zip"
  
    (bin/"mint-supervisor").write <<~EOS
      #!/bin/bash
      cd "#{libexec}"
      exec "#{Formula["python@3.12"].opt_bin}/python3" main.py "$@"
    EOS
  end
  

  test do
    # Check the wrapper script can run and respond to something basic
    system "#{bin}/mint-supervisor", "--help"
  end
end
