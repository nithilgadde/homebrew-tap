class Armada < Formula
  desc "Native macOS live wallpaper manager - set videos and GIFs as desktop wallpaper"
  homepage "https://github.com/nithilgadde/armada"
  url "https://github.com/nithilgadde/armada/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"
  head "https://github.com/nithilgadde/armada.git", branch: "master"

  depends_on :macos
  depends_on xcode: ["15.0", :build]
  depends_on "ffmpeg" => :recommended

  def install
    system "swift", "build",
           "--disable-sandbox",
           "--configuration", "release",
           "-Xlinker", "-rpath", "-Xlinker", "@executable_path/../lib"
    bin.install ".build/release/armada"
  end

  def caveats
    <<~EOS
      To start using Armada:

        # Set a wallpaper
        armada set ~/path/to/video.mp4

        # Set wallpaper and resize to screen resolution
        armada set ~/path/to/video.mp4 --resize-to-screen

        # Check status
        armada status

      For the daemon to start automatically at login, add this to your shell profile:
        armada start

      Or create a LaunchAgent (see documentation).

      Note: The --resize-to-screen option requires ffmpeg (installed as recommended dependency).
    EOS
  end

  test do
    assert_match "armada", shell_output("#{bin}/armada --help")
  end
end
