class Gerbera < Formula
  desc "UPnP Media Server for 2025"
  homepage "https://gerbera.io"
  url "https://github.com/gerbera/gerbera/archive/refs/tags/v2.6.0.tar.gz"
  sha256 "21505bd3c14b79cf63e423f14ab3bde96f74b044bffb208bd6f437b4b90e1668"

  depends_on "cmake" => :build
  depends_on "duktape"
  depends_on "exiv2"
  depends_on "ffmpeg"
  depends_on "ffmpegthumbnailer"
  depends_on "libexif"
  depends_on "libmagic"
  depends_on "libmatroska"
  depends_on "libupnp"
  depends_on "lzlib"
  depends_on "ossp-uuid"
  depends_on "pugixml"
  depends_on "jsoncpp"
  depends_on "spdlog"
  depends_on "taglib"

  def install
    mkdir "build" do
      args = std_cmake_args
      args << "-DWITH_CURL=YES"
      args << "-DWITH_JS=YES"
      args << "-DWITH_TAGLIB=YES"
      args << "-DWITH_AVCODEC=YES"
      args << "-DWITH_EXIF=YES"
      args << "-DWITH_EXIV2=NO"
      args << "-DWITH_SYSTEMD=NO"
      args << "-DWITH_INOTIFY=NO"
      args << "-DWITH_MYSQL=NO"
      args << "-DWITH_FFMPEGTHUMBNAILER=YES"
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
