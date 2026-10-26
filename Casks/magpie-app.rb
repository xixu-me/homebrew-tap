cask "magpie-app" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.1601"
  sha256 arm:   "44a82883e834c0c74e45f4b1ce07a91358b7aad4813bcfe9e1d7e9fdf39a9bb2",
         intel: "582e6a17be0e8687430cbfb7fe69ee8f0a1d3dbb96fd1658cd03644b30468f0d"

  url "https://github.com/yetone/magpie-releases/releases/download/v#{version}/magpie-darwin-#{arch}.zip"
  name "magpie"
  desc "Unified gateway and model switcher for AI coding agents"
  homepage "https://usemagpie.ai/"

  livecheck do
    url "https://github.com/yetone/magpie-releases"
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :monterey

  app "magpie.app"
  binary "#{appdir}/magpie.app/Contents/MacOS/magpie"

  uninstall launchctl: "com.yetone.magpie",
            quit:      "com.yetone.magpie",
            script:    {
              executable: "/bin/sh",
              args:       [
                "-c",
                <<~SH,
                  set -eu
                  app_binary="$1"
                  shift
                  for link in "$@"; do
                    if [ -L "$link" ] && [ "$(/usr/bin/readlink "$link")" = "$app_binary" ]; then
                      /bin/rm -- "$link"
                    fi
                  done
                SH
                "--",
                "#{appdir}/magpie.app/Contents/MacOS/magpie",
                "#{Dir.home}/.local/bin/magpie",
                "#{Dir.home}/bin/magpie",
                "/opt/homebrew/bin/magpie",
                "/usr/local/bin/magpie",
              ],
            },
            delete:    "~/Library/LaunchAgents/com.yetone.magpie.plist"

  zap script: {
        executable: "/bin/sh",
        args:       [
          "-c",
          <<~SH,
            set -eu
            user_tmp="$(/usr/bin/getconf DARWIN_USER_TEMP_DIR)"
            user_id="$(/usr/bin/id -u)"
            case "$user_tmp" in
              /var/folders/*|/private/var/folders/*) ;;
              *) exit 1 ;;
            esac
            /bin/rm -rf -- "${user_tmp%/}/magpie-claude-work-${user_id}"
            for path in "${user_tmp%/}"/magpie-claude-[0-9]*; do
              suffix="${path##*/magpie-claude-}"
              case "$suffix" in
                ''|*[!0-9]*) continue ;;
              esac
              /bin/rm -rf -- "$path"
            done
          SH
        ],
      },
      trash:  [
        "#{appdir}/.magpie-update",
        "~/.cache/magpie",
        "~/.config/magpie",
        "~/Library/Caches/com.yetone.magpie",
        "~/Library/Caches/magpie",
        "~/Library/HTTPStorages/com.yetone.magpie",
        "~/Library/HTTPStorages/com.yetone.magpie.binarycookies",
        "~/Library/Preferences/com.yetone.magpie.plist",
        "~/Library/Saved Application State/com.yetone.magpie.savedState",
        "~/Library/WebKit/com.yetone.magpie",
        "~/Library/WebKit/magpie",
      ]
end
