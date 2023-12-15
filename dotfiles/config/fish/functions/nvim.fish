# Defined in - @ line 1
function nvim --wraps=vim --wraps='nvim -p' --description 'alias nvim=nvim -p'
 command nvim -p $argv;
end
