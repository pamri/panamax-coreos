require "formula"


class Panamax < Formula
  homepage "http://www.panamax.io"
  url "http://download.panamax.io/installer/panamax-0.6.5.tar.gz"
  sha256 "b59f21e5a821a3886eab0e62f85fc89d8fedea6099b79d3447906dfc36d163d7"
  def install
    system "./configure", "--prefix=#{prefix}", "--var=#{var}/panamax"
    system "make", "install"
    resource("additional_files").stage { bin.install "panamaxcli-darwin" }
    mv bin/"panamaxcli-darwin",bin/"pmxcli"
  end

  def caveats
    "If upgrading the Panamax Installer, be sure to run 'panamax reinstall' to ensure compatibility with other Panamax components."
  end

  resource "additional_files" do
    url "http://download.panamax.io/panamaxcli/panamaxcli-darwin"
    sha256 "58bd24d40260e269105f21f58369a002b6ebb2d6877f7ac3ffa29e280ecc6007"
  end

  test do
    assert File.exist?("#{prefix}/.panamax")
    assert File.exist?("#{var}/panamax")
    assert_match "#{version}", shell_output("#{prefix}/.panamax/panamax -v").strip
  end
end
