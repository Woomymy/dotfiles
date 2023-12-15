function gpc --wraps='git cherry-pick --continue' --description 'alias gpc=git cherry-pick --continue'
  git cherry-pick --continue $argv; 
end
