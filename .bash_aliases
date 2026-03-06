# Configure bmdcfg alias for configuration management with git
alias bmdcfg='git --git-dir=$HOME/.bmdcfg/ --work-tree=$HOME'

# If running in WSL, set ssh alias to Windows ssh.exe
# This allows for the BitWarden ssh-agent to operate in WSL
if [ $(echo $WSL_DISTRO_NAME) ]; then
  alias ssh='ssh.exe -F ~/.ssh/config'
  alias ssh-add='ssh-add.exe'
  alias scp='scp.exe'
  alias sftp='sftp.exe'
fi
