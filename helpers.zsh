#!/bin/zsh

# Set path variables.
bin_dir="${HOME}/.local/bin"
config_dir="${HOME}/.config"
dunst_dir="${config_dir}/dunst"
hypr_dir="${config_dir}/hypr"
kitty_dir="${config_dir}/kitty"
nvim_colors_dir="${nvim_dir}/colors"
nvim_dir="${config_dir}/nvim"
nvim_plugins_dir="${nvim_dir}/pack/plugins/start"
skhd_dir="${config_dir}/skhd"
tofi_dir="${config_dir}/tofi"
waybar_dir="${config_dir}/waybar"
yabai_dir="${config_dir}/yabai"
zsh_dir="${HOME}/.zsh"
zsh_plugin_dir="${zsh_dir}/plugins"
zsh_themes_dir="${zsh_dir}/themes"

# Setup operations common to all installation scripts: It parses and validates
# the options passed to the script and sets the scriptname, scriptdir and force
# variables.
#
# Synopsis
#   setup ARGV_0 ARGV_@...
#
# Description
#   ARGV_0              $0 of the calling script.
#   ARGV_@...           All elements of $@ of the calling script (simply pass
#                       $@).

setup () {
    scriptname="${1:A:t}"
    scriptdir="${1:A:h}"
    force=false
    if [[ ${#} -gt 2 ]]; then
        print_help "${scriptname}"
        exit 1
    fi
    if [[ ${#} -eq 1 ]]; then
        return
    fi
    if [[ ${2} == "-h" || ${2} == "--help" ]]; then
        print_help "${scriptname}"
        exit 0
    fi
    if [[ ${2} == "-f" || ${2} == "--force-links" ]]; then
        force=true
    fi
}

# Print help message.
#
# Synopsis
#   print_help SCRIPTNAME
#
# Description
#   SCRIPTNAME          The name of the script.

print_help () {
    printf "usage: %s [ -h | -f ]\n" "$1"
    printf "\n"
    printf "options:\n"
    printf "-f, --force-links       Overwrite existing dotfiles.\n"
    printf "-h, --help              Print this help message.\n"
}

# Produce a log message.
#
# Synopsis
#   lecho LEVEL MESSAGE
#
# Description
#   LEVEL               The log level the message is at.
#   MESSAGE             The actual log message.

lecho () {
    printf "DOTFILES: %s: %s\n" "${1:u}" "${2}"
}

# Check whether a list contains a string.
#
# Synopsis
#   contains LIST ELEMENT
#
# Description
#   LIST                The list to search through.
#   ELEMENT             The element to search.

contains () {
    seeking="${1}"
    for element in ${2}; do
        if [[ "${element}" = "${seeking}" ]]; then
            return 0
        fi
    done
    return 1
}

# Link a file (including some protections).
#
# Synopsis
#   link FILENAME DESTINATION_PATH FORCE_LINK
#
# Description
#   FILENAME            The file to link.
#   DESTINATION_PATH    The link's destination path.
#   FORCE_LINK          Whether to force the link.

link () {
    if [[ -h "${2}" || -f "${2}" ]] && [[ ${3} = true ]]; then
        echo -n "Do you really want to force the linking of ${2}? [y|N] "
        read confirm
        if [[ "${confirm}" != "y" ]]; then
            lecho 'skip' "Not linking ${2}, skipping ..."
        else
            lecho 'info' "Linking (forced) ${2} <- ${1}"
            rm "${2}"
            ln -s "${1}" "${2}"
        fi
    elif [[ -h "${2}" || -f "${2}" ]]; then
        lecho 'skip' "${2} exists, skipping ..."
    elif [[ -e "${2}" ]]; then
        lecho 'skip' "${2} exists and is not a symbolic link or regular file, skipping ..."
    else
        lecho 'info' "Linking ${2} <- ${1}"
        mkdir -p "${2:h}"
        ln -s "${1}" "${2}"
    fi
}

# Copy a file (including some protections).
#
# Synopsis
#   copy FILENAME DESTINATION
#
# Description
#   FILENAME            The file to copy.
#   DESTINATION_PATH    The file's destination path.

copy () {
    if [[ -e "${2}" ]]; then
        lecho 'skip' "${1} exists, skipping ..."
    else
        lecho 'info' "Copying ${1} -> ${2}"
        mkdir -p "${2:h}"
        cp "${1}" "${2}"
    fi
}

# Create a file (including some protections).
#
# Synopsis
#   create FILENAME
#
# Description
#   FILENAME            The file to create.

create () {
    if [[ -e "${1}" ]]; then
        lecho 'skip' "${1} exists, skipping ..."
    else
        lecho 'info' "Creating ${1}"
        mkdir -p "${1:h}"
        touch "${1}"
    fi
}

# Enforce the installation of a specific piece of software.
#
# Synopsis
#   enforce NAME
#
# Description
#   NAME                The name of the program to enforce.

enforce () {
    if ! type "${1}" &> /dev/null; then
        lecho 'critical' "Please install ${1:u} before executing this script ..."
        exit 1
    fi
}

# Download some file with curl.
#
# Synopsis
#   curl_fetch URL DESTINATION
#
# Description
#   NAME                The name of the file we're downloading.
#   URL                 The url to the repository.
#   DESTINATION         The destination file to download to.

curl_fetch () {
    if [[ -e "${3}" ]]; then
        lecho 'skip' "${1:u} already installed, skipping ..."
    else
        lecho 'info' "Installing ${1:u}"
        mkdir -p "${3:h}"
        curl -fL "${2}" -o "${3}"
    fi
}

# Clone a git repository if it doesn't exist yet.
#
# Synopsis
#   git_clone URL DIRECTORY
#
# Description
#  NAME                 The name of the git project.
#  URL                  The url to the repository.
#  DIRECTORY            The directory to clone to.

git_clone () {
    if [[ -e "${3}" ]]; then
        lecho 'skip' "${1:u} already installed, skipping ..."
    else
        mkdir -p "${3}"
        lecho 'info' "Installing ${1:u}"
        git clone "${2}" "${3}"
    fi
}
