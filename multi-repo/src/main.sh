use std::print::log;

function main() {
	local _multi_repo_list=("${@}");
    local _repos_name='repos';
    local _gitmodules_name='.gitmodules';
    local _gitignore_name='.gitignore';
	local _repo _task;

    for _repo in "${_multi_repo_list[@]}"; do {
		IFS='+' read -r _repo _task <<<"${_repo%.git}" && : "${_task:="none"}";
        local _repo_name="${_repo##*/}" && _repo_name="${_repo_name}";

        (
	        log::info "Setting up $_repo ...";
			git clone --depth=1 "$_repo" "$PWD/$_repos_name/$_repo_name" && {
            printf '%s\n' \
				"[submodule \"${_repo_name}\"]" \
				"	path = ${_repos_name}/${_repo_name}" \
				"	url = ${_repo}.git" >> "$PWD/${_gitmodules_name}";
        	}

			if test "$_task" == "open"; then {
				log::info "Launching $_repo_name in a separate VSCODE instance";
				code "$PWD/${_repos_name}/${_repo_name}";
			} fi

		) & wait;
		
    } done

    # Make git ignore the `repos/` and `.gitmodules` dir
    printf '%s\n' "/${_repos_name}/" "/${_gitmodules_name}" >> "$PWD/${_gitignore_name}";
}

