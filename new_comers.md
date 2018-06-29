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

## CICD

requirement for CI & CD is Jenkins , because we use jenkins. for jenkins just follow the installation from official jenkins , in jenkins we also need docker as the thirdparty like db , mq or cache.

CI and CD in our repo contain 6 step , the step is:
- preparation
    - preparation is first step , so that we need is clone the repository , in our script in directory
    cicd. so actually the scrip it's just run:
        - create directory in jenkins work space
            ```mkdir -p /var/lib/jenkins/workspace/SAV_TXN/src/txn```
        - remove the all directory under the selected service work space (remove for the new one version)
        - copy all cloned file to the service workspace , in this sample is txn
        - start the docker
- linter
    - linter is static typing, the tools use for checking the our code and make clean and dicipline

- test
    - the test is the important things in development , this test contain 
        - unit test
        - integration test
        - component test
    - also the coverage must be at least 70% 
    - to run the test the environment variable must put in the test.sh
    - make sure the migration run before the test run
- build
    - we change the app.conf part runmode in beego app from ```dev``` to ```prod``` 
    - at this step is litteraly build the image with docker build command
    ```
    docker build -t tnindo/txn:$VERSION_IMG_STAG.$VERSION_MINOR_IMG_STAG.$BUILD_ID -f Dockerfile .
    ```
    - if build succes will be go to the next step , and if failed, you can rerun again
- push
    - push actually is just push to dockerhub the step is login first and then push
    - for login jus use the docker login command
    for example
    ```
    docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
    ```
    - for push , push the image that actually has been build
- deploy 
    - deploy in here is just change the image in server , the setup already setup in k8s level
    the script for deploy is looks like this
    ```
    kubectl set image deployments/fd-txn fd-txn=tnindo/fix_txn:v1stag.0.${BUILD_NO}
    ```
## Deployment 
follow this link
https://github.com/zainul-ma/istio-learn/blob/0.8/kubernetes/Internal-service.md
