class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v1.0.6",
    revision: "c228fe15808c3acbf18dc3af1a03ef5cbdcda07a"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-1.0.5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "2cf7bfc6942a12e1f22fc8dbdc280807729068f9119a0a642a802682f091e26f"
    sha256 cellar: :any_skip_relocation, ventura:      "71dc85197eb3ea39699784316397be43abad8a12512d4008929a6f16a2a4a9b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "822a9b974699eef9b66e542e71f58b6843983898b2c7081b0fbb0176eb398e86"
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
