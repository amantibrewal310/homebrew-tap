cask "notchcove" do
  version "0.1.3"
  sha256 "e2b856a20a41771e695d2bb760f0fc616d003c5183a97c572dd6921b44cee05a"

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
