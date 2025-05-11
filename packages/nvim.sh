sudo pacman -S nvim --needed --noconfirm

NVIM_CONFIG_PATH="$(pwd)/configs/nvim"

if [[ ! -d $NVIM_CONFIG_PATH ]]; then
    echo "CLONING::nvim::cloning nvim config to ../configs/nvim"
    git clone git@github.com:rishabh-j-23/kickstart.nvim.git $NVIM_CONFIG_PATH
else
    echo "INFO::packages::nvim::config already exists"
    echo "INFO::packages::nvim::performing git pull"
    cd $NVIM_CONFIG_PATH
    echo "INFO::packages::nvim::[$NVIM_CONFIG_PATH]"
    git pull origin main
fi
