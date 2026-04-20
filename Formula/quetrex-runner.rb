class QuetrexRunner < Formula
  desc "Quetrex Cloud runner — executes AI agents on your machine"
  homepage "https://quetrex.com"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/barnent1/quetrex-cloud/releases/download/runner-v0.1.0/quetrex-runner-darwin-arm64"
      sha256 "76cea0b4fdeb1b420f7319482a934b9ff5e3d7890b71e281fe7f33fffe5b7481"
    else
      url "https://github.com/barnent1/quetrex-cloud/releases/download/runner-v0.1.0/quetrex-runner-darwin-arm64"
      sha256 "76cea0b4fdeb1b420f7319482a934b9ff5e3d7890b71e281fe7f33fffe5b7481"
    end
  end

  on_linux do
    url "https://github.com/barnent1/quetrex-cloud/releases/download/runner-v0.1.0/quetrex-runner-linux-x64"
    sha256 "c2c82d1df4b1df33c3f781d63d3cdf449120fc5c8cb87cb9a7adef1b1928a15e"
  end

  def install
    if OS.mac?
      bin.install "quetrex-runner-darwin-arm64" => "quetrex-runner"
    else
      bin.install "quetrex-runner-linux-x64" => "quetrex-runner"
    end
  end

  test do
    assert_match "quetrex-runner", shell_output("#{bin}/quetrex-runner --help 2>&1", 0)
  end
end
