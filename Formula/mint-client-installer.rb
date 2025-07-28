class MintClientInstaller < Formula
  desc "Mint MCP Proxy Server installer"
  homepage "https://github.com/Mint-Security/mint-mcp-proxy-server-installer"
  url "https://github.com/Mint-Security/mint-mcp-proxy-server-installer/archive/refs/tags/v2.3.1.tar.gz"
  sha256 "493c1e648ef01b5953b31ea65c7cb38cf14aebc66a54f0dd22e8a4fccb4fc0b2"
  license "Proprietary"

  depends_on "python@3.12"

  def install
    # Install the main application
    libexec.install Dir["*"]
    
    # Install Python dependencies using the system Python
    system Formula["python@3.12"].opt_bin/"pip3.12", "install", "--target", libexec/"vendor", "requests"

    (bin/"mint-client-installer").write <<~EOS
      #!/bin/bash
      cd "#{libexec}"
      export PYTHONPATH="#{libexec}/vendor:$PYTHONPATH"
      exec "#{Formula["python@3.12"].opt_bin}/python3.12" main.py "$@"
    EOS
  end

  test do
    system "#{bin}/mint-client-installer", "--help"
  end
end 
