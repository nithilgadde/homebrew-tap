class Armada < Formula
  desc "Native macOS live wallpaper manager - set videos and GIFs as desktop wallpaper"
  homepage "https://github.com/nithilgadde/armada"
  url "https://github.com/nithilgadde/armada.git", branch: "main"
  version "1.1.0"
  license "MIT"
  head "https://github.com/nithilgadde/armada.git", branch: "main"

  depends_on :macos

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

        # Set wallpaper on specific display
        armada set ~/path/to/video.mp4 --display 1

        # Check status
        armada status

      For the daemon to start automatically at login, add this to your shell profile:
        armada start

      Or create a LaunchAgent (see documentation).
    EOS
  end

  test do
    assert_match "armada", shell_output("#{bin}/armada --help")
  end
end
