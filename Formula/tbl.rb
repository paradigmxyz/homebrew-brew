class Tbl < Formula
  desc "Swiss army knife for parquet read and write operations"
  homepage "https://github.com/paradigmxyz/tbl"
  url "https://github.com/paradigmxyz/tbl.git",
    tag:      "0.1.1",
    revision: "4edd598592f6c8bca30e04de6b49b1214d3e9dc5"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/paradigmxyz/tbl.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "rust" => :build

  def install
    cd "crates/tbl-cli" do
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    system "#{bin}/tbl", "--help"
  end
end
