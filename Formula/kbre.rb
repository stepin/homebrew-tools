class Kbre < Formula
  desc "Automates generation and update of Gradle config files in JS/Python way"
  homepage "https://github.com/stepin/kbre/"
  url "https://github.com/stepin/kbre/archive/refs/tags/1.0.0.tar.gz"
  sha256 "ce9bb96126075634d0bfa1e24f0a9f2ac0253e70d5fd5ed71b654a9fa8660e0f"
  license "MIT"
  head "https://github.com/stepin/kbre.git", branch: "main"

  depends_on "openjdk@21" => :build

  def install
    ENV["JAVA_HOME"] = Language::Java.java_home("21")
    os = OS.linux? ? "linux" : "macos"
    os2 = OS.linux? ? "Linux" : "Macos"
    suffix = (Hardware::CPU.arch == :x86_64) ? "X64" : "Arm64"
    system "./gradlew", "--no-daemon", "linkReleaseExecutable#{os2}#{suffix}"
    bin.install "build/bin/#{os}#{suffix}/releaseExecutable/kbre.kexe" => "kbre"
  end

  test do
    output = shell_output(bin/"kbre version")
    assert_match "SNAPSHOT", output
  end
end
