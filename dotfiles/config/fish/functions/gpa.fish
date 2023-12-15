function gpa --wraps='git cherry-pick --abort' --description 'alias gpa=git cherry-pick --abort'
  git cherry-pick --abort $argv; 
end
