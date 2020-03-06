<img src="https://laravel.com/assets/img/components/logo-laravel.svg">

## Laravel-SPA-git-deployer
Let's figure out and improve simple and safe methods to deploy a laravel SPA app without using deployment tools such as ansible or envoy. I guess 'git' itself should be an excellent tool to deploy our projects.

This is not for an initial deployment, but for continuous deployment methods without stopping our servers. 

Please follow the guide.

## Setting

1. Copy all the files here to the root folder of your project.
2. .git should be set in advance.
3. Make sure that .env should exist each server respectively (local & remote)
4. Check puller.sh if it is appropriate for your server environment.

## How to use

1. `./pusher.sh` (local)
2. `./puller.sh` (remote deployment)
3. `./puller.sh back 1` (remote rollback in emergency)


TODO:

- [x] More sophisticated error handling



