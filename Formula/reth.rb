class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v0.1.0-alpha.8",
    revision: "0f14ec4007f2cc7d5838d3a04cb531d8c8f72dc7"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.1.0-alpha.7"
    sha256 cellar: :any_skip_relocation, ventura:      "7dc132a0a8ba2f2858ec7cf5916ad7810e2db7f831639a8c40946c3362a5bb12"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a90af0aed3fa7d90b417de22ccbebeed77a55c331c11a372655b755add61f956"
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
