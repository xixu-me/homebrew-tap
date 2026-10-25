cask "magpie-app" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.1549"
  sha256 arm:   "2719715e226f77896f7385da2ab4c48b0012411ba2e41afde0b19740114ae3ef",
         intel: "f6a2edeabe0ba272d7644ca2bd5978d97bf56f6a33e9661735858339dd7197be"

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
