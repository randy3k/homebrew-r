class HelloWorld < Formula
  desc "Program providing model for GNU coding standards and practices"
  homepage "https://www.gnu.org/software/hello/"
  url "https://ftp.gnu.org/gnu/hello/hello-2.10.tar.gz"
  sha256 "31e066137a962676e89f69d1b65382de95a7ef7d914b8cb956f41ea72e0f516b"

  bottle do
    root_url "https://github.com/randy3k/homebrew-rstudio-server/releases/download/hello-world-bottle"
    cellar :any_skip_relocation
    sha256 "a75fbce7436a6714e817eb3262d0d99d7de52411ebfe3f145b7a4aac57e58159" => :sierra
  end

  conflicts_with "camlistore", :because => "both install `hello` binaries"
  conflicts_with "hello", :because => "both install `hello` binaries"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
  test do
    assert_equal "brew", shell_output("#{bin}/hello --greeting=brew").chomp
  end
end
