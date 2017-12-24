class HelloWorld < Formula
  desc "Program providing model for GNU coding standards and practices"
  homepage "https://www.gnu.org/software/hello/"
  url "https://ftp.gnu.org/gnu/hello/hello-2.10.tar.gz"
  sha256 "31e066137a962676e89f69d1b65382de95a7ef7d914b8cb956f41ea72e0f516b"
  revision 1

  bottle do
    root_url "https://github.com/randy3k/homebrew-rstudio-server/releases/download/hello-world-bottle"
    sha256 "31db71ef43b44c6a81ee5429370d18582d69bd70ec739d3199c1701e8ba7800d" => :high_sierra
    sha256 "31db71ef43b44c6a81ee5429370d18582d69bd70ec739d3199c1701e8ba7800d" => :sierra
    sha256 "5a87f0bf62b4ec91375da31fd0374dbd845c999544edff760e3b0b9e173f74a9" => :x86_64_linux
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
