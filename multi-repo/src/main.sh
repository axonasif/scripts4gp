use std::print::log;

function main() {
	local _multi_repo_list=("${@}");
    local _repos_name='repos';
    local _gitmodules_name='.gitmodules';
    local _gitignore_name='.gitignore';
	local _base_dir="$PWD";
	local _repo _task;

    for _repo in "${_multi_repo_list[@]}"; do {
		IFS='+' read -r _repo _task <<<"${_repo%.git}" && : "${_task:="none"}";
        local _repo_name="${_repo##*/}" && _repo_name="${_repo_name}";
		local _repo_dir="$_base_dir/$_repos_name/$_repo_name";

        (
	        log::info "Setting up $_repo ...";
			git clone --depth=1 "$_repo" "$_repo_dir" && {
				if test "$_task" != "base"; then {
					printf '%s\n' \
						"[submodule \"${_repo_name}\"]" \
						"	path = ${_repos_name}/${_repo_name}" \
						"	url = ${_repo}.git" >> "$_base_dir/${_gitmodules_name}";
				} fi
			}

			if test "$_task" == "open"; then {
				log::info "Launching $_repo_name in a separate VSCODE instance";
				code "$_base_dir/${_repos_name}/${_repo_name}";
			} elif test "$_task" == "base"; then {
				log::info "Using $_repo_name as base repository";
				rm -rf "$_base_dir/.git" && mv "$_repo_dir/.git" "$_base_dir/";
				git -C "$_base_dir" reset --hard;
				rm -rf "$_repo_dir";
			} fi

		) &
		
    } done

	wait;

    # Make git ignore the `repos/` and `.gitmodules` dir
    printf '%s\n' "/${_repos_name}/" "/${_gitmodules_name}" >> "$_base_dir/${_gitignore_name}";
}

