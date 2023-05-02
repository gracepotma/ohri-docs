#!/bin/bash

# Clone the repository with the reference branch named dev
git clone --reference https://github.com/UCSF-IGHS/ohri-docs.git --branch dev https://github.com/UCSF-IGHS/ohri-docs.git

# Navigate into the cloned directory
cd ohri-docs

# Install dependencies and build the code
yarn install
yarn build

# Copy the built code to the specified path on the server using scp
scp -r ./build user@server:/usr/share/tomcat/microfrontends/ohri_docs

# Navigate one level up and rename the directory with suffix _backup_current_timestamp
cd ..
mv ohri-docs ohri-docs_backup_$(date +%Y%m%d_%H%M%S)
