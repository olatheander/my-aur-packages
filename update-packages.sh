#!/usr/bin/env bash

# Exit on error, undefined variables, and pipe failures
set -euo pipefail

# Ensure we are in the repository root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== Updating AUR PKGBUILDs ==="

# Loop through all directories in the repository root
for dir in */; do
    # Remove trailing slash to get the folder name
    pkg_name="${dir%/}"
    
    # Skip hidden directories (like .git)
    if [[ "$pkg_name" =~ ^\. ]]; then
        continue
    fi
    
    # Verify it is a package directory containing a PKGBUILD
    if [[ -f "$pkg_name/PKGBUILD" ]]; then
        echo ""
        echo "--> Fetching updates for: $pkg_name"
        
        # Run yay --getpkgbuild to update the package directory.
        # We use --force to overwrite/update the existing directory with the latest files.
        yay --getpkgbuild --force "$pkg_name"
    fi
done

echo ""
echo "=== All packages successfully updated! ==="
