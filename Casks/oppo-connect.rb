cask "oppo-connect" do
  arch arm: "arm64", intel: "x64"

  version "17.20.0"
  sha256 arm:   "52789642c8c6f9f20fed264d19a268fabcb8cdbc9d7130e7b785833392ae09ed",
         intel: "96cbf85bdf193036a95898a2135f88f344feb22f52eb93f76a655d5db5be67cd"

  download_path = if arch == "arm64"
    "57/34"
  else
    "58/15"
  end
  url "https://pc-assistant-cn.allawnfs.com/uploads/web/dmg/2026/09/21/19/#{download_path}/OppoConnect_#{version}_#{arch}_domestic_260916200816_794ab31695.dmg",
      referer: "https://connect.oppo.com/"
  name "OPPO Connect"
  desc "Cross-device connectivity between OPPO devices and computers"
  homepage "https://connect.oppo.com/"

  livecheck do
    skip "Version is returned by a signed API endpoint."
  end

  auto_updates true
  depends_on :macos

  app "O+Connect.app"

  uninstall launchctl:  [
              "com.oplus.dsp.core",
              "com.oplus.dsp.rc",
              "com.oplus.O+Connect.uninstall",
              "com.oplus.openclaw",
              "com.oplus.openclaw.dev",
            ],
            quit:       ["com.oplus.devicespace", "com.oplus.devicespace.remotehelper"],
            login_item: "OPPO 互联",
            delete:     [
              "/Library/Application Support/O+ConnectRoot",
              "/Library/LaunchAgents/com.oplus.dsp.rc.plist",
              "/Library/LaunchAgents/com.oplus.openclaw.dev.plist",
              "/Library/LaunchAgents/com.oplus.openclaw.plist",
              "/Library/LaunchDaemons/com.oplus.dsp.core.plist",
              "/Library/LaunchDaemons/com.oplus.O+Connect.uninstall.plist",
            ]

  zap script: {
        executable: "/bin/rm",
        args:       [
          "-rf",
          "--",
          "/Library/Application Support/O+Connect",
          "/Library/Logs/devicespace",
        ],
        sudo:       true,
      },
      trash:  [
        "~/Library/Application Scripts/com.oplus.devicespace.extension",
        "~/Library/Application Scripts/com.oplus.devicespace.remotehelper",
        "~/Library/Application Scripts/group.com.oplus.devicespace",
        "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.oplus.devicespace.sfl*",
        "~/Library/Application Support/devicespace",
        "~/Library/Application Support/FileProvider/com.oplus.devicespace.extension",
        "~/Library/Application Support/O+Connect",
        "~/Library/Caches/com.oplus.devicespace",
        "~/Library/CloudStorage/OPPOConnect-DeviceSpace",
        "~/Library/Containers/com.oplus.devicespace.extension",
        "~/Library/Containers/O+Connect",
        "~/Library/Group Containers/group.com.oplus.devicespace",
        "~/Library/HTTPStorages/com.oplus.devicespace",
        "~/Library/Logs/devicespace",
        "~/Library/Logs/devicespace-daemon",
        "~/Library/Logs/O+Connect",
        "~/Library/Preferences/com.oplus.devicespace.plist",
        "~/Library/Saved Application State/com.oplus.devicespace.savedState",
      ]
end
