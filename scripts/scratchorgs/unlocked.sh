# UNMANAGED for use with developer edition or playground

echo "Cleaning previous scratch org..."
sf org delete scratch --no-prompt --target-org CMTLoaderOrg

echo "Creating new scratch org"
sf org create scratch --definition-file config/project-scratch-def.json --duration-days 10 --alias CMTLoaderOrg --no-namespace --set-default

echo "Pushing source..."
sf project deploy start --source-dir sfdx-source/CustomMetadataLoader --wait 20
sf project deploy start --source-dir sfdx-source/unpackaged --wait 20

echo "Assigning permission set"
sf org assign permset --name QuoteSyncTester

# To install sample data
#echo "Loading sample data"
#sf data import tree --plan ./data/data-plan.json

echo "opening org..."
sf org open