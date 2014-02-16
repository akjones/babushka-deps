dep "VLC.app" do
  source "http://get.videolan.org/vlc/2.1.1/macosx/vlc-2.1.1.dmg"
end

dep "VirtualBox.installer" do
  source "http://download.virtualbox.org/virtualbox/4.3.6/VirtualBox-4.3.6-91406-OSX.dmg"
end

dep "Vagrant.installer" do
  requires "VirtualBox.installer"

  met? { "/usr/bin/vagrant".p.exists? }
  source "https://dl.bintray.com/mitchellh/vagrant/Vagrant-1.4.3.dmg"
end

dep "Dropbox.app" do
  source "https://www.dropbox.com/download?plat=mac"
end

dep "Alfred.app" do
  source "http://cachefly.alfredapp.com/Alfred_2.1.1_227.zip"
end

dep "iTerm.app" do
  source "http://iterm2.com/downloads/stable/iTerm2_v1_0_0.zip"
end

dep "Spectacle.app" do
  source "https://s3.amazonaws.com/spectacle/downloads/Spectacle+0.8.4.zip"
end

dep "Adium.app" do
  source "http://jaist.dl.sourceforge.net/project/adium/Adium_1.5.9.dmg"
end

dep "Caffeine.app" do
  source "http://download.lightheadsw.com/download.php?software=caffeine"
end

dep "Crashplan.app" do
  source "http://download.code42.com/installs/mac/install/CrashPlan/CrashPlan_3.6.3_Mac.dmg"
end

dep "Evernote.app" do
  source "http://cdn1.evernote.com/mac/release/Evernote_402491.dmg"
end

dep "Google Chrome.app" do
  source "https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"
end

dep "Firefox.app" do
  source "https://download.mozilla.org/?product=firefox-27.0.1-SSL&os=osx&lang=en-US"
end

dep "Growl" do
  met? { "/Applications/Growl.app".p.exist? }
  meet { unmeetable! "Install Growl via the App Store." }
end

dep "Steam.app" do
  source "http://media.steampowered.com/client/installer/steam.dmg"
end

dep "Spotify" do
  met? { "/Applications/Spotify.app".p.exist? }
  meet { unmeetable! "Install Spotify yourself" }
end

dep "SourceTree.app" do
  source "http://downloads.atlassian.com/software/sourcetree/SourceTree_1.8.1.dmg"
end

dep "Sparrow" do
  met? { "/Applications/Sparrow.app".p.exist? }
  meet { unmeetable! "Install Sparrow via the App Store." }
end

dep "KeePassX.app" do
  source "http://www.keepassx.org/releases/KeePassX-0.4.3.dmg"
end

dep "HandBrake.app" do
  source "http://handbrake.fr/rotation.php?file=HandBrake-0.9.9-MacOSX.6_GUI_x86_64.dmg"
end

dep "Joystick Mapper" do
  met? { "/Applications/Joystick Mapper.app".p.exist? }
  meet { unmeetable! "Install Joystick Mapper via the App Store." }
end

dep "Twitter" do
  met? { "/Applications/Twitter.app".p.exist? }
  meet { unmeetable! "Install Twitter via the App Store." }
end

dep "Reaper" do
  met? { "/Applications/REAPER64.app".p.exist? }
  meet { unmeetable! "Reaper has a eula" }
end

dep "Skype.app" do
  source "http://download.skype.com/macosx/Skype_6.12.60.438.dmg"
end

dep "GIMP.app" do
  source "http://ftp.gimp.org/pub/gimp/v2.8/osx/gimp-2.8.10-dmg-1.dmg"
end

dep "IntelliJ.app" do
  source "http://download-ln.jetbrains.com/idea/ideaIC-13.0.2.dmg"
  provides "IntelliJ IDEA 13 CE.app"
  version "13.0.2"
end

dep "osx-binaries" do
  requires "core:homebrew"
  requires "VLC.app"
  requires "VirtualBox.installer"
  requires "Dropbox.app"
  requires "Vagrant.installer"
  requires "Alfred.app"
  requires "iTerm.app"
  requires "Spectacle.app"
  requires "Adium.app"
  requires "Caffeine.app"
  requires "Google Chrome.app"
  requires "Firefox.app"
  requires "core:xcode tools"
  requires "SourceTree.app"
  requires "Skype.app"
  requires "GIMP.app"
  requires "IntelliJ.app"
end

dep "personal-osx-binaries" do
  requires "Crashplan.app"
  requires "Steam.app"
  requires "Sparrow"
  requires "KeePassX.app"
  requires "HandBrake.app"
end

dep "app-store" do
  requires "Joystick Mapper"
  requires "Growl"
  requires "Twitter"
end

dep "apps-with-eula" do
  requires "Spotify"
  requires "Reaper"
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

dep "capslock-to-ctrl" do
  def vendor_and_product_id
    keyboard_info = shell("ioreg -n IOHIDKeyboard -r")
    vendor_id = keyboard_info.scan(/"VendorID" = (\d+)/).flatten.first
    product_id = keyboard_info.scan(/"ProductID" = (\d+)/).flatten.first

    [vendor_id, product_id]
  end

  met? {
    vendor_id, product_id = vendor_and_product_id
    cmd = "defaults -currentHost read -g com.apple.keyboard.modifiermapping.#{vendor_id}-#{product_id}-0"
    shell?(cmd) && shell(cmd) ==
%Q{(
        {
        HIDKeyboardModifierMappingDst = 2;
        HIDKeyboardModifierMappingSrc = 0;
    }
)}
  }

  meet {
    vendor_id, product_id = vendor_and_product_id
    shell("defaults -currentHost write -g com.apple.keyboard.modifiermapping.#{vendor_id}-#{product_id}-0 -array '<dict><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer><key>HIDKeyboardModifierMappingDst</key><integer>2</integer></dict>'")
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

dep "all-osx-settings" do
  requires "capslock-to-ctrl"
  requires "fast-key-repeat"
  requires "disable-widgets"
  requires "move-dock-right"
  requires "auto-hide-dock"
  requires "enable-assistive-devices"
  requires "additional-prefs"
end

dep "osx" do
  requires "osx-binaries"
  requires "personal-osx-binaries"
  requires "app-store"
  requires "apps-with-eula"
  requires "all-osx-settings"
end
