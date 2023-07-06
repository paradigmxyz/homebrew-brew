class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth/archive/v0.1.0-alpha.1.tar.gz"
  sha256 "768cc9a247ca56b441ea994c7b088a03c1e36d40ecf1001dda6d600159e84472"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    rebuild 2
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.1.0-alpha.1"
    sha256 cellar: :any_skip_relocation, ventura:      "7913b51b9139cabe00e07ff0a19320fae73829dc5a02e10da7f6581be56a4e46"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d67d5adb7a868f3524c221654eceb69161ae685f4e9423559f9eb472d9234af4"
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
