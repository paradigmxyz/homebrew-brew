class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v0.1.0-alpha.13",
    revision: "b34b0d3c8de2598b2976f7ee2fc1a166c50b1b94"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.1.0-alpha.12"
    sha256 cellar: :any_skip_relocation, ventura:      "3e984e37f477d6b7edb7a8e251833e188b244456582bf62144434f10082e9ea5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b3d5f80550d2a472cfd26a8f6f475daa31ca9461c94082aaeb602d25f72719cc"
  end

  depends_on "llvm" => :build
  depends_on "pkg-config" => :build
  depends_on "rust" => :build

  def install
    cd "bin/reth" do
      system "cargo", "install", "--bin", "reth", "--profile", "maxperf", "--features", "jemalloc", *std_cargo_args
    end
  end

  test do
    system "#{bin}/reth", "--help"
  end
end
