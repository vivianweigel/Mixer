# MIXER APP PROJECT

Overview:
Cooking has become a boring, menial task that just adds to your to do list. Mixer - Adding Organization and Inspiration to Your Cooking aims to solve this common problem. Mixer has two primary functions: organization and a social aspect. The organization aspect allows you to save all of your recipes in one place and the social aspect allows for users to share their own recipes. The app includes an explore page that features trending recipes, allowing users to easily find new, fun recipes to create. With Mixer, you will no longer spend your time wondering what to cook, being bored of your usual recipes, or forgetting recipes. 

This repo contains a boilerplate setup for spinning up 3 Docker containers: 
1. A MySQL 8 container for obvious reasons
2. A Python Flask container to implement a REST API
3. A Local AppSmith Server

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
2. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
3. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
4. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
5. Build the images with `docker compose build`
6. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`.

## How to use our Mixer app

1.  When using our app be sure to put in your user id!






