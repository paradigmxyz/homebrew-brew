class Flood < Formula
  include Language::Python::Virtualenv

  desc "Load testing tool for benchmarking EVM nodes over RPC"
  homepage "https://github.com/paradigmxyz/flood"
  url "https://github.com/paradigmxyz/flood.git",
    tag:      "0.2.5",
    revision: "b1ceecafffb06474c062e15fa67999b91d03a8c4"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/flood.git", branch: "main"

  depends_on "vegeta"
  depends_on "python@3.11"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/flood", "--help"
  end
end
