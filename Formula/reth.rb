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
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.1.0-alpha.13"
    sha256 cellar: :any_skip_relocation, ventura:      "0ae4ff1a1f6f3b98d5bbc8937632a1177db72433da47eca69c43d6c40daa0c1f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "08743f29a24f09b2ec1f3171eaf03ff2ea03305d05767480427727f1801c0edb"
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
