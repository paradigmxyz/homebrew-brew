class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v1.0.0",
    revision: "83d412da70af678a46f368533b6df45a287a1ce6"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-1.0.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "33024f4b2bcbf5c95b089bfbfc72009ee222002a7ad8faeffbb26f324f0cc72f"
    sha256 cellar: :any_skip_relocation, ventura:      "0d322cfe3f5b5d474cb2fad5156be3f6158669f319f2cbd974a471781fe876d5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5f2e905d589091456662d5aa0e83f13e2d6265690d204c794c33e154eebc2df3"
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
