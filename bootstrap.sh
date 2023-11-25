#!/bin/sh

# Detect if developer tools are installed, if not install them
if test ! $(which xcode-select); then
  echo "Installing xcode-select..."
  xcode-select --install
fi

# Detect if homebrew is installed
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install dependencies
brew install ffmpeg make

# Detect if pyenv is installed, if not install it
if test ! $(which pyenv); then
  echo "Installing pyenv..."
  brew install pyenv
fi

pyenv install 3.10
pyenv global 3.10

bash ./models/download-ggml-model.sh small.en
bash ./models/generate-coreml-model.sh small.en

make clean
WHISPER_COREML=1 make -j

echo "Installation complete!"
echo "Run ./run.sh --help for usage instructions."
