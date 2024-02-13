class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v0.1.0-alpha.18",
    revision: "11dbd0867ed020dad1c6b0763368ecd20d094056"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.1.0-alpha.16"
    sha256 cellar: :any_skip_relocation, ventura:      "2ef6a4b48dc9319d5feb3edef73c6954351ff7088c024da5caa7a703e2633047"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "29b49989785ba78b0ec8495b426150590dcb29abc31b923e036d6e7928339f5b"
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
