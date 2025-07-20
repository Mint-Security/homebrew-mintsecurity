class MintClientInstaller < Formula
  desc "Mint MCP Proxy Server installer"
  homepage "https://github.com/Mint-Security/mint-mcp-proxy-server-installer"
  url "https://github.com/Mint-Security/mint-mcp-proxy-server-installer/archive/refs/tags/v2.2.1.tar.gz"
  sha256 "b42474333f31b12f32e6119eeccd884bafbee4468ea6d93900b9de6e8b9a847f"
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