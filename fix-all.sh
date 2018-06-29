gnome-terminal \
--tab -e "bash -c \
'cd /home/ubuntu/WORK/TN/APP/fix_account/src/account; \
export GOPATH=/home/ubuntu/WORK/TN/APP/fix_account; \
export GOAPP=account; \
export GOENV=local; \
export RPC_TXN=txn@127.0.0.1:57084; \
export RPC_GENERAL_RULE=general_transaction_rule@127.0.0.1:57083; \
export RPC_INTEREST=interest@127.0.0.1:57085; \
export CRED_MONGODB=mongodb://172.17.0.1:27017; \
export CRED_MQ=amqp://guest:guest@172.17.0.1:5672/; \
export CRED_REDIS=172.17.0.1:6379; \
git checkout master && git pull origin master; \
clear; \
bash'" \
--tab -e "bash -c \
'cd /home/ubuntu/WORK/TN/APP/fix_txn/src/txn; \
export GOPATH=/home/ubuntu/WORK/TN/APP/fix_txn; \
export GOAPP=txn; \
export GOENV=local; \
export SMITHBANKCODE=009; \
export MQ=local; \
export HTTP=local; \
export CRED_MONGODB=mongodb://172.17.0.1:27017; \
export CRED_MQ=amqp://guest:guest@172.17.0.1:5672/; \
export CRED_REDIS=172.17.0.1:6379; \
export CRED_PGSQL=postgres://postgres:root@127.0.0.1:5432/smith_fix_transaction?sslmode=disable; \
export RPC_RULE=general_transaction_rule@127.0.0.1:57083; \
export RPC_INTEREST=interest@127.0.0.1:57085; \
export ACCRUED_FILE_URL_STORAGE=http://127.0.0.1:7084/fix_txn/v1/storages/; \
export CRED_SQLITE=$GOPATH/src/$GOAPP/database/sqlite/stub.db; \
export BANK_CODE=10; \
export BANK_NAME=PERMATA; \
export DOMAIN=FIX; \
export THIRDPARTY_ADDRESS_GL_ACCOUNTING_MQ=amqp://glrabbit:glrabbit@glrabbitmq:5672/; \
export DB_MAXIDLE=50; \
export DB_MAXCONN=50; \
export DOMAIN_ID=05; \
export DOMAIN_ID_SAV=02; \
export FIX_TXN_DOMAIN_HOST=http://127.0.0.1:7084; \
export SAV_TXN_DOMAIN_HOST=http://127.0.0.1:8084; \
export SAV_ACC_DOMAIN_HOST=http://127.0.0.1:8082; \
git checkout master; git pull origin master; \
bee migrate --driver="postgres" --conn="postgres://postgres:root@127.0.0.1:5432/smith_fix_transaction?sslmode=disable"; \
clear; \
bash'" \
--tab -e "bash -c \
'cd /home/ubuntu/WORK/TN/APP/fix_rule/src/general-transaction-rule; \
export GOPATH=/home/ubuntu/WORK/TN/APP/fix_rule; \
export GOAPP=general-transaction-rule; \
export GOENV=local; \
export SMITHBANKCODE=009; \
export SMITHEARNINGREDEMPTIONBANKCODE=506; \
export OLDCBSURL=/incoming/validate/OLDCBS; \
export OTHBANKURL=/incoming/validate/OTHBANK; \
export OUTGOINGURL=/outgoing/validate/OnlineTransfer; \
export CRED_MONGODB=mongodb://172.17.0.1:27017; \
export CRED_MQ=amqp://guest:guest@172.17.0.1:5672/; \
export CRED_REDIS=172.17.0.1:6379; \
export DOMAIN=FIX; \
git checkout master; git pull origin master; \
clear; \
bash'" \
--tab -e "bash -c \
'cd /home/ubuntu/WORK/TN/APP/fix_interest/src/interest; \
export GOPATH=/home/ubuntu/WORK/TN/APP/fix_interest; \
export GOAPP=interest; \
export GOENV=local; \
export SMITHBANKID=009; \
export BANK_CODE=10; \
export BANK_NAME=PERMATA; \
export DOMAIN=FIX; \
export CRED_MONGODB=mongodb://172.17.0.1:27017; \
export CRED_MQ=amqp://guest:guest@172.17.0.1:5672/; \
export CRED_REDIS=172.17.0.1:6379; \
export CRED_PGSQL=postgres://postgres:root@172.17.0.1:5432/smith_fix_interest?sslmode=disable; \
export CRED_GRPC_TXN=txn@127.0.0.1:57084; \
export CRED_GRPC_REPORT=report@127.0.0.1:57086; \
export ACCRUED_FILE_URL_STORAGE=http://127.0.0.1:7085/fix_interest/v1/storages/; \
git checkout master; git pull origin master; \
bee migrate --driver="postgres" --conn="postgres://postgres:root@127.0.0.1:5432/smith_fix_interest?sslmode=disable"; \
clear; \
bash'" \
--tab -e "bash -c \
'cd /home/ubuntu/WORK/TN/APP/fix_report/src/report; \
export GOPATH=/home/ubuntu/WORK/TN/APP/fix_report; \
export GOAPP=report; \
export GOENV=local; \
export SMITHBANKID=009; \
export HTTP=local; \
export SMITHBANKID=009; \
export RELICLICENSE=8e910acb9102ae98fbf6ad17575235fe52fc3af9; \
export CRED_MONGODB=mongodb://localhost:27017; \
export CRED_MQ=amqp://guest:guest@127.0.0.1:5672/; \
export CRED_PGSQL=postgres://postgres:root@127.0.0.1:5432/smith_fix_report?sslmode=disable; \
export CRED_SQLITE=:memory:; \
export DOMAIN=FIX; \
export SELF_ADDR=http://127.0.0.1:7086; \
export ACT_DOMAIN_SVC=http://127.0.0.1:7086; \
export INTEREST_SVC=http://127.0.0.1:7085; \
export RPC_TXN=txn@127.0.0.1:57084; \
git checkout master; git pull origin master; \
bee migrate --driver="postgres" --conn="postgres://postgres:root@127.0.0.1:5432/smith_fix_report?sslmode=disable"; \
bash'"