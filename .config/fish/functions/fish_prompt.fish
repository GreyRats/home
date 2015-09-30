function fish_prompt --description 'Write out the prompt'
    set -l fish_color_status red
    set -l fish_color_cwd magenta
    set -l fish_color_venv blue
    set -l fish_color_git yellow
    set -l last_status $status

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q -g __fish_classic_git_functions_defined
        set -g __fish_classic_git_functions_defined
        function __fish_repaint_user --on-variable fish_color_user --description "Event handler, repaint when fish_color_user changes"
            if status --is-interactive
                commandline -f repaint ^/dev/null
            end
        end
        
        function __fish_repaint_host --on-variable fish_color_host --description "Event handler, repaint when fish_color_host changes"
            if status --is-interactive
                set -e __fish_prompt_host
                commandline -f repaint ^/dev/null
            end
        end
        
        function __fish_repaint_status --on-variable fish_color_status --description "Event handler; repaint when fish_color_status changes"
            if status --is-interactive
                set -e __fish_prompt_status
                commandline -f repaint ^/dev/null
            end
        end
    end

    set -l delim '>'

    set -g __fish_prompt_cwd (set_color $fish_color_cwd)

    set -l prompt_status

    if test $last_status -ne 0
        if not set -q __fish_prompt_status
            set -g __fish_prompt_status (set_color $fish_color_status)
        end
        set prompt_status "$__fish_prompt_status [$last_status]"
    end

    if set -q VIRTUAL_ENV
        echo -n -s (set_color $fish_color_venv) "("(basename "$VIRTUAL_ENV")")" "$__fish_prompt_normal"
    end

    if not set -q __fish_prompt_git
        set -g __fish_prompt_git (set_color $fish_color_git)
    end
    echo -n -s "$__fish_prompt_cwd" (prompt_pwd)"$__fish_prompt_git" (__fish_git_prompt)'  ' "$prompt_status" "$__fish_prompt_normal" "$delim" ' '
end
