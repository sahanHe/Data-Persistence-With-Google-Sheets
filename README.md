# Data-Persistence-With-Google-Sheets

This repository contains the code for the article `Enhanced Data Management: Google Sheets Empowered by bal persist`.

## prerequisite

1. Ballerina Swan Lake update 7 (2201.7.0)
2. Google Account

## Execute the Example 

1. Follow the tutorial in [https://ballerina.io/learn/supported-data-stores/#how-to-set-up-1](https://ballerina.io/learn/supported-data-stores/#how-to-set-up-1) to setup the authentication tokens for Google APIs.
2. Update the values in Config.toml
3. Execute `bal persist generate`
4. Follow the tutorial in [https://ballerina.io/learn/supported-data-stores/#how-to-set-up-1](https://ballerina.io/learn/supported-data-stores/#how-to-set-up-1) to initialize the spreadsheet
5. `bal run`
6. Run http requests in the requests.http to execute operations in the spreadsheet
