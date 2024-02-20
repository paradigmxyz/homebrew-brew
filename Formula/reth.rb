class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v0.1.0-alpha.19",
    revision: "0192934a856199e4b2a846a36dbcd93e49866364"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.1.0-alpha.18"
    sha256 cellar: :any_skip_relocation, ventura:      "97dee5a62d87c9dbd260ce0675d592ccc6182b66b50dc0a1b5e9d3d0a3e3f3d4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c4b3b02f1d3b3371d2b846d8321f2fd406f062d56a858bd51d4a7d97e5d0bf71"
  end

  depends_on "llvm" => :build
  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  depends_on "libunwind" => :build

  def install
    cd "bin/reth" do
      system "cargo", "install", "--bin", "reth", "--profile", "maxperf", "--features", "jemalloc", *std_cargo_args
    end
  end

  test do
    system "#{bin}/reth", "--help"
  end
end
