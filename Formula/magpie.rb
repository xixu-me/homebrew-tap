class Magpie < Formula
  desc "Unified gateway and model switcher for AI coding agents"
  homepage "https://usemagpie.ai"
  url "https://github.com/yetone/magpie/archive/refs/tags/v0.1.2636.tar.gz"
  sha256 "76af6dc349a87515034fc72a83679b970f3a421539a2e4d6ea5bb5ee2b47e117"
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
