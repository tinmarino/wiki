## Install Alacritty on Ubuntu

```sh
# Install rust
sudo apt install crul
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install required tools
sudo apt-get install -y cmake libfreetype6-dev libfontconfig1-dev xclip

# Download, compile and install Alacritty
git clone https://github.com/jwilm/alacritty Alacritty
cd Alacritty
cargo install
cargo build --all

# Add Man-Page entries
sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null

# Add shell completion for bash and zsh
mkdir -p ~/.bash_completion
cp completions/alacritty.bash  ~/.bash_completion/alacritty
echo "source ~/.bash_completion/alacritty" >> ~/.bashrc

# Create desktop file
cp  ./extra/linux/Alacritty.desktop ~/.local/share/applications/
sed -ie "s:^Icon=.*:Icon=$(pwd)/extra/logo/alacritty-term.svg:" ~/.local/share/applications/alacritty.desktop

# Use Alacritty as default terminal (Ctrl + Alt + T)
gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'

# Add cargo/bin to your path if not done yet
echo 'export PATH=$PATH:$HOME/.cargo/bin' >> ~/.bashrc
```


Note: Thanks to read. Alacritty dev team made this wiki publicly available => feel free to correct me <= I am a brand new user
Link: content copied from [this gist](https://gist.github.com/Aaronmacaron/8a4e82ed0033290cb2e12d9df4e77efe)
