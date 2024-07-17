class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v1.0.2",
    revision: "ffb44e6245eebd0144e8ae62f4f39203f2ea2e5f"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-1.0.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "1a6134961cfa2789c580e1fd84bd0c578b5c172abba773e3804d06019af5b782"
    sha256 cellar: :any_skip_relocation, ventura:      "ee35da1c5a38ad01d06e8f23a638ed0b5026042217521c2c0f152dca82a549da"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dcd67958fd708d9794c2658f059fab73f8db3594d777fea327a1bcacafa2cffa"
  end

  depends_on "pkg-config" => :build
  depends_on "rust" => :build

  def install
    features = []
    features.push("jemalloc") if Hardware::CPU.intel? || OS.mac?

    is_arm_linux = Hardware::CPU.arm? && OS.linux?
    features.push("asm-keccak") unless is_arm_linux

    cd "bin/reth" do
      if features.any?
        system "cargo", "install", "--bin", "reth", "--profile", "maxperf",
          "--features", features.join(" "), *std_cargo_args
      else
        system "cargo", "install", "--bin", "reth", "--profile", "maxperf", *std_cargo_args
      end
    end
  end

  test do
    system "#{bin}/reth", "--help"
  end
end
