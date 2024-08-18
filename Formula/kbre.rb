class Kbre < Formula
  desc "Automates generation and update of Gradle config files in JS/Python way"
  homepage "https://github.com/stepin/kbre/"
  url "https://github.com/stepin/kbre/archive/refs/tags/1.2.1.tar.gz"
  sha256 "87d835cd675d79f3a637c6f383a623b2b02bc3d607b0d56ff60dee2330865792"
  license "MIT"
  head "https://github.com/stepin/kbre.git", branch: "main"

  bottle do
    root_url "https://github.com/stepin/homebrew-tools/releases/download/kbre-1.2.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "aa79a15453dd3400efa9638a014cf90103f5d1945876176bcc9959529e487427"
    sha256 cellar: :any_skip_relocation, ventura:      "7225d1357f751a81cc816f9fb3f6f9a1ba6b234960912c37440eccad90f9fa3b"
  end

  depends_on "openjdk@21" => :build

  def install
    ENV["JAVA_HOME"] = Language::Java.java_home("21")
    os = OS.linux? ? "linux" : "macos"
    os_upper_case = OS.linux? ? "Linux" : "Macos"
    suffix = (Hardware::CPU.arch == :x86_64) ? "X64" : "Arm64"
    system "./gradlew", "--no-daemon", "linkReleaseExecutable#{os_upper_case}#{suffix}"
    bin.install "build/bin/#{os}#{suffix}/releaseExecutable/kbre.kexe" => "kbre"

    system "bin/generate-completions"
    zsh_completion.install "build/bin/native/releaseExecutable/kbre.zsh" => "_kbre"
    bash_completion.install "build/bin/native/releaseExecutable/kbre.bash"
    fish_completion.install "build/bin/native/releaseExecutable/kbre.fish"
  end

  test do
    output = shell_output(bin/"kbre version")
    assert_match "SNAPSHOT", output
  end
end
