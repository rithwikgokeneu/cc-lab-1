#!/bin/bash
set -euo pipefail

PROJECT_DIR="/tmp/project"

# 1. Create Directory Structure
echo "Creating directory structure..."
mkdir -p "${PROJECT_DIR}"/{data,scripts,logs,backup}

# 2. File Operations
echo "Creating files in the 'data' directory..."
echo "Sample content for file 1" > "${PROJECT_DIR}/data/file1.txt"
echo "Sample content for file 2" > "${PROJECT_DIR}/data/file2.txt"
echo "Sample content for file 3" > "${PROJECT_DIR}/data/file3.txt"
echo "Sample content for file 4" > "${PROJECT_DIR}/data/file4.txt"
echo "Sample content for file 5" > "${PROJECT_DIR}/data/file5.txt"

echo "Copying 'file1.txt' to 'backup' directory..."
cp "${PROJECT_DIR}/data/file1.txt" "${PROJECT_DIR}/backup/file1.txt"

echo "Renaming 'file3.txt' to 'file3_renamed.txt'..."
mv "${PROJECT_DIR}/data/file3.txt" "${PROJECT_DIR}/data/file3_renamed.txt"

echo "Moving 'file4.txt' and 'file5.txt' to 'logs' directory..."
mv -f "${PROJECT_DIR}/data/file4.txt" "${PROJECT_DIR}/logs/file4.txt"
mv -f "${PROJECT_DIR}/data/file5.txt" "${PROJECT_DIR}/logs/file5.txt"

echo "Deleting 'file2.txt' from 'data' directory..."
rm -f "${PROJECT_DIR}/data/file2.txt"

# 3. Directory Management
echo "Listing all files and directories with detailed information..."
ls -laR "${PROJECT_DIR}"

echo "Displaying total size of 'data' and 'logs' directories..."
du -sh "${PROJECT_DIR}/data" "${PROJECT_DIR}/logs"

echo "Displaying the 10 largest files and directories in 'project'..."
du -ah "${PROJECT_DIR}" | sort -rh | sed -n '1,10p'

# 4. File Permissions and Ownership
echo "Setting file permissions 644 for 'file1.txt'..."
chmod 644 "${PROJECT_DIR}/backup/file1.txt"

echo "Setting file permissions 644 for 'file3_renamed.txt'..."
chmod 644 "${PROJECT_DIR}/data/file3_renamed.txt"

echo "Changing ownership of 'file4.txt'..."
sudo chown nobody:nogroup "${PROJECT_DIR}/logs/file4.txt"

# 5. Symbolic Links
echo "Creating symbolic link 'file1_link.txt' in 'scripts' directory..."
ln -sfn ../backup/file1.txt "${PROJECT_DIR}/scripts/file1_link.txt"

echo "Verifying the symbolic link of file1.txt..."
ls -l "${PROJECT_DIR}/scripts/file1_link.txt"
readlink "${PROJECT_DIR}/scripts/file1_link.txt"

# 6. System Monitoring and Process Management
echo "Displaying disk usage of the filesystem..."
df -h

echo "Listing all running processes and finding PID of 'bash'..."
ps -ef
ps -ef | grep '[b]ash' || true

# 7. Automated Backup
echo "Creating a compressed archive of the 'backup' directory..."
ARCHIVE="backup_$(date +%Y%m%d).tar.gz"

tar -czf "/tmp/${ARCHIVE}" -C "${PROJECT_DIR}" backup
mv "/tmp/${ARCHIVE}" "${PROJECT_DIR}/backup/${ARCHIVE}"

# 8. Log Completion
echo "Logging completion message..."
echo "Assignment completed" > "${PROJECT_DIR}/README.md"

# 9. Directory Existence Verification
echo "Verifying final directory state..."

if [ ! -d "${PROJECT_DIR}/data" ]; then
    echo "ERROR: ${PROJECT_DIR}/data does not exist"
    exit 1
fi

echo "Assignment completed successfully."
