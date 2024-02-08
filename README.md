dotfiles
========

Installing using bare repo:

1. Ensure bare repo doesn't track itself: `echo ".dotfiles-repo" >> .gitignore`
2. Clone dotfiles repo into special repo: `git clone --bare https://github.com/neal-erickson/dotfiles.git $HOME/.dotfiles-repo`
3. Ensure there's an alias to use that folder: `alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles-repo --work-tree=$HOME`
4. Set local configuration in .dotfiles-repo: `dotfiles config --local status.showUntrackedFiles no`
5. Checkout latest code: `dotfiles checkout`
6. Add alias in step 3 to your shell profile, e.g. .zshrc

References:
- https://www.atlassian.com/git/tutorials/dotfiles
- https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/
