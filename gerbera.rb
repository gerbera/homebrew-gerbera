class Gerbera < Formula
  desc "UPnP Media Server for 2025"
  homepage "https://gerbera.io"
  url "https://github.com/gerbera/gerbera/archive/refs/tags/v2.6.1.tar.gz"
  sha256 "6a7ed1c73bd86bdddd76bcb6c4bcd2e42788a20eb1f3165e0ea9f456abccd3ed"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "duktape"
  depends_on "exiv2"
  depends_on "ffmpeg"
  depends_on "ffmpegthumbnailer"
  depends_on "fmt"
  depends_on "icu4c"
  depends_on "jsoncpp"
  depends_on "libexif"
  depends_on "libmagic"
  depends_on "libmatroska"
  depends_on "libupnp"
  depends_on "lzlib"
  depends_on "ossp-uuid"
  depends_on "pugixml"
  depends_on "spdlog"
  depends_on "taglib"

  # Embedded (__END__) patches are declared like so:
  # patch :DATA
  patch :p1, :DATA

  def install
    system "which", "-a", "pkg-config"
    system "/opt/homebrew/Library/Homebrew/shims/mac/super/pkg-config", "--list-all"
    system "/opt/homebrew/Library/Homebrew/shims/mac/super/pkg-config", "--libs", "libupnp"
    system "/opt/homebrew/Library/Homebrew/shims/mac/super/pkg-config", "--cflags", "libupnp"
    mkdir "build" do
      grb_pkg_config_path = ENV["PKG_CONFIG_PATH"]
      grb_cmake_prefix_path = ENV["CMAKE_PREFIX_PATH"]
      ENV["CMAKE_PKG_CONFIG_PC_LIB_DIRS"] = "/opt/homebrew/Cellar/libupnp/lib/pkgconfig:#{grb_pkg_config_path}"
      ENV["PKG_CONFIG_PATH"] = "/opt/homebrew/Cellar/libupnp/lib/pkgconfig:#{grb_pkg_config_path}"
      ENV["CMAKE_PREFIX_PATH"] = "/opt/homebrew/Cellar/libupnp:#{grb_cmake_prefix_path}"

      args = std_cmake_args
      args << "--preset=macos"
      args << "-DWITH_ICU=NO"
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

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 89d4dfe9f..b05467b3d 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -515,6 +515,20 @@ if (WITH_NPUPNP)
     target_link_libraries(libgerbera PUBLIC NPUPNP::NPUPNP)
 else()
     set(REQ_UPNP_VERSION 1.14.6)
+    if(CMAKE_SYSTEM_NAME MATCHES "Darwin")
+        # Determine processor type as there are different paths for "brew" installation.
+        if (CMAKE_SYSTEM_PROCESSOR MATCHES "arm64") # "arm64" -> Apple Silicon
+                set(ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:/opt/homebrew/Cellar/libupnp/lib/pkgconfig")
+                list(APPEND CMAKE_PREFIX_PATH "/opt/homebrew/Cellar/libupnp")
+                list(APPEND CMAKE_PKG_CONFIG_PC_LIB_DIRS "/opt/homebrew/Cellar/libupnp/lib/pkgconfig")
+        else() # "x86_64" -> Intel (CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64")
+                set(ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:/usr/local/Cellar/libupnp/lib/pkgconfig")
+                list(APPEND CMAKE_PREFIX_PATH "/usr/local/Cellar/libupnp")
+                list(APPEND CMAKE_PKG_CONFIG_PC_LIB_DIRS "/usr/local/Cellar/libupnp/lib/pkgconfig")
+        endif()
+    endif()
+    MESSAGE("CMAKE_PREFIX_PATH: " ${CMAKE_PREFIX_PATH})
+    MESSAGE("CMAKE_PKG_CONFIG_PC_LIB_DIRS: " ${CMAKE_PKG_CONFIG_PC_LIB_DIRS})
     # LibUPnP official target since 1.16 (Lib version 18)
     # This will prefer the provided UPNPConfig.cmake if found, if not, it will fall back our FindUPNP.cmake
     find_package(UPNP ${REQ_UPNP_VERSION} QUIET)
