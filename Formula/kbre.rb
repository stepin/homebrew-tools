class Kbre < Formula
  desc "Automates generation and update of Gradle config files in JS/Python way"
  homepage "https://github.com/stepin/kbre/"
  url "https://github.com/stepin/kbre/archive/refs/tags/1.2.0.tar.gz"
  sha256 "eaf53e45e29b8a23d5713ebc41cb6d96c5539d0f0862336f3367cf094c6df37c"
  license "MIT"
  head "https://github.com/stepin/kbre.git", branch: "main"

  bottle do
    root_url "https://github.com/stepin/homebrew-tools/releases/download/kbre-1.1.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "9051090447d06a99f85bf43068cac28a8706bbf20f2b0f72124e077196232619"
    sha256 cellar: :any_skip_relocation, ventura:      "6b833af8021ff30b3a5cf13b87cdf83f71daf7882d917a678632bf5056ead848"
  end

  depends_on "openjdk@21" => :build

  def install
    ENV["JAVA_HOME"] = Language::Java.java_home("21")
    os = OS.linux? ? "linux" : "macos"
    os2 = OS.linux? ? "Linux" : "Macos"
    suffix = (Hardware::CPU.arch == :x86_64) ? "X64" : "Arm64"
    system "./gradlew", "--no-daemon", "linkReleaseExecutable#{os2}#{suffix}"
    bin.install "build/bin/#{os}#{suffix}/releaseExecutable/kbre.kexe" => "kbre"

    system "bin/generate-completions"
    zsh_completion.install "build/bin/native/kbre.zsh" => "_kbre"
    bash_completion.install "build/bin/native/kbre.bash"
    fish_completion.install "build/bin/native/kbre.fish"
  end

  test do
    output = shell_output(bin/"kbre version")
    assert_match "SNAPSHOT", output
  end
end
