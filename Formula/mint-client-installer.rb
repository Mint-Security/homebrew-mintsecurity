class MintMcpProxyServerInstaller < Formula
  desc "Mint MCP Proxy Server installer"
  homepage "https://github.com/Mint-Security/mint-mcp-proxy-server-installer"
  url "https://github.com/Mint-Security/mint-mcp-proxy-server-installer/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "4d22099e85adc0f54deeac7cf10d9571d41526896d0d465487676c84bbbc92b9"
  license "Proprietary"

  depends_on "python@3.12"

  def install
    libexec.install Dir["*"] # Installs all files in the tarball; adjust as needed

    (bin/"mint-client-installer").write <<~EOS
      #!/bin/bash
      cd "#{libexec}"
      exec "/opt/homebrew/opt/python@3.12/libexec/bin/python" main.py "$@"
    EOS
  end

  test do
    system "#{bin}/mint-client-installer", "--help"
  end
end 