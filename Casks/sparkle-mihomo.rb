cask "sparkle-mihomo" do
  arch arm: "arm64", intel: "x64"

  version "1.26.9"
  sha256 arm:   "301e1daf01b5c836d282e3d0dec779f51e43a8d182b2f850df7a04bcd63cd5ac",
         intel: "a3a60b3c234faa1d9ff99448ebfd4891223887ab63958da45809ab6d26b084ef"

  url "https://github.com/xishang0128/sparkle/releases/download/#{version}/sparkle-macos-#{version}-#{arch}.pkg"
  name "Sparkle"
  desc "Mihomo proxy client"
  homepage "https://github.com/xishang0128/sparkle/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :ventura

  pkg "sparkle-macos-#{version}-#{arch}.pkg"

  uninstall launchctl:  ["SparkleService", "sparkle.helper"],
            quit:       "sparkle.app",
            login_item: { path: "/Applications/Sparkle.app" },
            pkgutil:    "sparkle.app",
            delete:     [
              "/Applications/Sparkle.app",
              "/Library/LaunchDaemons/sparkle.helper.plist",
              "/Library/PrivilegedHelperTools/sparkle.helper",
            ]

  zap script: {
        executable: "/bin/sh",
        args:       [
          "-c",
          <<~SH,
            set -eu
            console_user="$(/usr/bin/stat -f %Su /dev/console)"
            /bin/rm -rf -- \
              "/var/root/Library/Application Support/sparkle" \
              "/Users/${console_user}/Library/Application Support/sparkle" \
              /tmp/sparkle-service.log \
              /tmp/sparkle-service.previous.log \
              /tmp/sparkle-service.sock \
              /tmp/sparkle-mihomo-api.sock \
              /tmp/sparkle-mihomo-api-noperm.sock \
              /tmp/sparkle-mihomo-external.sock \
              /tmp/sparkle.helper \
              /tmp/sparkle-helper.sock
          SH
        ],
        sudo:       true,
      },
      trash:  [
        "~/Library/Application Support/Sparkle",
        "~/Library/Caches/sparkle.app",
        "~/Library/Logs/Sparkle",
        "~/Library/Preferences/sparkle.app.plist",
        "~/Library/Saved Application State/sparkle.app.savedState",
      ]
end
