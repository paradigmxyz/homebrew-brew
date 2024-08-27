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
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/mesc-0.2.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "62a79facef1309f3f4a6e1fa8b64abf8712d492dd16ec7d2b5ede03e6cd97893"
    sha256 cellar: :any_skip_relocation, ventura:      "d801c13d72341b51377a5a78a5c2c2465e4211d771a306f00238422a56004d92"
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
