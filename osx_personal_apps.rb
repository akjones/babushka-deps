#http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-macosx-x64.dmg

dep "GPGTools.installer" do
  source "https://releases.gpgtools.org/GPG%20Suite%20-%202013.10.22.dmg"
  met? { "/Applications/GPG\ Keychain\ Access.app".p.exists? }
end

dep "VLC.app" do
  source "http://get.videolan.org/vlc/2.1.1/macosx/vlc-2.1.1.dmg"
end

dep "Dropbox.app" do
  source "https://www.dropbox.com/download?plat=mac"
end

dep "Adium.app" do
  source "http://jaist.dl.sourceforge.net/project/adium/Adium_1.5.9.dmg"
end

dep "Crashplan.app" do
  source "https://download.code42.com/installs/mac/install/CrashPlan/CrashPlan_4.5.2_Mac.dmg"
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

dep "Sparrow" do
  met? { "/Applications/Sparrow.app".p.exist? }
  meet { unmeetable! "Install Sparrow via the App Store." }
end

dep "KeePassX.app" do
  source "https://www.keepassx.org/releases/2.0.2/KeePassX-2.0.2.dmg"
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
  source "http://download.skype.com/macosx/d5410ef3de6d9f31d74f1f684db3dfdf/Skype_7.21.350.dmg"
end

dep "GIMP.app" do
  source "https://download.gimp.org/mirror/pub/gimp/v2.8/osx/gimp-2.8.16-x86_64.dmg"
end

dep "IntelliJ.app" do
  source "https://download.jetbrains.com/idea/ideaIC-15.0.4-custom-jdk-bundled.dmg"
  provides "IntelliJ IDEA 15 CE.app"
  version "15.0.4"
end

dep "osx-binaries" do
  requires "core:homebrew"
  requires "GPGTools.installer"
  requires "VLC.app"
  requires "Dropbox.app"
  requires "Adium.app"
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

dep "osx-oersonal" do
  requires "osx-binaries"
  requires "personal-osx-binaries"
  requires "app-store"
  requires "apps-with-eula"
  requires "all-osx-settings"
end
