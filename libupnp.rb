class Libupnp < Formula
  desc "The portable Universal Plug and Play (UPnP) SDK"
  homepage "https://pupnp.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/pupnp/pupnp/libUPnP%201.8.3/libupnp-1.8.3.tar.bz2"
  sha256 "9afa0b09faa9ebd9e8a6425ddbfe8d1d856544c49b1f86fde221219e569a308d"

  option "without-ipv6", "Disable IPv6 support"
  option "without-reuseaddr", "Disable reuseaddr support"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]

    args << "--enable-ipv6" if build.with? "ipv6"
    args << "--enable-reuseaddr" if build.with? "reuseaddr"

    system "./configure", *args
    system "make", "install"
  end

  test do
    (testpath/"test.cc").write <<~EOS
      #include "upnp.h"
      #include <stdio.h>
      #include <stdlib.h>

      int
      main (int argc, char* argv[])
      {
        int rc;
        rc = UpnpInit (NULL, 0);
          if ( UPNP_E_SUCCESS == rc ) {
            printf ("UPnP Initializes OK");
          } else {
            printf ("** ERROR UpnpInit(): %d", rc);
            exit (EXIT_FAILURE);
          }
          (void) UpnpFinish();
          exit (EXIT_SUCCESS);
      }
    EOS
    system ENV.cc, "-I#{include}/upnp", "-lupnp",
           testpath/"test.cc", "-o", testpath/"test"

    assert_equal "UPnP Initializes OK",
            shell_output(testpath/"test").strip,
            "UPnP Initializes OK"
  end
end
