class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v1.0.0-rc.1",
    revision: "560080ee1990a14194f4e6da969f5a7e1b95a236"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.2.0-beta.9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "eec1d475c6a4f4b749eb9f9f695fd0f9fb45174bf75599738ef5c47ae7afd5a1"
    sha256 cellar: :any_skip_relocation, ventura:      "0b463e7910b5b8f1e68ac4a4cd883baceba19e7f823180a9badfd8be42cbd096"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a43a6d7eebc36bf22b54c2d7e4d1eef3ecc96effe67191fbc9e4c22e9156de54"
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
