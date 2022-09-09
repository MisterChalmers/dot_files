# shellcheck shell=bash
# shellcheck disable=SC2034 # Expected behavior for themes.

SCM_THEME_PROMPT_DIRTY=" ${red?}✗"
SCM_THEME_PROMPT_CLEAN=" ${bold_green?}✓"
SCM_THEME_PROMPT_PREFIX=" |"
SCM_THEME_PROMPT_SUFFIX="${green?}|"

GIT_THEME_PROMPT_DIRTY=" ${red?}✗"
GIT_THEME_PROMPT_CLEAN=" ${bold_green?}✓"
GIT_THEME_PROMPT_PREFIX=" ${green?}|"
GIT_THEME_PROMPT_SUFFIX="${green?}|"

# Nicely formatted terminal prompt
function prompt_command() {
	local scm_prompt_info
	scm_prompt_info="$(scm_prompt_info)"
	PS1="\n${red}[${yellow?}\@${red?}]-${red?}[${yellow?}\u${red?}@${green?}\h${red?}]-${red?}[${purple?}\w${red?}]-${scm_prompt_info?}\n${reset_color?}\$ "
}

safe_append_prompt_command prompt_command
