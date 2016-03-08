managed_apps = %w{
  agda
  go
  ghc
  hugo
  lua
  luarocks
  node
  youtube-dl
}

managed_apps.each do |app|
  dep "#{app}.bin" do
    installs app
  end
end

managed_with_alternate_provides = {
  "leiningen" => "lein",
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

libs.each do |app|
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

dep "all-other-tools" do
  requires *(managed_apps + managed_with_alternate_provides.keys + libs).map { |a| "#{a}.bin" }
  requires "extempore"
end
