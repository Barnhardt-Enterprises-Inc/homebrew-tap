class QuetrexRunner < Formula
  desc "Quetrex Cloud runner — executes AI agents on your machine"
  homepage "https://quetrex.com"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.3.0/quetrex-runner-darwin-arm64"
      sha256 "00c9f0d95b4f7cc603f02c383ee6534f26d72f63dc797d4806a193cee5365e44"
    else
      # Intel Mac — use ARM binary under Rosetta until native Intel build ships
      url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.3.0/quetrex-runner-darwin-arm64"
      sha256 "00c9f0d95b4f7cc603f02c383ee6534f26d72f63dc797d4806a193cee5365e44"
    end
  end

  on_linux do
    url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.3.0/quetrex-runner-linux-x64"
    sha256 "8b8059af86570459287f0539431672a6ed00cd55a386607a9f9105ddf2e7ae14"
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
