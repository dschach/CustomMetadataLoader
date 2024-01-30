npm run x2oddevhub

echo "Cleaning previous scratch org..."
sf org delete scratch --no-prompt --target-org CMTLoaderOrg-PackageDev

echo "Creating new scratch org"
sf org create scratch --definition-file config/package-scratch-def.json --duration-days 30 --alias CMTLoaderOrg-PackageDev --set-default --no-ancestors

# For use with non-namespaced scratch org in package development process
echo "Pushing managed metadata"
sf project deploy start --source-dir sfdx-source/CustomMetadataLoader --wait 20
sf project deploy start --source-dir sfdx-source/unpackaged --wait 20
sf project deploy start --manifest sfdx-source/unpackaged/manifest.xml --post-destructive-changes sfdx-source/unpackaged/destructiveChangesPost.xml

echo "Assigning permission set"
sf org assign permset --name QuoteSyncTester

# To install sample data
#echo "Loading sample data"
#sf data import tree --plan ./data/data-plan.json --target-org CMTLoaderOrg-PackageDev

echo "opening org"
sf org open --target-org CMTLoaderOrg-PackageDev