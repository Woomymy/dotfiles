set fish_prompt_error "\e[91m"
set tertiary "\e[96m"
set primary "\e[95m"
set reset "\e[39m"
set bold "\e[1m"

function schget
    string replace '#' '' (jq -r ".$argv[1]" "/tmp/mu_scheme.json")
end

function update_colors --description "Update prompt colors"
    if test -f "/tmp/mu_scheme.json"
        set primary (set_color (schget "primary"))
        set tertiary (set_color (schget "tertiary"))
        set fish_prompt_error (set_color (schget "error"))
    end
end

update_colors

function fish_prompt --description "Write the prompt"
	set prevstatus $status
	update_colors
    if not test $prevstatus = "0"
		set prompt_status "$fish_prompt_error [$prevstatus]$reset"
	else
		set prompt_status ""
	end

	echo -nse "$primary" "$USER" "$reset" @ (prompt_hostname) "$primary" " " (prompt_pwd) "$reset" " (" (date +%H:%M) ")" "$tertiary$bold" (fish_vcs_prompt) "$reset" "$prompt_status" "$primary" " \$$reset "
end
