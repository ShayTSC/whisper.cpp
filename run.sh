#!/bin/sh

# Print help message if --help is input
if [ "$1" = "--help" ]; then
  echo "Usage: ./run.sh <input_file>"
  exit 0
fi

# Convert any video or audio to wav audio using ffmpeg
echo "Converting to wav..."

# If input file is not a support file type, exit
if [ ${1: -4} != ".mp4" ] && [ ${1: -4} != ".mov" ] && [ ${1: -4} != ".mp3" ] && [ ${1: -4} != ".wav" ]; then
  echo "Error: Input file must be a .mp4, .mov, .mp3, or .wav file."
  exit 1
fi

ffmpeg -i $1 -ac 1 -ar 16000 -f wav $1.wav

# Run the whisper script
echo "Running whisper script..."
./main -m ./models/ggml-small.en.bin $1.wav -osrt $1.srt

# Run the converter script
echo "Converting to SRT format..."