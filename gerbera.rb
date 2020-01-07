class Gerbera < Formula
  desc "UPnP Media Server for 2020"
  homepage "https://gerbera.io"
  url "https://github.com/gerbera/gerbera/archive/v1.4.0.tar.gz"
  sha256 "904a9031c85ac805e4c139f363510226952683d7257acd1dee25ba1e97fd7651"

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
