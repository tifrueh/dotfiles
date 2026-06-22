#!/bin/zsh

# = GLOBALS ====================================================================

scriptdir="${0:A:h}"
scriptname="${0:A:t}"
help_msg="usage: %s ( mount | unmount ) <module>

subcommands:
    mount       Mount a module.
    unmount     Unmount a module.

arguments:
    <module>    The path to the module to operate upon.

environment:
    DEBUG       Set for debug output.
    NOINFO      Set to suppress informational messages.
    NOWARN      Set to suppress warnings.
"

# = FUNCTIONS ==================================================================

# Fn: Print help message.
#
# Synopsis
#   print_help
print_help () {
    printf "${help_msg}" "${scriptname}"
}

# Fn: Display a file to the terminal.
#
# Synopsis
#   display FILE
#
# Description
#   FILE        The path to the file to display.
display () {
    less -F "${1}"
}

# Fn: Log a message.
# THIS IS NOT SUPPOSED TO BE CALLED DIRECTLY. USE THE error, warn, info AND
# debug FUNCTIONS.
#
# Synopsis
#   log_msg MESSAGE LEVEL
#
# Description
#   MESSAGE     The message to log.
#   LEVEL       The log level the message is at.
log_msg () {
    printf '%s:%s: %s\n' "${scriptname}" "${2}" "${1}"
}

# Fn: Log an error and abort.
#
# Synopsis
#   error MESSAGE
error () {
    log_msg "${1}" "ERROR"
    exit 1
}

# Fn: Log a warning.
#
# Synopsis
#   warn MESSAGE
warn () {
    [[ -v NOWARN ]] && return 0
    log_msg "${1}" "WARN"
}

# Fn: Log an informational message.
#
# Synopsis
#   info MESSAGE
info () {
    [[ -v NOINFO ]] && return 0
    log_msg "${1}" "INFO"
}

# Fn: Log a debug message.
#
# Synopsis
#   debug MESSAGE
debug () {
    [[ ! -v DEBUG ]] && return 0
    log_msg "${1}" "DEBUG"
}

# Fn: Validate that the command line adheres to the specified syntax.
#
# Synopsis
#   validate_cli ARGS
#
# Description
#   ARGS        An array of command line arguments.
validate_cli () {
    if [[ $# -ne 2 || ! ( "${1}" == "mount" || "${1}" == "unmount" ) ]]; then
        print_help
        exit 1
    fi
}

# Fn: Validate and source a module.
#
# Synopsis
#   validate_and_source MODULE
#
# Description
#   MODULE      Path to the module to validate and source.
validate_and_source () {

    debug "Validating ${1}."

    mod_dir="${1:A}"
    if [[ ! -d "${1}" ]]; then
        error "Module ${1} not found. Either it does not exist or is not a directory."
    fi
    debug "Found module directory ${mod_dir}."

    state_file="${mod_dir}/.state.zsh"
    if [[ ! -f "${state_file}" ]]; then
        error "State file of module ${1} not found. Either it does not exist or is not a regular file."
    fi
    debug "Found state file ${state_file}."

    source "${state_file}"
    debug "Sourced state file ${state_file}."

    if [[ ! -v MOD_ROOT ]]; then
        error "State file ${state_file} does not set MOD_ROOT."
    fi
    debug "Read MOD_ROOT: ${MOD_ROOT}"

    if [[ "${MOD_LINKED}" -ne 1 ]]; then
        MOD_LINKED=0
        debug "Set MOD_LINKED: 0"
    fi
    debug "Read MOD_LINKED: ${MOD_LINKED}"

    info "Loaded module ${mod_dir}."
}

# = MAIN =======================================================================

# Validate command line.
validate_cli "${@}"

# Validate and source passed module.
validate_and_source "${2}"

# Switch on subcommand (placeholder log messages for now).
if [[ "${1}" == "mount" ]]; then
    info "Execute mount on ${2}."
elif [[ "${1}" == "unmount" ]]; then
    info "Execute unmount on ${2}."
fi
