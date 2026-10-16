class Magpie < Formula
  desc "Unified gateway and model switcher for AI coding agents"
  homepage "https://usemagpie.ai"
  url "https://github.com/yetone/magpie/archive/refs/tags/v0.1.1268.tar.gz"
  sha256 "ce6a34d45c43b9b936a3343e267b1dc56cde7ffcb4a514bbf919f8a14bb1233d"
  license "MIT"

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
