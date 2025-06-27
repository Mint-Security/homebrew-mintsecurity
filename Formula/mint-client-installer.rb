class MintClientInstaller < Formula
  desc "Mint MCP Proxy Server installer"
  homepage "https://github.com/Mint-Security/mint-mcp-proxy-server-installer"
  url "https://github.com/Mint-Security/mint-mcp-proxy-server-installer/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "48efa6d82ca3076a5c65b30158599e930fb5ecf7ca3ab141ef7b52f60782742e"
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