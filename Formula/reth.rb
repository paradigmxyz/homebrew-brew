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
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-1.0.0-rc.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "644374f33fa57f03d032e7ca6e117bf62b3285b9f68c46e717735e7cfbe7ca98"
    sha256 cellar: :any_skip_relocation, ventura:      "4219720b577d1259ff5a3b573a4272ba4f3d97b179740391efdd5708846fa6bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "89d582a6491a9dbd95c9b59c8172ea8bca2994b5360aa13fa40f5d8e29f40582"
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
