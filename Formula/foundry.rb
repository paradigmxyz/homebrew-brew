class Foundry < Formula
  desc "A blazing fast, portable and modular toolkit for Ethereum written in Rust"
  homepage "https://github.com/foundry-rs/foundry"
  url "https://github.com/foundry-rs/foundry.git",
    tag:      "v1.0.0",
    revision: "afdbbc05cc479468b15a6f42b577b62e0fd4895e"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/foundry-rs/foundry.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "foundry-cli", "anvil", "chisel", *std_cargo_args
  end

  test do
    system "#{bin}/forge", "--help"
    system "#{bin}/cast", "--help"
    system "#{bin}/anvil", "--help"
    system "#{bin}/chisel", "--help"
  end
end