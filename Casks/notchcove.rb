cask "notchcove" do
  version "0.1.4"
  sha256 "9ea5456ef9bc324ca08576e9e7336c99379f3fee3ae67d2c4aceea7b61825029"

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
