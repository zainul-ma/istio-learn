Kubernetes Deploy

To Deploy our apps, we need run the start.sh
the start.sh file is contain some command to execute kubectl command
i will tell about start.sh here

first we need storage db and cache db which is redis , mongo and postgres
when execute start
it will be create

- redis instance
- mongo instance
- postgre sql instance

create the db instance belongs to the each service that we need
for example txn service

for example

```
create database smith_transaction;
create database smith_interest;
```

after this the script will be execute the service instance

for example in this script
will be install
- account service
- txn service

and the service will be start
