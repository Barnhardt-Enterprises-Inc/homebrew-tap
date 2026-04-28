class QuetrexRunner < Formula
  desc "Quetrex Cloud runner — executes AI agents on your machine"
  homepage "https://quetrex.com"
  version "0.4.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.4.3/quetrex-runner-darwin-arm64"
      sha256 "cfe9a74cf7cee259cec334658d56ee189452061c75f5dd6ad4305062a0591595"
    else
      # Intel Mac — use ARM binary under Rosetta until native Intel build ships
      url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.4.3/quetrex-runner-darwin-arm64"
      sha256 "cfe9a74cf7cee259cec334658d56ee189452061c75f5dd6ad4305062a0591595"
    end
  end

  on_linux do
    url "https://github.com/Barnhardt-Enterprises-Inc/homebrew-tap/releases/download/runner-v0.4.3/quetrex-runner-linux-x64"
    sha256 "b1e96d39d7aa4d766f1ebe389f2790b1e562cdc71db4a906ba2ea11730d67237"
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
