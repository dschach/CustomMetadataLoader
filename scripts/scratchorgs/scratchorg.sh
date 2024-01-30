#!/bin/bash

echo "Cleaning previous scratch org..."
sf org delete scratch --no-prompt --target-org CMTLoaderOrg

echo "Creating new scratch org"
sf org create scratch --definition-file config/project-scratch-def.json --duration-days 30 --alias CMTLoaderOrg --set-default --no-namespace

echo "Pushing metadata"
sf project deploy start --source-dir sfdx-source/CustomMetadataLoader --wait 20
sf project deploy start --source-dir sfdx-source/unpackaged --wait 20
#sf project deploy start --manifest sfdx-source/unpackaged/manifest.xml --post-destructive-changes sfdx-source/unpackaged/destructiveChangesPost.xml --wait 20

#echo "Assigning permission set"
sf org assign permset --name Custom_Metadata_Loader

#echo "Adding sample data"
#sf data import tree --plan ./data/data-plan.json

echo "opening org"
sf org open

echo "Org is set up"