class Mesc < Formula
  desc "Ethereum endpoint management tool"
  homepage "https://github.com/paradigmxyz/mesc"
  url "https://github.com/paradigmxyz/mesc.git",
    tag:      "0.2.0",
    revision: "de4e784c87cdbe61a649f541d7d0510a231fe54d"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/mesc.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--path", "rust/crates/mesc_cli", "--release", *std_cargo_args
  end

  test do
    system "#{bin}/mesc", "--help"
  end
end
