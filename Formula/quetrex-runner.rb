class QuetrexRunner < Formula
  desc "Quetrex Cloud runner — executes AI agents on your machine"
  homepage "https://quetrex.com"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.2.1/quetrex-runner-darwin-arm64"
      sha256 "f0e4781c07cda4b2f54148006cd9b4b5fd925774817b3b9565c99b3f60b201da"
    else
      # Intel Mac — use ARM binary under Rosetta until native Intel build ships
      url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.2.1/quetrex-runner-darwin-arm64"
      sha256 "f0e4781c07cda4b2f54148006cd9b4b5fd925774817b3b9565c99b3f60b201da"
    end
  end

  on_linux do
    url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.2.1/quetrex-runner-linux-x64"
    sha256 "092fc8d8e44df4cbec5b63ae8d079a39860f5cc7de1b54289cea47680f04976d"
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
