# dotfiles

[Manage Dotfiles With a Bare Git Repository](https://harfangk.github.io/2016/09/18/manage-dotfiles-with-a-git-bare-repository.html)

> # Manage Dotfiles With a Bare Git Repository
> 
> Sep 18, 2016
> 
> After switching from Sublime Text to vim, I started looking for a way to manage my dotfiles. It took me a lot of work to configure and understand them, so I wanted to back them up against emergency. And of course I wanted to have those personal settings wherever I work.
> 
> At first I considered Vagrant, but it seemed like an overkill for just a few dotfiles. My next idea was to symlink dotfiles to a single directory and manage that folder with git. But that also felt unnecessarily complex - surely there would be a simpler way to do this, right?
> 
> And then I found what I was looking for. This method uses a [git bare repository](http://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/), and aliasing git commands to send them to that repo. Simple setup process? Check. Version control in git? Check. Easy installation on different machine? Check. Awesome!
> 
> ### Setup
> 
> Git is the only dependency. The following four lines will set up the bare repository.
> 
>     git init --bare $HOME/.dotfiles.git
>     echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"' >> $HOME/.zshrc
>     source ~/.zshrc
>     dotfiles config --local status.showUntrackedFiles no
> 
> 1.  Create a git bare repository at `~/.dotfiles.git` to track files.
> 2.  Add alias setting to shell configuration file. I use zsh so it’s `.zshrc`. For bash, it’d be `.bashrc`. Note how the paths for git directory and working tree are set.
> 3.  Reload the shell setting.
> 4.  Prevent untracked files from showing up when we call `dotfiles status`.
> 
> That finishes the setup. Use the aliased command from the home directory to manage files, and use git remote repo if you want to manage the files online.
> 
>     dotfiles status
>     dotfiles add .vimrc
>     dotfiles commit -m "Add vimrc"
>     dotfiles remote add origin https://www.github.com/username/repo.git
>     dotfiles push origin master
> 
> ### Installing dotfiles to another system
> 
> It just needs two shell commands before fetching the remote repo.
> 
>     echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"' >> $HOME/.zshrc
>     source ~/.zshrc
>     echo ".dotfiles.git" >> .gitignore
>     git clone --bare https://www.github.com/username/repo.git $HOME/.dotfiles.git
>     dotfiles checkout
>     dotfiles config --local status.showUntrackedFiles no
> 
> 1.  Create alias to ensure that the git bare repository works without problem.
> 2.  Reload the shell setting to use that alias.
> 3.  Add `.dotfiles.git` directory to `.gitignore` to prevent recursion issues.
> 4.  Clone the repo.
> 5.  Check if it works fine.
> 6.  If you already have configuration files with identical names, checkout will fail. Back up and remove those files. Skip back up if you don’t need them.
> 7.  Prevent untracked files from showing up on `dotfiles status`.
> 
> That’s about it! Credit goes to anonymous giants in the Internet for coming up with this, and Nicola Paolucci for elegantly documenting the steps. Here’s the [link](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/) to his original post.
> 
> harfangk
