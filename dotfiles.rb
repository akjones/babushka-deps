dep 'dotfiles' do
  met? { '~/.dotfiles'.p.exists? }

  meet {
    git "https://github.com/akjones/dotfiles.git", :to => '~/.dotfiles'
    shell 'find ~/.dotfiles -d 1 -name ".*" | grep -v ".git$" | xargs -I % ln -s % ~ --force'
  }
end
