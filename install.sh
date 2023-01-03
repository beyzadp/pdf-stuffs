# Check if the user is running the script as root
if [[ $(id -u) -ne 0 ]]
then
    echo "This script must be run as root. Try again with 'sudo'."
    exit 1
fi

# Check system distro
distro=$(lsb_release -is)


if [ "$distro" == "Debian" ] || [ "$distro" == "Ubuntu" ] || [ "$distro" == "Raspbian" ] || [ "$distro" == "Kali" ]; then
  package_manager=apt
elif [ "$distro" == "Fedora" ] || [ "$distro" == "CentOS" ] || [ "$distro" == "RedHat" ]; then
  package_manager=dnf
elif [ "$distro" == "Manjaro" ] || [ "$distro" == "Arch" ]; then
  package_manager=pacman
else
  echo "Sorry, I don't know how to install packages on your system."
  exit 1
fi

# Update with package manager
if [ "$package_manager" == "apt" ] || [ "$package_manager" == "dnf" ]; then
  $package_manager update
elif [ "$package_manager" == "pacman" ]; then
  $package_manager -Sy
fi


# Install pdftk tool if not already installed
if ! [ -x "$(command -v pdftk)" ]; then
    echo "Installing pdftk tool..."
    if ! apt-get install pdftk -y 2> /dev/null; then
        dnf install pdftk 2> /dev/null
    else
        pacman -S pdftk 2> /dev/null
    fi
fi

if ! [ -x "$(command -v ghostscript)" ]; then
    echo "Installing ghostscript tool..."
    if ! apt-get install ghostscript -y 2> /dev/null; then
        dnf install ghostscript 2> /dev/null
    else
        pacman -S ghostscript 2> /dev/null
    fi
fi

# Install unoconv tool if not already installed
if ! [ -x "$(command -v unoconv)" ]; then
    echo "Installing unoconv tool..."
    if ! apt-get install unoconv -y 2> /dev/null; then
        dnf install unoconv 2> /dev/null
    else
        pacman -S unoconv 2> /dev/null
    fi
fi
