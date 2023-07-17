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
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.1.0-alpha.3"
    sha256 cellar: :any_skip_relocation, ventura:      "517ef849e6d4c8e8af3c8ddbd8fc01215ea02daba8d9ef1f895ca2e702e289f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "45763ce22be3a60cac3f8a07d85950c5597501ddec4bbb45d555ba03f920e743"
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
