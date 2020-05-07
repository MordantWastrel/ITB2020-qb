# ITB2020-qb
Code sample app for QB For the Rest Of Us Presentation at Into the Box 2020. This app will generate a few database tables
and demonstrate QB and QB debugging using toSQL() and Coldbox interceptors.

# Supported Engines
* Lucee 5.2+ (definitely) and ACF2016+ (probably)

# Setup
* Clone this repo and run `box install` to install dependencies.
* Create a database called 'azteca' on any supported database server (SQL Server, MySQL, Postgres, or Oracle). Edit the datasource config
in Application.cfc, or delete it and use CFConfig or your CF admin to add the datasource to your server.
* `box server start`
