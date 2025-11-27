class Gerbera < Formula
  desc "UPnP Media Server for 2025"
  homepage "https://gerbera.io"
  url "https://github.com/gerbera/gerbera/archive/refs/tags/v3.0.0.tar.gz"
  sha256 "d7934a2318f45330deb2ed1b589bd37b49f42f7929a9d11650349d17c998f920"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "duktape"
  depends_on "exiv2"
  depends_on "ffmpeg"
  depends_on "ffmpegthumbnailer"
  depends_on "fmt"
  depends_on "icu4c"
  depends_on "jsoncpp"
  depends_on "libebml"
  depends_on "libexif"
  depends_on "libmagic"
  depends_on "libmatroska"
  depends_on "libupnp"
  depends_on "lzlib"
  depends_on "ossp-uuid"
  depends_on "pugixml"
  depends_on "spdlog"
  depends_on "taglib"
  depends_on "wavpack"

  def install
    mkdir "build" do
      grb_pkg_config_path = ENV["PKG_CONFIG_PATH"]
      grb_cmake_prefix_path = ENV["CMAKE_PREFIX_PATH"]
      ENV["CMAKE_PKG_CONFIG_PC_LIB_DIRS"] = "/opt/homebrew/Cellar/libupnp/lib/pkgconfig:#{grb_pkg_config_path}"
      ENV["PKG_CONFIG_PATH"] = "/opt/homebrew/Cellar/libupnp/lib/pkgconfig:#{grb_pkg_config_path}"
      ENV["CMAKE_PREFIX_PATH"] = "/opt/homebrew/Cellar/libupnp:#{grb_cmake_prefix_path}"

      args = std_cmake_args
      args << "--preset=macos"
      args << "-DWITH_ICU=YES"
      args << "-DWITH_TESTS=NO"
      args << "-DCMAKE_FIND_FRAMEWORK=LAST"
      args << "-DCMAKE_CXX_FLAGS=\"-stdlib=libc++\""
      args << "-DCMAKE_CXX_COMPILER=/usr/bin/clang++"
      args << "-DCMAKE_INSTALL_PREFIX:PATH=#{prefix}"

      system "cmake", "..", *args
      system "make", "install"
    end
  end

  test do
    assert_match(/Gerbera UPnP Server/, shell_output("#{bin}/gerbera --compile-info").strip)
  end
end
