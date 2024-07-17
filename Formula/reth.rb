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
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-1.0.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "3116b3de1b14d46266ac3f23f0a7ffba24326ba480f84813103ebbefd3101939"
    sha256 cellar: :any_skip_relocation, ventura:      "b97d013a819876202401f3e85e0e9a6826ac00b87f1c849010858b4449b960d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "10554d1cd0cdcd7c6b17087c2ecaf301f8bace924fbe641ced6682b74ebe650c"
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
