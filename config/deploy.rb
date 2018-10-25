# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "questions"
set :repo_url, "git@github.com:DRBragg/lunch-and-learn-questions.git"

append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

after "deploy:published", "bundler:clean"
