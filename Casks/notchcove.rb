cask "notchcove" do
  version "0.1.1"
  sha256 "8e9cbd27ced719166a2af9749a222450ff9570f8c2d7f92f72a1cf130b730bb9"

  url "https://github.com/amantibrewal310/NotchCove/releases/download/v#{version}/NotchCove-#{version}.zip"
  name "NotchCove"
  desc "Drop shelf that lives in the MacBook notch"
  homepage "https://github.com/amantibrewal310/NotchCove"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "NotchCove.app"

  # The app is ad-hoc signed, not notarized; without this Gatekeeper refuses to
  # open it. Cleared on the unpacked copy, before it moves to Applications.
  preflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "NotchCove.app"], chdir: "."
  end

  uninstall quit: "com.notchcove.app"

  zap trash: [
    "~/Library/Application Support/NotchCove",
    "~/Library/Preferences/com.notchcove.app.plist",
  ]
end
