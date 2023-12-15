function gpi --wraps='git cherry-pick -i' --description 'alias gpi=git cherry-pick -i'
  git cherry-pick -i $argv; 
end
