class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v1.0.0-rc.2",
    revision: "d786b459d93a6e1f7cf903a37f0542aafd671e7f"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-1.0.0-rc.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8b489c655972276c2fab75d0b31f345202935498f6a8621628416cca15e74bef"
    sha256 cellar: :any_skip_relocation, ventura:      "53811a8fbc23cffad56a71c1e8500d99125dd01aa717ead2bdfbdb686b016742"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ec7483b95a088c3f776d679b7aebcfdf4a8d974061351fed06f98c840856583a"
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
