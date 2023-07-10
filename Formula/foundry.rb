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

  bottle do
    root_url "https://github.com/paradigmxyz/homebrew-brew/releases/download/foundry-1.0.0"
    sha256 cellar: :any,                 ventura:      "036502dc9df4bab46d5901a2048af347dc1409f0aa93221751a68fbe51b521ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dce2fbcab398e61b45554950dfe178d866e0500e1561162a81de5cd849912c6a"
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
