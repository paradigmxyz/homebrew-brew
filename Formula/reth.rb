class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v0.1.0-alpha.9",
    revision: "b701cbc9a3eda39578ad19fb453c2c151aa72aab"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.1.0-alpha.9"
    sha256 cellar: :any_skip_relocation, ventura:      "8adb19ad0997de9ddb1fd187097b75964a7a391ee43d25e69726b71407ffbb8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3adfb76fa995201c774ca90cfc1cc4fe7843beb50bb779c8e5f8c180912bff2d"
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
