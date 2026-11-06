class Magpie < Formula
  desc "Unified gateway and model switcher for AI coding agents"
  homepage "https://usemagpie.ai"
  url "https://github.com/yetone/magpie/archive/refs/tags/v0.1.3189.tar.gz"
  sha256 "c3a413cac7907af6011fb1544607446decec78fff3d03b189d76fa5cb81e2859"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-tags", "nogui", "-trimpath",
           "-ldflags=-s -w -X main.version=#{version}", "-o", bin/"magpie", "."
  end

  test do
    assert_match "magpie #{version}", shell_output("#{bin}/magpie --version")
  end
end
