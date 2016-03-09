dep "emacs" do
  met? { "/opt/boxen/homebrew/bin/emacs".p.exist? }
  meet { shell("brew install emacs --cocoa", log: true) }
end

dep 'spacemacs' do
  requires "emacs"

  met? { '~/.emacs.d'.p.exists? }

  meet {
    git "https://github.com/syl20bnr/spacemacs", :to => '~/.dotfiles'
    shell 'find ~/.emacs.d -d 1 -name ".*" | grep -v ".git$" | xargs -I % ln -s % ~ --force'
  }
end
