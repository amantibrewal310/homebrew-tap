cask "accio" do
  version "0.4.0"
  sha256 "087d6e89b5226fc69736726e3a27e0c4e15d91cf775e155ffd0f4fc208b89938"

  url "https://github.com/amantibrewal310/Accio/releases/download/v#{version}/Accio-#{version}.zip"
  name "Accio"
  desc "Menu bar manager that hides items and brings them back on demand"
  homepage "https://github.com/amantibrewal310/Accio"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Accio.app"

  # Accio isn't notarized (no paid Apple developer account), so Gatekeeper
  # would refuse to open it, saying it can't check it for malware. Installing
  # with Homebrew is the user's go-ahead, so lift the download quarantine.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Accio.app"]
  end

  uninstall quit: "com.accio.app"

  zap trash: "~/Library/Preferences/com.accio.app.plist"

  caveats <<~EOS
    Accio asks for Accessibility access on first launch, which it uses to see
    and arrange your menu bar items.
  EOS
end
