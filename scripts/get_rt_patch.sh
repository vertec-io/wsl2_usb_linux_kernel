#!/bin/bash

# Step 1: Get the full kernel version
FULL_KERNEL_VERSION=$(make kernelversion)

# Step 2: Trim the last version number to match patch naming convention
KERNEL_VERSION=$(echo "$FULL_KERNEL_VERSION" | awk -F. '{print $1"."$2"."$3}')

# Step 3: Extract the major and minor version
KERNEL_MAJOR_MINOR=$(echo "$KERNEL_VERSION" | cut -d '.' -f 1,2)

# Step 4: Define the base RT patch URL
BASE_URL="https://www.kernel.org/pub/linux/kernel/projects/rt"
PRIMARY_URL="$BASE_URL/$KERNEL_MAJOR_MINOR"
OLDER_URL="$BASE_URL/$KERNEL_MAJOR_MINOR/older"

# Step 5: Fetch patches from the primary directory
echo "Fetching patches from: $PRIMARY_URL"
PRIMARY_PATCHES=$(wget -qO- "$PRIMARY_URL" | grep -oE "patch-$KERNEL_VERSION-rt[0-9]+\.patch\.(gz|xz)" | sort -V)

# Step 6: Check for patches in the older directory if none found
if [ -z "$PRIMARY_PATCHES" ]; then
    echo "No patches found in $PRIMARY_URL. Checking $OLDER_URL ..."
    PATCHES=$(wget -qO- "$OLDER_URL" | grep -oE "patch-$KERNEL_VERSION-rt[0-9]+\.patch\.(gz|xz)" | sort -V)
else
    PATCHES="$PRIMARY_PATCHES"
fi

# Step 7: Get the latest patch
LATEST_PATCH=$(echo "$PATCHES" | tail -n 1)

# Step 8: Handle results
if [ -z "$LATEST_PATCH" ]; then
    echo "No RT patch found for kernel version $KERNEL_VERSION in $PRIMARY_URL or $OLDER_URL."
else
    # Determine the correct URL for the patch
    if echo "$PRIMARY_PATCHES" | grep -q "$LATEST_PATCH"; then
        PATCH_URL="$PRIMARY_URL/$LATEST_PATCH"
    else
        PATCH_URL="$OLDER_URL/$LATEST_PATCH"
    fi

    echo "Latest RT patch for kernel version $KERNEL_VERSION: $LATEST_PATCH"
    echo "Patch URL: $PATCH_URL"

    # Prompt user for confirmation before downloading
    read -p "Do you want to download $LATEST_PATCH from $PATCH_URL? [y/N] " CONFIRM
    if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
        wget "$PATCH_URL" && echo "$LATEST_PATCH has been downloaded successfully." || echo "Failed to download $LATEST_PATCH."
    else
        echo "Download aborted."
    fi
fi
