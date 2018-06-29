#  For New Comers

first we need install ubuntu 16.04 or lates

## Preparation

- install docker normally no need additional config
    - https://docs.docker.com/install/linux/docker-ce/ubuntu/
- install kubernetes follow this link
    - https://github.com/zainul-ma/istio-learn/blob/0.8/kubernetes/kubernetes_intsall.md
- install your favourite text editor
- signup your work account to github
- notify your supervisor to make grant access to the repo
- clone the repo by direction of your supervisor 
- install programming languange that you need in development , for example in this case is golang
- setup golang gopath follow the documentation golang
- for our development we can use custom location gopath, it's different with gopath installation
    - for example like this
    ```
    mkdir -p /home/ubuntu/WORK/TN/APP/fix_report
    ```

    so the gopath will be in fix_report, and the the code for service report must be inside

    ```
    /home/ubuntu/WORK/TN/APP/fix_report/src/
    ```

    so the directory should be

    - /home/ubuntu/WORK/TN/APP/fix_report/src/
        - /fix_report


after  you fix your gopath you need adjustment the start script until now the start script is consist
2 file which is:

- fix-all.sh
- sav-all.sh

sav-all is for Saving domain
fix-all is for Fixed domain

for example in start script

```
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
```

you need adjust the gopath folowwing your gopath
and the any environment variable must be placed after gopath for example 
```
export GOPATH=/home/ubuntu/WORK/TN/APP/fix_report; \
export GOAPP=report; \
export GOENV=local; \
export SMITHBANKID=009; \
export HTTP=local; \
export SMITHBANKID=009; \
...

 //GOAPP, GOENV , SMITHBANKID , HTTP, SMITHBANKID is env variable
```

and to run the service just type this in command line

```
./fix-all
```

it will be open n (depend how many service you put in those file) terminal tab and it will be:

- open new tab on terminal
- cd to the directory (custom gopath belongs to each service)
- export the gopath (```export GOPATH=/home/ubuntu/WORK/TN/APP/fix_report; \```)like describe in those file  
- export the all environment variable
- checkout to master branch
- git pull origin master
- do migration by bee migrate (it will be migrate all pending migration)
- and last is we need to type ```bee migrate```

#### Happy Coding :))

Deployment 
