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
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.1.0-alpha.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, ventura:      "f7014721b4e081a9eca252c54f18b27888364fe4f9a231a37cfb256265bbaf19"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "91e7a816db2fc8303e181983afc3599da0e0d98416381bba9aa661064a19227b"
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
