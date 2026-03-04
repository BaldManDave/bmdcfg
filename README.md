Configure the BMD working environment on Linux

Configures the bmdcfg alias to pull configuration files from github.
Git repo is stored in .bmdcfg and files are placed relative to the user home directory.

Derived from: https://www.atlassian.com/git/tutorials/dotfiles

Overview:
* Check for git
* Clone repo
* Setup alias
* set global config to ignore files not from git
* set global config to enable sparsecheckout
* set sparse checkout to ignore README.md
* Perform checkout
* If there are errors:
  * perform checkout to determine problematic files
  * backup/remove files
  * Perform checkout again

Copypasta below to setup:
*****************************************

if [ ! -f /usr/bin/git ]; then echo "Install git first."; exit; fi
git clone --bare https://github.com/BaldManDave/bmdcfg.git $HOME/.bmdcfg
alias bmdcfg='git --git-dir=$HOME/.bmdcfg/ --work-tree=$HOME'
bmdcfg config status.showUntrackedFiles no
bmdcfg config core.sparsecheckout true
echo -e '/*\n!README.md' > ~/.bmdcfg/info/sparse-checkout
bmdcfg checkout >/dev/null 2>&1
if [ $? = 0 ]; then
echo "Checked out bmdcfg.";
else
echo "Backing up pre-existing dot files.";
mkdir -p .bmdcfg-backup
bmdcfg checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .bmdcfg-backup/{}
fi;
bmdcfg checkout && echo "Checked out bmdcfg."

*****************************************
