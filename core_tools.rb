managed_apps = %w{
  ack
  curl
  docker-machine
  docker-compose
  git
  openssl
  thefuck
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
  "macvim" => "mvim"
}

managed_with_alternate_provides.each do |app, bin|
  dep "#{app}.bin" do
    installs app
    provides bin
  end
end

libs = %w{
  readline
  ispell
}

libs.each do |app|
  dep "#{app}.bin" do
    installs app
    provides []
  end
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

dep "all-core-tools" do
  requires *(managed_apps + managed_with_alternate_provides.keys + libs).map { |a| "#{a}.bin" }
  requires "oh-my-zsh"
end
