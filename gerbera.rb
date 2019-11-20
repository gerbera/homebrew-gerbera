class Gerbera < Formula
  desc "UPnP Media Server for 2019"
  homepage "https://gerbera.io"
  url "https://github.com/gerbera/gerbera/archive/v1.3.4.tar.gz"
  sha256 "c7fbb6104dd03ed22d114c7b1fbe95eb7f90893148630e16b0a4c23f1f631341"

  depends_on "cmake" => :build
  depends_on "duktape"
  depends_on "ffmpeg"
  depends_on "ffmpegthumbnailer"
  depends_on "libexif"
  depends_on "libmagic"
  depends_on "gerbera/gerbera/libupnp"
  depends_on "lzlib"
  depends_on "ossp-uuid"
  depends_on "taglib"

  def install
    mkdir "build" do
      args = std_cmake_args
      args << "-DWITH_CURL=1"
      args << "-DWITH_JS=1"
      args << "-DWITH_TAGLIB=1"
      args << "-DWITH_AVCODEC=1"
      args << "-DWITH_EXIF=1"
      args << "-DWITH_SYSTEMD=0"
      args << "-DWITH_INOTIFY=0"
      args << "-DCMAKE_FIND_FRAMEWORK=LAST"
      args << "-DCMAKE_CXX_FLAGS=\"-stdlib=libc++\""
      args << "-DCMAKE_CXX_COMPILER=/usr/bin/clang++"
      args << "-DCMAKE_INSTALL_PREFIX:PATH=#{prefix}"
      args << "-DWITH_FFMPEGTHUMBNAILER=1"
      args << "-DWITH_MYSQL=0"

      system "cmake", "..", *args
      system "make", "install"
    end
  end

  test do
    assert_match /Gerbera UPnP Server/, shell_output("#{bin}/gerbera --compile-info").strip
  end
end
