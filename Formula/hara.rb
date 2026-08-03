class Hara < Formula
  desc "Symbolic programming language and portable AST kernel"
  homepage "https://www.hara-lang.org"
  url "https://github.com/hara-lang/hara/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "56b763d4c39d4e8ecfb0cb2eeca80fcebae1b3ab3a5299862c2619bc7bc5317f"
  license "EPL-2.0"
  head "https://github.com/hara-lang/hara.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "rust")
  end

  test do
    assert_equal "42", shell_output("#{bin}/hara eval '(+ 19 23)'").strip
  end
end
