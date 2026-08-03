class Hara < Formula
  desc "Symbolic programming language and portable AST kernel"
  homepage "https://www.hara-lang.org"
  url "https://github.com/hara-lang/hara.git",
      tag:      "v0.1.0",
      revision: "5ae3449e461274323318ceb33131111c53210835"
  license "EPL-2.0"
  head "https://github.com/hara-lang/hara.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--locked", "--release",
           "--manifest-path", "rust/Cargo.toml", "--bin", "hara"
    bin.install "rust/target/release/hara"
  end

  test do
    assert_equal "42", shell_output("#{bin}/hara eval '(+ 19 23)'").strip
  end
end
