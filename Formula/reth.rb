class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v1.0.4",
    revision: "e24e4c773d7571a5a54dba7854643c02d0b0a841"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-1.0.4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "2744ef0da4900fc99fc07309c84f60f3fed6d391689fffbd59c4e453793c718f"
    sha256 cellar: :any_skip_relocation, ventura:      "b720db4f011ef1e42441d7687a2d0d66cfc3c6e5d097255c30b7385a5bbcb1ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "421a8647b027b5333ab63f52556baf54412551661e46c699f83ff1bd6ca7c6d2"
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
