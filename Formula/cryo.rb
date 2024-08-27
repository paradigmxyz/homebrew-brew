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
