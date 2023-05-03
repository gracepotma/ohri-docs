#!/usr/bin/env sh

# Rename the directory with suffix _backup_current_timestamp

if [ -d "ohri-docs" ]; then
    mv ohri-docs ohri-docs_backup_$(date +%Y%m%d_%H%M%S)
    echo "--- OHRI Backup successful ---"
else
    echo "--- ohri-docs folder not found, backup not performed ---"
fi

# Clone the repository with the reference branch named dev
git --branch dev https://github.com/UCSF-IGHS/ohri-docs.git

# Navigate into the cloned directory
echo "--- Navigate into the cloned directory ---"
cd ohri-docs

# Install dependencies and build the code
echo "--- Installing dependencies and building the code ---"
npx yarn install
npx yarn build

# Copy the built code to the specified path on the server using scp
# scp -r ./build user@server:/usr/share/tomcat/microfrontends/ohri-docs
scp -P 3220 -r ./next ohridocs@reports.globalhealthapp.net:/usr/share/tomcat/microfrontends/ohri_docs
