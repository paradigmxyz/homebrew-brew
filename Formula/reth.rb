class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v0.1.0-alpha.6",
    revision: "88aea631285b9c5a8ba32cf3fe924f40bd82cfca"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.1.0-alpha.6"
    sha256 cellar: :any_skip_relocation, ventura:      "e08db67abfb70e6bbcfeacc5229371bd6f9ce5e6901673e3a9ff0e22809d2045"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cef6624805117e7781446febef2265032da8903593cbec69d4e3c3ee1bcc7233"
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
