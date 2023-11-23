class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v0.1.0-alpha.11",
    revision: "e5b33dbe74a1eb5811dfb5d2828d8c15bae286e3"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.1.0-alpha.10"
    sha256 cellar: :any_skip_relocation, ventura:      "792489a171dd60e67fa15678f1e9d2c0da1316ec6ac037ff53a6d6944d072696"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a8f8c750c419dedd9ff5c85f2234ebab442f843ebe817a26617ee7aafb0505d7"
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
