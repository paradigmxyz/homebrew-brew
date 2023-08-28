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
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.1.0-alpha.8"
    sha256 cellar: :any_skip_relocation, ventura:      "63ad4922788f5830b21bf17f4aa6e6b93607b3c57be019e22a20285713205fb8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ee72465f645a47963f29f656b6d6d81929f06f5f744c6f198ae95dde60a7ced4"
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
