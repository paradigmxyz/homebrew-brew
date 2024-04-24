class Reth < Formula
  desc "Fast implementation of the Ethereum protocol in Rust"
  homepage "https://github.com/paradigmxyz/reth"
  url "https://github.com/paradigmxyz/reth.git",
    tag:      "v0.2.0-beta.6",
    revision: "ac29b4b73be382caf2a2462d426e6bad75e18af9"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/reth.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/reth-0.2.0-beta.6"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "ad11e1d6f9d8f7d0e4354f9f761b63ccac737369a5b26cc850673eabb6c51721"
    sha256 cellar: :any_skip_relocation, ventura:      "e4ab51cc3cb73aeb2108545fd64e3d031221ec4405ed3b50b9eac67653b9fce4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "49256054b9a5c05238c3f16973cd261abaa0562393073ffe0c3fad543be1d071"
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
