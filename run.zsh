#!/usr/bin/env zsh

# -------------------------------------------------------
# Configuration
# -------------------------------------------------------
# SOURCE_DIR="/home/miakho/code/TNT-Trajectory-Prediction/dataset/raw_data/test_obs"
# DEST_DIR="/home/miakho/code/VectorNet/data/forecasting_dataset/train"
SOURCE_DIR="/home/miakho/code/TNT-Trajectory-Prediction/dataset/raw_data/val"
DEST_DIR="/home/miakho/code/VectorNet/data/forecasting_dataset/val"
# NUM_FILES=5000  # Number of files to copy
NUM_FILES=200  # Number of files to copy

# Create the destination directory if it doesn't exist
mkdir -p "${DEST_DIR}"

# Gather all CSV files that match data*.csv in SOURCE_DIR
all_files=("${SOURCE_DIR}"/*.csv)

# Count how many matching files we have
total_files=${#all_files[@]}

if (( total_files == 0 )); then
  echo "No CSV files matching '*.csv' found in ${SOURCE_DIR}."
  exit 1
elif (( total_files < NUM_FILES )); then
  echo "Only ${total_files} files found. Copying all to ${DEST_DIR}."
  cp "${all_files[@]}" "${DEST_DIR}"
  exit 0
else
  echo "Found ${total_files} files. Selecting ${NUM_FILES} at random."
fi

# -------------------------------------------------------
# Shuffle the files and select the first NUM_FILES
# -------------------------------------------------------
# Using the `shuf` command to randomly order the file paths
shuffled_files=($(printf '%s\n' "${all_files[@]}" | shuf))

# Select the first NUM_FILES from the shuffled list
selected_files=("${shuffled_files[@]:0:${NUM_FILES}}")

# Copy the selected files to the destination
cp "${selected_files[@]}" "${DEST_DIR}"

echo "Successfully copied ${NUM_FILES} files to ${DEST_DIR}."
