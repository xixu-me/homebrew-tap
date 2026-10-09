class Tzst < Formula
  include Language::Python::Virtualenv

  desc "Zstandard-compressed tar archive utility"
  homepage "https://github.com/xixu-me/tzst"
  url "https://github.com/xixu-me/tzst/archive/refs/tags/v1.3.3.tar.gz"
  sha256 "d7c2ff021d2660f025868e3df17b3cc1db8d6dcebdd42600b37c2c85147bfc18"
  license "BSD-3-Clause"

  depends_on "cffi"
  depends_on "python@3.14"

  resource "zstandard" do
    url "https://files.pythonhosted.org/packages/fd/aa/3e0508d5a5dd96529cdc5a97011299056e14c6505b678fd58938792794b1/zstandard-0.25.0.tar.gz"
    sha256 "7713e1179d162cf5c7906da876ec2ccb9c3a9dcbdffef0cc7f70c3667a205f0b"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"tzst", "--help"

    (testpath/"input.txt").write "Homebrew"
    system bin/"tzst", "a", testpath/"archive.tzst", testpath/"input.txt"
    system bin/"tzst", "t", testpath/"archive.tzst"
  end
end
