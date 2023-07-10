class Foundry < Formula
  desc "Blazing fast, portable and modular toolkit for Ethereum written in Rust"
  homepage "https://github.com/foundry-rs/foundry"
  url "https://github.com/foundry-rs/foundry.git",
    tag:      "v1.0.0",
    revision: "afdbbc05cc479468b15a6f42b577b62e0fd4895e"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/foundry-rs/foundry.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build
  depends_on "libusb"

  def install
    system "cargo", "install", "--bins", *std_cargo_args(path: "./cli")
    system "cargo", "install", *std_cargo_args(path: "./anvil")
    system "cargo", "install", *std_cargo_args(path: "./chisel")
  end

  test do
    system "#{bin}/forge", "--help"
    system "#{bin}/cast", "--help"
    system "#{bin}/anvil", "--help"
    system "#{bin}/chisel", "--help"
  end
end
