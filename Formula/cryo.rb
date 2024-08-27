class Cryo < Formula
  desc "Tool to easily extract blockchain data"
  homepage "https://github.com/paradigmxyz/cryo"
  url "https://github.com/paradigmxyz/cryo.git",
    tag:      "0.2.0",
    revision: "b2c221a6f4f2104e0a6022780cb44a59fed6a172"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/cryo.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/cryo-0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "6d4e71d850a45df1bc0ac7c437740106e0aa51f5e8d2fa13ce7ca2e8ad10d95e"
    sha256 cellar: :any_skip_relocation, ventura:      "9ff80aad437bd2000a3284a3a3b2e95dab559af1cc8d82863dc9e495c73ce0eb"
  end

  depends_on "rust" => :build

  def install
    cd "crates/cli" do
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    system "#{bin}/cryo", "--help"
  end
end
