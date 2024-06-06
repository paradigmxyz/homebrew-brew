class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v0.2.0-beta.9",
    revision: "7b435e0d6dede497dca211090d95a4cfa387dd1b"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.2.0-beta.8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d7d5a60c0cdb9e9a50eb87b442a93227cfd16cb6e18e96d58bfe974341d1fa59"
    sha256 cellar: :any_skip_relocation, ventura:      "6b166e53e5c7a923b0631566d5f2cc34e2a295175067ab45e52803150695d489"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0360561cbbd0bca17eaa7d795e9b5be5c83268cd678fdd090e18bc7e1f5bc80f"
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
