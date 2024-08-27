class Mesc < Formula
  desc "Ethereum endpoint management tool"
  homepage "https://github.com/paradigmxyz/mesc"
  url "https://github.com/paradigmxyz/mesc.git",
    tag:      "0.2.1",
    revision: "e4318f96b5094b3fcfcfdcd603f380886e6e3624"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/mesc.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    cd "rust/crates/mesc_cli" do
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    system "#{bin}/mesc", "--help"
  end
end
