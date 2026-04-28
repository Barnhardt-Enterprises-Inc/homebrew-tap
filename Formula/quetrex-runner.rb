class QuetrexRunner < Formula
  desc "Quetrex Cloud runner — executes AI agents on your machine"
  homepage "https://quetrex.com"
  version "0.4.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.4.6/quetrex-runner-darwin-arm64"
      sha256 "0b1fdfbcc4a88ff89081dfccdb9ee825c3c04ff89d727111ef255cbddf15a81a"
    else
      # Intel Mac — use ARM binary under Rosetta until native Intel build ships
      url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.4.6/quetrex-runner-darwin-arm64"
      sha256 "0b1fdfbcc4a88ff89081dfccdb9ee825c3c04ff89d727111ef255cbddf15a81a"
    end
  end

  on_linux do
    url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.4.6/quetrex-runner-linux-x64"
    sha256 "1b9c68d9b631473bc4c2ecf68cf531c6f9686bf180dab0296e4b9010c6aeaf91"
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

  # Expose the runner to `brew services` so upgrades can be restarted via
  # `brew services restart quetrex-runner` instead of manual launchctl calls.
  # The runner reads QUETREX_CLOUD_URL and QUETREX_RUNNER_TOKEN from
  # ~/.quetrex-runner/config.json — written by `quetrex-runner connect`.
  service do
    run [opt_bin/"quetrex-runner"]
    keep_alive true
    log_path var/"log/quetrex-runner.log"
    error_log_path var/"log/quetrex-runner.error.log"
  end
end
