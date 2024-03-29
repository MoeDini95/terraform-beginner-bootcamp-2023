# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby 

### Bundler 
Bundler is a package manager for ruby. This is the primary way to install ruby packages (knwon as gems) for ruby. 


### Install Gems 

You need to create a Gemfile and define your gems in that file. 

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'

```

After that, you will need to run the `bundle install` command 

This will install the gems on the system globally. 

A Gemfile.lock will be created to lock down the gem versions used in this project. 

### Running ruby scripts in the conext of bundler

We have to use `bundle exec` to tell future ruby scripts to use the gems installed. This is the way we set context.


## Sinatra

Sinatra is a micro web-framework for ruby to build web apps 

Its great for dev servers or for very simple projects. 

You can create a web server in a single file. 

[Sinatra](https://sinatrarb.com/)


### Terrarowns Mock Server

### Running the web server 

We can run the web server by running the following commads:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file. 

## CRUD

Terraform Provider resources utilize CRUD.

CRUD stands for Create, Read, Update, and Delete. 

https://en.wikipedia.org/wiki/Create,_read,_update_and_delete
