class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v0.1.0-alpha.4",
    revision: "b2b2cbedb527c429128ef9302e006bc9af958fb5"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.1.0-alpha.4"
    sha256 cellar: :any_skip_relocation, ventura:      "bf2a660afaccee1746ea5c9fd04bee018250d761c02c22aeee9341e5cf72731a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "429632345381fb08dc25611ebf30b2ce420919f3d59ca55872e6fe063cb418db"
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
