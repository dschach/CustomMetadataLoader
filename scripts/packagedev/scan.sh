mkdir scanner

sf scanner run --target sfdx-source --category="Security" -o scanner/CodeAnalyzerGeneral.csv --format=csv

sf scanner run --engine pmd-appexchange -t sfdx-source --category="Security" -o scanner/CodeAnalyzerPmdAppExchange.csv  --format=csv

sf scanner run dfa -t sfdx-source --category="Security"  -o scanner/CodeAnalyzerDFA.csv --format=csv --projectdir="./"
