dep "MenuMeters.installer" do
  source "http://www.ragingmenace.com/software/download/MenuMeters.dmg"
  provides []
end

dep "Alfred.app" do
  source "https://cachefly.alfredapp.com/Alfred_2.8.2_432.zip"
end

dep "iTerm.app" do
  source "http://iterm2.com/downloads/stable/iTerm2_v1_0_0.zip"
end

dep "Spectacle.app" do
  source "https://s3.amazonaws.com/spectacle/downloads/Spectacle+0.8.4.zip"
end

dep "Caffeine.app" do
  source "http://download.lightheadsw.com/download.php?software=caffeine"
end

dep "osx-common-binaries" do
  requires "MenuMeters.installer"
  requires "Alfred.app"
  requires "iTerm.app"
  requires "Spectacle.app"
  requires "Caffeine.app"
end

dep "enable-full-disk-encryption" do
  met? {
    shell?("fdesetup status").include? "On"
  }

  meet {
    shell("sudo fdesetup enable")
  }
end

dep "set-dock-magnification" do
  met? {
    shell?("defaults read com.apple.dock magnification") &&
      shell("defaults read com.apple.dock magnification").to_i == 0
  }

  meet {
    shell("defaults write com.apple.dock magnification -integer 0")
  }
end

dep "move-dock-right" do
  met? {
    shell?("defaults read com.apple.dock orientation") &&
      shell("defaults read com.apple.dock orientation") == "right"
  }

  meet {
    shell("defaults write com.apple.dock orientation -string 'right'")
  }
end

dep "auto-hide-dock" do
  met? {
    shell?("defaults read com.apple.dock autohide") &&
      shell("defaults read com.apple.dock autohide") == "1"
  }

  meet {
    shell("defaults write com.apple.dock autohide -bool true")
    shell("killall -HUP Dock")
  }
end

dep "disable-widgets" do
  met? {
    cmd = "defaults read com.apple.dashboard mcx-disabled"
    shell?(cmd) &&
      shell(cmd).to_i == 1
  }

  meet {
    shell "defaults write com.apple.dashboard mcx-disabled -boolean YES"
  }
end

dep "fast-key-repeat" do
  met? {
    0 == shell("defaults read NSGlobalDomain KeyRepeat").to_i &&
      15 == shell("defaults read NSGlobalDomain InitialKeyRepeat").to_i
  }

  meet {
    shell("defaults write NSGlobalDomain KeyRepeat -int 0")
    shell("defaults write NSGlobalDomain InitialKeyRepeat -int 15")
  }
end

dep "enable-assistive-devices" do
  met? {
    "/private/var/db/.AccessibilityAPIEnabled".p.exists?
  }

  meet {
    shell "sudo touch /private/var/db/.AccessibilityAPIEnabled"
  }
end

dep "change-shell-to-zsh" do
  requires "zsh.bin"

  met? {
    current_shell = shell("echo $SHELL")
    current_shell.include?("/usr/local") && current_shell.include?("zsh")
  }

  meet {
    installed_zsh = shell("brew info zsh").split("\n")[2].split(/\s/)[0] + "/bin/zsh"
    shell("chsh -s #{installed_zsh}")
    shell("echo '#{installed_zsh}' >> /etc/shells", :sudo => true)
  }
end

dep "additional-prefs" do
  shell("defaults write com.apple.LaunchServices LSQuarantine -bool false")
  shell("defaults write NSGlobalDomain KeyRepeat -int 0")
  shell("defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false")
end

dep "all-osx-common-settings" do
  requires "fast-key-repeat"
  requires "disable-widgets"
  requires "move-dock-right"
  requires "auto-hide-dock"
  requires "enable-assistive-devices"
  requires "additional-prefs"
end

dep "osx-common" do
  requires "osx-common-binaries"
  requires "all-osx-common-settings"
end
