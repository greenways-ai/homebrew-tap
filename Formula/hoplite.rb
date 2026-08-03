class Hoplite < Formula
  desc "Hara application server built into nginx"
  homepage "https://github.com/greenways-ai/hoplite"
  url "https://github.com/greenways-ai/hoplite.git",
      tag:      "v0.1.0",
      revision: "eaa09a2e3a54edce8a7d68d1cb887bb700a24afe"
  license "EPL-2.0"
  head "https://github.com/greenways-ai/hoplite.git", branch: "main"

  depends_on "pkgconf" => :build
  depends_on "rust" => :build
  depends_on "openssl@3"
  depends_on "pcre2"
  depends_on "zlib"

  resource "hara" do
    url "https://github.com/hara-lang/hara.git",
        tag:      "v0.1.0",
        revision: "5ae3449e461274323318ceb33131111c53210835"
  end

  resource "nginx" do
    url "https://nginx.org/download/nginx-1.30.4.tar.gz"
    sha256 "4261dc90e9e47c1c4041276e9aaa3d48ebe2e664f728e14fa95ae6c67d57a08b"
  end

  def install
    resource("hara").stage do
      (buildpath/"hara.lang").install Pathname.pwd.children
    end

    nginx_source = buildpath/"target/sources/nginx-1.30.4"
    resource("nginx").stage do
      nginx_source.install Pathname.pwd.children
    end

    inreplace "Cargo.toml", "../hara.lang/rust", "hara.lang/rust"

    openssl = Formula["openssl@3"]
    pcre2 = Formula["pcre2"]
    zlib = Formula["zlib"]

    include_paths = [openssl.opt_include, pcre2.opt_include, zlib.opt_include]
    library_paths = [openssl.opt_lib, pcre2.opt_lib, zlib.opt_lib]
    include_flags = include_paths.map { |path| "-I#{path}" }.join(" ")
    library_flags = library_paths.flat_map { |path| ["-L#{path}", "-Wl,-rpath,#{path}"] }.join(" ")

    system "make", "embedded-cli",
           "NGINX_SRC=#{nginx_source}",
           "NGINX_CC_OPT=#{include_flags}",
           "NGINX_LD_OPT=#{library_flags}"

    bin.install "target/release/hoplite"
  end

  test do
    assert_equal "42", shell_output("#{bin}/hoplite eval '(+ 19 23)'").strip
    assert_match "Hoplite", shell_output("#{bin}/hoplite version")
  end
end
