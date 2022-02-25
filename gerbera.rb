class Gerbera < Formula
  desc "UPnP Media Server for 2022"
  homepage "https://gerbera.io"
  url "https://github.com/gerbera/gerbera/archive/v1.10.0.tar.gz"
  sha256 "bd6c7b2c6380e2e265a998bbc0df9eec14b9c6a65bc91e7f2c0ae0b67fd0c9cf"

  depends_on "cmake" => :build
  depends_on "duktape"
  depends_on "ffmpeg"
  depends_on "ffmpegthumbnailer"
  depends_on "libexif"
  depends_on "libmagic"
  depends_on "libmatroska"
  depends_on "libupnp"
  depends_on "lzlib"
  depends_on "ossp-uuid"
  depends_on "pugixml"
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
