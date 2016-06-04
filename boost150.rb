class Boost150 < Formula
  desc "Collection of portable C++ source libraries"
  homepage "http://www.boost.org"
  url "https://downloads.sourceforge.net/project/boost/boost/1.50.0/boost_1_50_0.tar.bz2"
  sha256 "c9ace2b8c81fa6703d1d17c7e478de3bc51101c5adbdeb3f6cb72cf3045a8529"

  keg_only "Conflicts with boost in main repository."

  env :userpaths

  option :universal
  option "with-icu4c", "Build regexp engine with icu support"
  option "with-single", "Build also single-threading variant"
  option "with-mpi", "Build with MPI support"

  depends_on "icu4c" => :optional
  depends_on :mpi => [:cc, :cxx, :optional]

  fails_with :llvm do
    build 2335
    cause "Dropped arguments to functions when linking with boost"
  end

  def install
    # Boost.Signals does not work with libc++
    ENV.libstdcxx if ENV.compiler == :clang

    ENV.universal_binary if build.universal?

    # https://svn.boost.org/trac/boost/ticket/8841
    if (build.with? "mpi") && (build.with? "single")
      raise <<-EOS.undent
        Building MPI support for both single and multi-threaded flavors
        is not supported.  Please use "--with-mpi" together with
        "--without-single".
      EOS
    end

    # libdir should be set by --prefix but isn't
    bootstrap_args = ["--prefix=#{prefix}", "--libdir=#{lib}"]

    if build.with? "icu4c"
      icu4c_prefix = Formula["icu4c"].opt_prefix
      bootstrap_args << "--with-icu=#{icu4c_prefix}"
    else
      bootstrap_args << "--without-icu"
    end

    # Handle libraries that will not be built.
    without_libraries = ["python"]
    without_libraries << "mpi" if build.without? "mpi"

    bootstrap_args << "--without-libraries=#{without_libraries.join(",")}"

    args = ["--prefix=#{prefix}",
            "--libdir=#{lib}",
            "-d2",
            "-j#{ENV.make_jobs}",
            "link=shared,static",
            "install"]

    if build.with? "single"
      args << "threading=single,multi"
    else
      args << "threading=multi"
    end

    args << "address-model=32_64" << "architecture=x86" << "pch=off" if build.universal?

    system "./bootstrap.sh", *bootstrap_args
    system "./bjam", *args
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <boost/algorithm/string.hpp>
      #include <string>
      #include <vector>
      #include <assert.h>
      using namespace boost::algorithm;
      using namespace std;

      int main()
      {
        string str("a,b");
        vector<string> strVec;
        split(strVec, str, is_any_of(","));
        assert(strVec.size()==2);
        assert(strVec[0]=="a");
        assert(strVec[1]=="b");
        return 0;
      }
    EOS

    system ENV.cxx, "test.cpp", "-stdlib=libstdc++",
      "-L#{lib}",
      "-I#{include}",
      "-lboost_system",
      "-o", "test"
    ENV["DYLD_LIBRARY_PATH"] = "#{lib}"
    system "./test"
  end
end
