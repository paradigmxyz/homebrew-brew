class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth/archive/v0.1.0-alpha.2.tar.gz"
  sha256 "7d8ca049db6042dcab4338386d9334556da188ca81408fd86c2d5ffc93b07617"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.1.0-alpha.2"
    sha256 cellar: :any_skip_relocation, ventura:      "f95dd1a8b94e25e5d46a99eb49c2a8a362df4958c69c34c09c168e042f0b52b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "aa7974160cb5a492285bd91a2aa6c2e7cfe09cd33037b5af7b40a68d9c4f5ab7"
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
