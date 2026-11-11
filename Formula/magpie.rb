class Magpie < Formula
  desc "Unified gateway and model switcher for AI coding agents"
  homepage "https://usemagpie.ai"
  url "https://github.com/yetone/magpie/archive/refs/tags/v0.1.3665.tar.gz"
  sha256 "4fefa274472ec1af910d5021a17967ac2a0cef90f3c8d83adbb1fb1c652e29f0"
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
