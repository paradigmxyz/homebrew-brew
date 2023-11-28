class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v0.1.0-alpha.12",
    revision: "3d291ea292d7682b27ebaed7b0e391e221de91e3"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.1.0-alpha.11"
    sha256 cellar: :any_skip_relocation, ventura:      "bfe04adc0ec0f2fe239ac6899dcac322730a2f19d58d4efd86eaee428bb866a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a203fb8c1dfad60d371ac51abc5366db86511144490e4a0a6f4b448e69012ae2"
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
