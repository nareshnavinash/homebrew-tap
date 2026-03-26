# Homebrew formula for shelldone
# Auto-updated by release workflow

class Shelldone < Formula
  desc "Terminal process completion notifier - OS-native notifications when commands finish"
  homepage "https://github.com/nareshnavinash/shelldone"
  url "https://github.com/nareshnavinash/shelldone/archive/refs/tags/v1.4.1.tar.gz"
  sha256 "ce0badb25bbce13cb1bc9cd69c1b1931300789f0d7a248fd53aa0997c343e721"
  license "MIT"
  head "https://github.com/nareshnavinash/shelldone.git", branch: "main"

  def install
    bin.install "bin/shelldone"
    (lib/"shelldone").install "lib/shelldone.sh", "lib/auto-notify.zsh", "lib/auto-notify.bash",
                    "lib/state.sh", "lib/external-notify.sh", "lib/ai-hook-common.sh",
                    "lib/tui.sh"
    (share/"shelldone/hooks").install Dir["hooks/*.sh"]
    (share/"shelldone").install "VERSION"
    bash_completion.install "completions/shelldone.bash" => "shelldone"
    zsh_completion.install "completions/shelldone.zsh" => "_shelldone"
  end

  def caveats
    <<~EOS
      Add to your shell config (~/.zshrc or ~/.bashrc):

        eval "$(shelldone init zsh)"   # for zsh
        eval "$(shelldone init bash)"  # for bash

      Or run automatic setup:

        shelldone setup
    EOS
  end

  test do
    assert_match "shelldone", shell_output("#{bin}/shelldone version")
  end
end
