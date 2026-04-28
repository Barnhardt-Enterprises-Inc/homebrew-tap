class QuetrexRunner < Formula
  desc "Quetrex Cloud runner — executes AI agents on your machine"
  homepage "https://quetrex.com"
  version "0.4.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.4.5/quetrex-runner-darwin-arm64"
      sha256 "884d5328c309fb0b61df3dd28732a878c8fdfbcbbfc2abfb812674695862ae29"
    else
      # Intel Mac — use ARM binary under Rosetta until native Intel build ships
      url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.4.5/quetrex-runner-darwin-arm64"
      sha256 "884d5328c309fb0b61df3dd28732a878c8fdfbcbbfc2abfb812674695862ae29"
    end
  end

  on_linux do
    url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.4.5/quetrex-runner-linux-x64"
    sha256 "3ff673d26b2a9ce9bf8d35915a2717c74cc0ae83a5637f52016f3ec2c067c2f6"
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
