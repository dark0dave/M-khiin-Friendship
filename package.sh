#!/usr/bin/env bash
set -euo pipefail
LC_CTYPE=C

# Enable trace output if $TRACE is set to true
[[ "${TRACE:="false"}" = "true" ]] && set -x

info() {
  echo -e "${GREEN}INFO:${NOCOL} $*"
}

debug() {
  if [ "${DEBUG:="false"}" = "true" ];
  then
    echo -e "${YELLOW}DEBUG: $*${NOCOL}"
  fi
}

fail() {
  echo -e "${RED}ERROR: $*"
  exit 1
}

check_colors(){
  GREEN=''
  RED=''
  YELLOW=''
  BLUE=''
  PURPLE=''
  TEAL=''
  NOCOL=''
  if command -v tput > /dev/null; then
    COLORS="$(tput colors)"
    if [ -n "${COLORS}" ] && [ "${COLORS}" -ge 8 ]; then
      NOCOL="$(tput sgr0)"
      RED="$(tput setaf 1)"
      GREEN="$(tput setaf 2)"
      YELLOW="$(tput setaf 3)"
      BLUE="$(tput setaf 4)"
      PURPLE="$(tput setaf 5)"
      TEAL="$(tput setaf 6)"
    fi
  fi
}

usage()
{
echo -n "${PURPLE}"
cat << 'EOF'
                     _                    _
                    | |                  | |
 _ __ ___   ___   __| |  _ __   __ _  ___| | ____ _  __ _  ___ _ __
| '_ ' _ \ / _ \ / _` | | '_ \ / _, |/ __| |/ / _, |/ _, |/ _ \ '__|
| | | | | | (_) | (_| | | |_) | (_| | (__|   < (_| | (_| |  __/ |
|_| |_| |_|\___/ \__,_| | .__/ \__,_|\___|_|\_\__,_|\__, |\___|_|
                        | |                          __/ |
                        |_|                         |___/
EOF
cat << EOF
${TEAL}OPTIONS:${NOCOL}
  ${BLUE}-h${GREEN}  --help${NOCOL}              Show help.
  ${BLUE}-n${GREEN}  --mod-name${NOCOL}          Mod folder. Found: '${mod_folder}'
  ${BLUE}-v${GREEN}  --mod-version${NOCOL}       Mod version. Found: '${mod_version}'
  ${BLUE}-t${GREEN}  --tiz-folder${NOCOL}        Suffix tiz folder. Found: '${tispack_folder}'
  ${BLUE}-i${GREEN}  --ico-folder${NOCOL}        Suffix for ico folder. Found: '${ico_folder}'
  ${BLUE}-a${GREEN}  --audio-folder${NOCOL}      Suffix for audio folder. Found: '${audio_folder}'
  ${BLUE}-c${GREEN}  --iconv-folder${NOCOL}      Suffix for iconv folder. Found: '${iconv_folder}'
  ${BLUE}-e${GREEN}  --tile2ee-folder${NOCOL}    Suffix for tile2ee folder. Found: '${tile2ee_folder}'
  ${BLUE}-l${GREEN}  --lowercase${NOCOL}         Lowercase output package files (t|f). Found: '${lowercase_filenames}'
  ${BLUE}-o${GREEN}  --operating-system${NOCOL}  OS (linux|macos|windows). Default is autodected: '${os}'
  ${BLUE}-w${GREEN}  --weidu-version${NOCOL}     The version of weidu to use. Default is the latest: '${weidu_version}'
EOF
}

parse_args() {
  [ $# -eq 0 ] && usage && exit 1;
  debug "$*"
  while getopts n:v:o:i:w:l:t:a:c:e:h-: option;
  do
    debug "${option}"
    if [ "${option}" = "-" ]; then
      option="${OPTARG%%=*}"
      OPTARG="${OPTARG#"$option"}"
      OPTARG="${OPTARG#=}"
    fi
    case ${option} in
      n|mod-folder)
        mod_folder="${OPTARG}";;
      v|mod-version)
        mod_version="${OPTARG,,}";;
      l|lowercase)
        case ${OPTARG,,} in
          1|t|true)
            lowercase_filenames="true";;
          0|f|false)
            lowercase_filenames="false";;
          ?)
            fail "Invalid option ${OPTARG} for lowercase (true|false)";;
        esac
        ;;
      o|operating-system)
        case ${OPTARG,,} in
          w|window|windows)
            os="windows";;
          o|osx|m|mac|macos)
            os="macos";;
          l|lin|linux)
            os="linux";;
          ?)
            fail "Invalid option ${OPTARG} for operating system";;
        esac
        ;;
      w|weidu-version)
        weidu}_version="${OPTARG,,}";;
      t|tiz-folder)
        tispack_folder="${OPTARG}";;
      i|ico-folder)
        ico_folder="${OPTARG}";;
      a|audio-folder)
        audio_folder="${OPTARG}";;
      c|iconv-folder)
        iconv_folder="${OPTARG}";;
      e|tile2ee-folder)
        tile2ee_folder="${OPTARG}";;
      h|help)
        usage; exit;;
      ?)
        usage; exit 1;;
    esac
  done

  [[ -z "${mod_folder}" || -z ${mod_version} || -z ${os} ]] && usage && exit 1;

  info "Packaging ${mod_folder}, ${mod_version} for ${os}"
  debug "Weidu Version: ${weidu_version}"
  debug "Ico Folder Suffix: ${ico_folder}"
}

download_url() {
  info "Downloading ${1}"
  temp_dir=".temp"
  trap "rm -rf ${temp_dir}" EXIT
  mkdir -p ${temp_dir}
  wget -qO "${temp_dir}/weidu.zip" "${1}"
  info "Unzipping ${temp_dir}/weidu.zip"
  unzip -qqjo .temp/weidu.zip -d .temp
  mv ".temp/weidu${extension}" "${mod_setup}"
  rm -rf .temp || exit 1
}

download_weidu() {
  debug "Downloading from https://api.github.com/repos/weiduorg/weidu/releases/latest"

  download_url=""
  case "${1}" in
    windows)
      download_url="https://github.com/WeiDUorg/weidu/releases/download/v249.00/WeiDU-Windows-249-amd64.zip";;
    macos)
      download_url="https://github.com/WeiDUorg/weidu/releases/download/v249.00/WeiDU-Mac-249.zip";;
    linux)
      download_url="https://github.com/WeiDUorg/weidu/releases/download/v249.00/WeiDU-Linux-249-amd64.zip";;
  esac

  download_url "${download_url}"
}

lowercase_filenames() {
  trap "rm -rf ${mod_setup,,}" EXIT
  info "Lowercasing filenames..."
  mv "${mod_setup}" "${mod_setup,,}" || fail "${mod_setup,,} file/directory already exists"
  for file_name in "${mod_folder}" "${mod_setup}.exe" "${mod_setup}.command" "${mod_folder}.tp2" "${mod_setup}.tp2"; do
    full_path=$(find ${mod_setup,,} -iname ${file_name} || echo "")
    debug "${file_name}: ${full_path:=""}"
    if [ ! -z ${full_path} ]
    then
      mv "${full_path}" "${full_path,,}" || fail "${mod_setup,,} file/directory already exists"
    fi
  done

  mod_setup=${mod_setup,,}
}

windows_setup() {
  debug "Windows setup"
  win_archive="${archive_name}.zip"
  trap "rm -f ${win_archive}" EXIT

  info "Creating ${win_archive} for Windows..."
  zip -q -r "${win_archive}" "${mod_folder}" "${mod_setup}.exe" -x "${sox}" "${tisunpack_unix}/*" "${tisunpack_osx}/*" "${tile2ee_unix}/*" "${tile2ee_osx}/*"
  [ -f "${mod_folder}.tp2" ] && zip -q "${win_archive}" "${mod_folder}.tp2"
  [ -f "${mod_setup}.tp2" ] && zip -q "${win_archive}" "${mod_setup}.tp2"

  info "Creating win-${win_archive} for Windows..."
  zip -q -r "win-${win_archive}" "${mod_folder}" "${mod_setup}.exe" -x "${sox}" "${tisunpack_unix}/*" "${tisunpack_osx}/*" "${tile2ee_unix}/*" "${tile2ee_osx}/*"
  [ -f "${mod_folder}.tp2" ] && zip -q "${win_archive}" "${mod_folder}.tp2"
  [ -f "${mod_setup}.tp2" ] && zip -q "${win_archive}" "${mod_setup}.tp2"
}

macos_setup() {
  debug "Macos setup"
  mv "${mod_setup}/weidu" "${mod_setup}/${mod_setup}"
  osx_archive_tar="osx-${archive_name,,}.tar"
  trap "rm -f ${osx_archive_tar}" EXIT
  osx_archive="${osx_archive_tar,,}.gz"
  # OS X .command script
  trap "rm -f ${mod_setup}.command" EXIT
  cat << EOF >> "${mod_setup}/${mod_setup}.command"
command_path=\${0%/*}
cd "\$command_path"
./setup-${mod_folder}
EOF

  info "Creating ${osx_archive} for OS X..."
  pushd "${mod_setup}" &>/dev/null
  trap "popd &>/dev/null || false" EXIT
  tar -c --exclude "${oggdec}" --exclude "${tisunpack_win32}" --exclude "${tisunpack_unix}" --exclude "${tile2ee_win32}" --exclude "${tile2ee_unix}" --exclude "${iconv_folder}" --exclude "${desktop_ini}" --exclude "${folder_icon}" --exclude "${sfx_banner}" -f "../${osx_archive_tar}" -- *
  [ -f "${mod_folder}.tp2" ] && tar -rf "${osx_archive_tar}" -- "${mod_folder}.tp2"
  [ -f "${mod_setup}.tp2" ] && tar -rf "${osx_archive_tar}" -- "${mod_setup}.tp2"
  popd &>/dev/null
  gzip -qf --best "${osx_archive_tar}"
}

linux_setup() {
  debug "Linux setup"
  mv "${mod_setup}/weidu" "${mod_setup}/${mod_setup}"
  lin_archive_tar="linux-${archive_name,,}.tar"
  trap "rm -f ${lin_archive_tar}" EXIT
  lin_archive="${lin_archive_tar}.gz"

  info "Creating ${lin_archive} for Linux..."
  pushd "${mod_setup}" &>/dev/null
  trap "popd &>/dev/null || false" EXIT
  tar -c --exclude "${oggdec}" --exclude "${sox}" --exclude "${tisunpack_win32}" --exclude "${tisunpack_osx}" --exclude "${tile2ee_win32}" --exclude "${tile2ee_osx}" --exclude "${iconv_folder}" --exclude "${desktop_ini}" --exclude "${folder_icon}" --exclude "${sfx_banner}" -f "../${lin_archive_tar}" -- *
  [ -f "${mod_folder}.tp2" ] && tar -rf "${lin_archive_tar}" -- "${mod_folder}.tp2"
  [ -f "${mod_setup}.tp2" ] && tar -rf "${lin_archive_tar}" -- "${mod_setup}.tp2"
  popd &>/dev/null
  gzip -qf --best "${lin_archive_tar}"
}

main() {
  # Parse Args
  local mod_folder=""
  local mod_version=""
  local ico_folder="style"
  local audio_folder="audio"
  local tispack_folder="tiz"
  local tile2ee_folder="tools/tile2ee"
  local iconv_folder="languages/iconv"
  local lowercase_filenames="false"
  local os="${TARGET_OS:="$(uname -s | tr '[:upper:]' '[:lower:]')"}"
  local weidu_version="249"
  parse_args "$@"

  # Set up remaining variables
  local mod_setup="setup-${mod_folder}"
  local archive_name="${mod_folder}-${mod_version}"
  local sfx_ico="${ico_folder}/g3icon.ico"
  local sfx_banner="${ico_folder}/g3banner.bmp"
  local sfx_conf="mod.conf"
  local extension=$([[ ${os} = "windows" ]] && echo ".exe" || echo "")
  local cpu_arch=$([[ ${os} = "osx" ]] && echo "" || echo "amd64")

  # Create target directory
  trap "rm -rf ${mod_setup}" EXIT
  mkdir -p "${mod_setup}"
  cp -r "${mod_folder}" "${mod_setup}/." 2>&1 || fail "Check mod name: ${mod_folder}"

  # Download Weidu
  download_weidu "${os}"

  # Lowercase file names
  [[ "${lowercase_filenames}" = "true" ]] && lowercase_filenames

  # list platform-exclusive files we want to exclude in other archives
  local sox="${mod_setup}/${audio_folder}/sox"
  local oggdec="${mod_setup}/${audio_folder}/oggdec.exe"
  local tisunpack_win32="${mod_setup}/${tispack_folder}/win32"
  local tile2ee_win32="${mod_setup}/${tile2ee_folder}/win32"

  local tisunpack_osx="${mod_setup}/${tispack_folder}/osx"
  local tile2ee_osx="${mod_setup}/${tile2ee_folder}/osx"

  local tile2ee_unix="${mod_setup}/${tile2ee_folder}/unix"
  local tisunpack_unix="${mod_setup}/${tispack_folder}/unix"

  local folder_icon="${mod_setup}/${ico_folder}/g3.ico"
  local desktop_ini="${mod_setup}/${mod_folder}/desktop.ini"

  case "${os}" in
    windows)
      windows_setup;;
    macos)
      macos_setup;;
    linux)
       linux_setup;;
  esac

  info "Packaging completed."
}

check_colors
main "$@"
