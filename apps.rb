managed_apps = %w{
  ack
  curl
  emacs
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
  meet { "brew install extempore --HEAD" }
end

dep "extempore-osx-tapped" do
  met? {
    shell("brew tap").include? "benswift/extempore"
  }

  meet {
    shell("brew tap benswift/extempore")
  }
end

dep "nvm" do
  requires "curl.bin"
  met? { "#{ENV["HOME"]}/.nvm".p.exist? }
  meet { shell "curl https://raw.github.com/creationix/nvm/master/install.sh | sh" }
end

dep "rvm" do
  met? {
    "~/.rvm/scripts/rvm".p.file?
  }

  meet {
    shell "bash -c '`curl https://rvm.beginrescueend.com/install/rvm`'"
  }
end

dep "oh-my-zsh" do
  requires "curl.bin"
  requires "zsh.bin"
  met? { "~/.oh-my-zsh".p.exist? }
  meet { "curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh" }
end

dep "all-managed-apps" do
  requires *(managed_apps + managed_with_alternate_provides.keys).map { |a| "#{a}.bin" }
  requires "extempore"
  requires "nvm"
  requires "rvm"
  requires "oh-my-zsh"
end


