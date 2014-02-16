managed_apps = %w{
  ack
  curl
  git
  lua
  luarocks
  node
  tree
  zsh
}

managed_apps.each do |app|
  dep "#{app}.bin" do
    installs app
  end
end

managed_with_alternate_provides = {
  "the_silver_searcher" => "ag",
  "leiningen" => "lein",
  "macvim" => "mvim"
}

managed_with_alternate_provides.each do |app, bin|
  dep "#{app}.bin" do
    installs app
    provides bin
  end
end

libs = %w{
  libusb
}

libs.each do |app, bin|
  dep "#{app}.bin" do
    installs app
    provides []
  end
end

dep "extempore" do
  requires "extempore-osx-tapped"

  met? { "/usr/local/Cellar/extempore/HEAD/extempore".p.exist? }
  meet { shell "brew install extempore --HEAD", log: true }
end

dep "extempore-osx-tapped" do
  met? {
    shell("brew tap").include? "benswift/extempore"
  }

  meet {
    shell("brew tap benswift/extempore")
  }
end

dep "emacs" do
  met? { "/usr/local/Cellar/emacs/24.3/Emacs.app".p.exist? }
  meet { shell("brew install emacs --cocoa", log: true) }
end

dep "nvm" do
  requires "curl.bin"
  met? { "#{ENV["HOME"]}/.nvm".p.exist? }
  meet { shell "curl https://raw.github.com/creationix/nvm/master/install.sh | sh" }
end

dep "rvm" do
  met? { "~/.rvm/scripts/rvm".p.exist? }
  meet { shell "curl -sSL https://get.rvm.io | sh ", log: true }
end

dep "oh-my-zsh" do
  requires "curl.bin"
  requires "zsh.bin"
  met? { "~/.oh-my-zsh".p.exist? }
  meet { shell "curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh", log: true }
end

dep "all-managed-apps" do
  requires *(managed_apps + managed_with_alternate_provides.keys).map { |a| "#{a}.bin" }
  requires "extempore"
  requires "emacs"
  requires "nvm"
  requires "rvm"
  requires "oh-my-zsh"
end
