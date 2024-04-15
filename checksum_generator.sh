
#!/bin/bash

# Define variables
declare -a prefixes=("Sentry" "Sentry-Dynamic")

# 1. Download using wget (installed from homebrew) since curl bypasses Netskope
for prefix in "${prefixes[@]}"
do
    wget "https://github.com/getsentry/sentry-cocoa/releases/download/8.24.0/${prefix}.xcframework.zip"
done

# 2. Print checksum of each downloaded file
echo "LocalChecksum:"
for prefix in "${prefixes[@]}"
do
shasum -a 256 ${prefix}.xcframework.zip
done

# 3. Delete file since we no longer need
for prefix in "${prefixes[@]}"
do
    rm -f ${prefix}.xcframework.zip
done

# 4. Download using curl (installed from homebrew) since curl bypasses Netskope
for prefix in "${prefixes[@]}"
do
    curl -LOs "https://github.com/getsentry/sentry-cocoa/releases/download/8.24.0/${prefix}.xcframework.zip"
done

# 5. Print checksum of each downloaded file
echo ""
echo "RemoteChecksum:"
for prefix in "${prefixes[@]}"
do
shasum -a 256 ${prefix}.xcframework.zip
done

# 6. Delete file since we no longer need (again)
for prefix in "${prefixes[@]}"
do
    rm -f ${prefix}.xcframework.zip
done

echo "All downloads completed."
