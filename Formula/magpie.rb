class Magpie < Formula
  desc "Unified gateway and model switcher for AI coding agents"
  homepage "https://usemagpie.ai"
  url "https://github.com/yetone/magpie/archive/refs/tags/v0.1.4104.tar.gz"
  sha256 "e0a9daf4e8ec44fc3ba52b31a8b53ece39498262bb6c7dc1a3af2f6154354afb"
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
