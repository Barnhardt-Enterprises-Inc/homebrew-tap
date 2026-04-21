class QuetrexRunner < Formula
  desc "Quetrex Cloud runner — executes AI agents on your machine"
  homepage "https://quetrex.com"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.2.0/quetrex-runner-darwin-arm64"
      sha256 "20ce7880fcb56383be6756d19d1a6e6ac4ae7f86ac20f2be3f9203662b150c3d"
    else
      # Intel Mac — use ARM binary under Rosetta until native Intel build ships
      url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.2.0/quetrex-runner-darwin-arm64"
      sha256 "20ce7880fcb56383be6756d19d1a6e6ac4ae7f86ac20f2be3f9203662b150c3d"
    end
  end

  on_linux do
    url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.2.0/quetrex-runner-linux-x64"
    sha256 "a969b215f634f08257022805ff3ad1a460f95d59a60538d570ad5a59ab37dbdb"
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
