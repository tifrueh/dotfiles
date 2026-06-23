#!/bin/zsh

# = OPTIONS ====================================================================
setopt nullglob

# = GLOBALS ====================================================================

# Script metadata.
scriptdir="${0:A:h}"
scriptname="${0:A:t}"
help_msg="usage: %s ( link | unlink | init | status ) <module>

subcommands:
    link        Link a module.
    unlink      Unlink a module.
    init        Initialise a module (create a .state.zsh).
    status      Get some information about a module.

arguments:
    <module>    The path to the module to operate upon.

environment:
    DEBUG       Set for debug output.
    NOINFO      Set to suppress informational messages.
    NOWARN      Set to suppress warnings.
"

# Template for the automatic update of the state file.
state_template="MOD_ROOT=%s
MOD_LINKED=%d
"

# Template for the status message.
status_template="Module: %s
Root Directory: %s
Linked: %s
"

# Globals that will be set by the sourcing procedure.
MOD_DIR=""
MOD_ROOT=""
MOD_LINKED=""

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
    if [[ $# -ne 2 || ! ( "${1}" == "link" || "${1}" == "unlink" || "${1}" == "init" || "${1}" == "status" ) ]]; then
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
#
# Also sets the following variables:
#  MOD_DIR      Absolute path to the module to validate.
#  MOD_ROOT     Absolute path to the module root.
#  MOD_LINKED   Whether or not the module is already linked.
validate_and_source () {

    debug "Validating ${1}."

    MOD_DIR="${1:P}"
    if [[ ! -d "${MOD_DIR}" ]]; then
        error "Module ${MOD_DIR} not found. Either it does not exist or is not a directory."
    fi
    debug "Found module directory ${MOD_DIR}."

    local state_file="${MOD_DIR}/.state.zsh"
    if [[ ! -f "${state_file}" ]]; then
        error "State file of module ${1} not found. Either it does not exist or is not a regular file."
    fi
    debug "Found state file ${state_file}."

    source "${state_file}"
    debug "Sourced state file ${state_file}."

    if [[ ! -v MOD_ROOT ]]; then
        error "State file ${state_file} does not set MOD_ROOT."
    fi
    MOD_ROOT="${MOD_ROOT:P}"
    if [[ -e "${MOD_ROOT}" && ! -d "${MOD_ROOT}" ]]; then
        error "Module root ${MOD_ROOT} exists and is not a directory."
    fi
    if [[ "${MOD_ROOT}" == "/NOTSET" ]]; then
        error "MOD_ROOT has not been configured."
    fi
    debug "Read MOD_ROOT: ${MOD_ROOT}"

    if [[ "${MOD_LINKED}" -ne 1 ]]; then
        MOD_LINKED=0
        debug "Set MOD_LINKED: 0"
    fi
    debug "Read MOD_LINKED: ${MOD_LINKED}"

    debug "Loaded module ${MOD_DIR}."
}

# Fn: Link all regular files in a directory recursively (except the ones that
# contain module metadata). Depends upon finished globals initialisation!
#
# Synopsis
#   rec_link DIR CONTEXT
#
# Description
#   DIR         The ABSOLUTE (!) path to the directory to link the contents of.
#   CONTEXT     The path relative to MOD_ROOT of the directory that the links
#               should be placed in.
rec_link () {

    debug "Linking ${1} recursively with context ${2}."

    local destdir="${MOD_ROOT}/${2}"
    local destdir="${destdir:P}"
    debug "Set destination directory to ${destdir}, creating."
    mkdir -p "${destdir}" || error "Failed to create destination directory ${destdir}."

    for file in ${1}/* ${1}/.*; do
        local file_basename="${file:t}"
        if [[ "${file_basename}" == "README.txt" || "${file_basename}" == ".state.zsh" ]]; then
            debug "Encountered special file ${file}, not linking."
            continue
        fi
        if [[ -d "${file}" ]]; then
            debug "Encountered directory ${file}, entering."
            rec_link "${file}" "${2}/${file_basename}"
            continue
        fi
        if [[ -f "${file}" ]]; then
            debug "Encountered regular file ${file}, linking."
            local destfile="${destdir}/${file_basename}"
            local destfile="${destfile:a}"
            info "Linking ${file} -> ${destfile}"
            ln -s "${file}" "${destfile}" || error "Failed to link ${file}."
        fi
    done
}

# Fn: Execute the link subcommand on a module. Depends upon finished
# globals initialisation!
#
# Synopsis
#   scmd_link
scmd_link () {

    if [[ "${MOD_LINKED}" -eq 1 ]]; then
        error "Module at ${MOD_DIR} already linked, aborting."
    fi

    rec_link "${MOD_DIR}" ""

    printf "${state_template}" "${MOD_ROOT}" 1 > "${MOD_DIR}/.state.zsh" || error "Failed to write state file."

    echo ""

    if [[ -f "${MOD_DIR}/README.txt" ]]; then
        display "${MOD_DIR}/README.txt"
    fi
}

# Fn: Unlink all regular files in a directory recursively and delete the target
# directory if it is empty after that. Depends upon finished globals
# initialisation!
#
# Synopsis
#   rec_unlink DIR CONTEXT
#
# Description
#   DIR         The ABSOLUTE (!) path to the directory to unlink the contents of.
#   CONTEXT     The path relative to MOD_ROOT of the directory that should be
#   unlinked.
rec_unlink () {

    debug "Unlinking ${1} recursively with context ${2}."

    local destdir="${MOD_ROOT}/${2}"
    local destdir="${destdir:P}"
    debug "Set destination directory to ${destdir}."

    for file in ${1}/* ${1}/.*; do
        local file_basename="${file:t}"
        if [[ "${file_basename}" == "README.txt" || "${file_basename}" == ".state.zsh" ]]; then
            debug "Encountered special file ${file}, not unlinking."
            continue
        fi
        if [[ -d "${file}" ]]; then
            debug "Encountered directory ${file}, entering."
            rec_unlink "${file}" "${2}/${file_basename}"
            continue
        fi
        if [[ -f "${file}" ]]; then
            debug "Encountered regular file ${file}, unlinking."
            local destfile="${destdir}/${file_basename}"
            local destfile="${destfile:a}"
            if [[ ! -h "${destfile}" ]]; then
                warn "${destfile} does not exist (or is not a link), continuing."
                continue
            fi
            info "Unlinking ${destfile}."
            rm "${destfile}" || error "Failed to unlink ${destfile}."
        fi
    done

    debug "Removing ${destdir} if it is empty."
    rmdir "${destdir}" 2> /dev/null || debug "Removing ${destdir} failed, leaving in place."
}

# Fn: Execute the unlink subcommand on a module. Depends upon finished globals
# initialisation!
#
# Synopsis
#   scmd_unlink
scmd_unlink () {

    if [[ "${MOD_LINKED}" -ne 1 ]]; then
        error "Module at ${MOD_DIR} not linked, aborting."
    fi

    rec_unlink "${MOD_DIR}" ""

    printf "${state_template}" "${MOD_ROOT}" 0 > "${MOD_DIR}/.state.zsh" || error "Failed to write state file."
}

# Fn: Execute the init subcommand.
#
# Synopsis
#   scmd_init MODULE
#
# Description
#   MODULE              Path to the module.
scmd_init () {
    if [[ -e "${1}/.state.zsh" ]]; then
        error "${1} is already initialised."
    fi
    info "Initialising ${1}."
    printf "${state_template}" "/NOTSET" 0 > "${1}/.state.zsh" || error "Failed to write state file."
    warn "Don't forget to set MOD_ROOT in ${1} before linking."
}

# Fn: Execute the status subcommand.
#
# Synopsis
#   scmd_status
scmd_status () {
    printf "${status_template}" "${MOD_DIR}" "${MOD_ROOT}" "${MOD_LINKED}"
}

# = MAIN =======================================================================

# Validate command line.
validate_cli "${@}"

# Switch on subcommand (placeholder log messages for now).
if [[ "${1}" == "link" ]]; then
    validate_and_source "${2}"
    scmd_link
elif [[ "${1}" == "unlink" ]]; then
    validate_and_source "${2}"
    scmd_unlink
elif [[ "${1}" == "init" ]]; then
    scmd_init "${2}"
elif [[ "${1}" == "status" ]]; then
    validate_and_source "${2}"
    scmd_status
fi
