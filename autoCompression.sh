#!/bin/bash

log_file="/path/to/compression.logs"
archive_name="archive_$(date +%d%m%y).tar"

# Function to log messages
log() {
    local log_level="$1"
    local message="$2"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] [$log_level] - $message" > "$log_file"
}

# Log start of script execution
log "INFO" "Starting pgSQL archive script..."

# Find and append files modified in the last 24 hours to the tar file
find $log_file -mtime -1 -type f -exec tar --append --file=${ARCHIVE_NAME} '{}' +

# Check previous command status
if [ $? -eq 0 ]; then
    log "INFO"  "Files successfully added to ${archive_name}"

    # Compress the updated tar file with gzip, keeping the original if compression fails
    gzip -fk ${ARCHIVE_NAME}
    log "INFO" "Files compressed successfully"

    # remove the compressed log files
    find $log_file -mtime -1 -type f -exec rm -rf  {} \;
    log "WARNING" "Removed compressed log files"

else
    log "WARNING" "Failed to add files to ${archive_name}. Or there's no files for yesterday; Please checK"
fi