class Gerbera < Formula
  desc "UPnP Media Server for 2018 (Based on MediaTomb)"
  homepage "https://github.com/gerbera/gerbera"
  url "https://github.com/gerbera/gerbera/archive/v1.2.0.tar.gz"
  sha256 "a64fe5820aced590bcdc22600596dc8a41c0baf68d7c0ec5baf7a561ade820df"

  depends_on "cmake" => :build
  depends_on "gerbera/gerbera/duktape"
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
      args << "-DCMAKE_CXX_FLAGS=\"-stdlib=libstdc++\""
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
