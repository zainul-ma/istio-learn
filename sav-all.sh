gnome-terminal \
--tab -e "bash -c \
'cd /home/ubuntu/WORK/TN/APP/account/src/account; \
export GOPATH=/home/ubuntu/WORK/TN/APP/account; \
export GOAPP=account; \
export GOENV=local; \
export CRED_MONGODB=mongodb://172.17.0.1:27017; \
export CRED_MQ=amqp://guest:guest@172.17.0.1:5672/; \
export CRED_REDIS=172.17.0.1:6379; \
export RPC_TXN=txn@127.0.0.1:58084; \
export RPC_INTEREST=interest@127.0.0.1:58085; \
git checkout master;git pull origin master; \
clear; \
bash'" \
--tab -e "bash -c \
'cd /home/ubuntu/WORK/TN/APP/txn/src/txn; \
export GOPATH=/home/ubuntu/WORK/TN/APP/txn; \
export GOAPP=txn; \
export GOENV=local; \
export SMITHBANKCODE=009; \
export MQ=local; \
export HTTP=local; \
export CRED_MONGODB=mongodb://172.17.0.1:27017; \
export CRED_MQ=amqp://guest:guest@172.17.0.1:5672/; \
export CRED_REDIS=172.17.0.1:6379; \
export CRED_PGSQL=postgres://postgres:root@127.0.0.1:5432/postgres?sslmode=disable; \
export CRED_SQLITE=/home/ubuntu/WORK/TN/APP/txn/src/txn/database/sqlite/stub.db; \
export BANK_CODE=11; \
export BANK_NAME=PERMATA; \
export DOMAIN=SAV; \
export DOMAIN_ID=02; \
export DOMAIN_ID_FIX=05; \
export PATH_BATCH_EARNING=mock/batch/earning/; \
export NUM_ROUTINE=50; \
export DB_MAXIDLE=50; \
export DB_MAXCONN=300; \
export FIX_TXN_DOMAIN_HOST=http://127.0.0.1:7084; \
export RPC_RULESTXN=general_transaction_rule@172.17.0.1:58083; \
export HTTP_TXN=https://txnpost/; \
export HTTP_SELFSVC=http://127.0.0.1:8084; \
export HTTP_OTHER=http://127.0.0.1:8084; \
export MQ_ADDRESS_GL=amqp://guest:guest@127.0.0.1:5672/; \
git checkout master;git pull origin master; \
bee migrate --driver="postgres" --conn="postgres://postgres:root@127.0.0.1:5432/postgres?sslmode=disable"; \
clear; \
bash'" \
--tab -e "bash -c \
'cd /home/ubuntu/WORK/TN/APP/rule/src/general-transaction-rule; \
export GOPATH=/home/ubuntu/WORK/TN/APP/rule; \
export GOAPP=general-transaction-rule; \
export GOENV=local; \
export SMITHBANKCODE=009; \
export SMITHEARNINGREDEMPTIONBANKCODE=030; \
export OLDCBSURL=/incoming/validate/OLDCBS; \
export OTHBANKURL=/incoming/validate/OTHBANK; \
export OUTGOINGURL=/outgoing/validate/OnlineTransfer; \
export CRED_MONGODB=mongodb://172.17.0.1:27017
export CRED_MQ=amqp://guest:guest@172.17.0.1:5672/; \
export CRED_REDIS=172.17.0.1:6379; \
export DOMAIN=SAV; \
git checkout master; git pull origin master; \
clear; \
bash'" \
--tab -e "bash -c \
'cd /home/ubuntu/WORK/TN/APP/interest/src/interest; \
export GOPATH=/home/ubuntu/WORK/TN/APP/interest; \
export GOAPP=interest; \
export GOENV=local; \
export SMITHBANKID=009; \
export BANK_CODE=11; \
export BANK_NAME=PERMATA; \
export DOMAIN=SAV; \
export CRED_MONGODB=mongodb://172.17.0.1:27017; \
export CRED_MQ=amqp://guest:guest@172.17.0.1:5672/; \
export CRED_REDIS=172.17.0.1:6379; \
export CRED_PGSQL=postgres://postgres:root@172.17.0.1:5432/smith_interest?sslmode=disable; \
export DB_MAXIDLE=50; \
export DB_MAXCONN=50; \
git checkout master; git pull origin master; \
bee migrate --driver="postgres" --conn="postgres://postgres:root@127.0.0.1:5432/smith_interest?sslmode=disable"; \
clear; \
bash'" \
--tab -e "bash -c \
'cd /home/ubuntu/WORK/TN/APP/report/src/report; \
export GOPATH=/home/ubuntu/WORK/TN/APP/report; \
export GOAPP=report; \
export GOENV=local; \
export SMITHBANKID=009; \
export HTTP=local; \
export SMITHBANKID=009; \
export RELICLICENSE=8e910acb9102ae98fbf6ad17575235fe52fc3af9; \
export CRED_MONGODB=mongodb://localhost:27017; \
export CRED_MQ=amqp://guest:guest@127.0.0.1:5672/; \
export CRED_PGSQL=postgres://postgres:root@127.0.0.1:5432/smith_report?sslmode=disable; \
export CRED_SQLITE=:memory:; \
export DOMAIN=SAV; \
git checkout master; git pull origin master; \
bee migrate --driver="postgres" --conn="postgres://postgres:root@127.0.0.1:5432/smith_report?sslmode=disable"; \
clear; \
bash'"
