class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v1.0.3",
    revision: "390f30aadebcdd509e72cc04327c3b854de076a6"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-1.0.3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "f3f8a5eadf076fb996d8a0b2b01c9b88aaf043d24dc7c8772b05094b8c3d7f6a"
    sha256 cellar: :any_skip_relocation, ventura:      "609e343f543c5c8da98bd60882212a7a87d184c0537c8a21c0f698952c92c3a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "de85e1ba53b07afe2bb6ee38b4bcfb65f797f062bbf9d7ce7cbba55352162fd2"
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
