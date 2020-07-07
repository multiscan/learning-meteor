# Meteor js 12 years later...
I discovered meteor long time ago but never really tried it more than 
superficially because nothing can beat RoR.

Now, as it seams inevitable, I give it another try. 
Let's start with the new revision of the classic [todo][TodoTutorial] app.

Since I want to work with docker, I prepare a base docker environment with
the following as `Dockerfile`:

```
FROM node:14
RUN curl https://install.meteor.com/ | sh 
```

Now, as it is typical in the js world, there is a choice among more than 5 
options for the view framework. I need to use `react`. Therefore, I chose 
to follow the react version of the todo.
Let's try to create the standard application template:

```
make init

Starting 00_db_1 ... done

Even with METEOR_ALLOW_SUPERUSER or --allow-superuser, permissions in your app directory will be incorrect if you ever attempt to perform any Meteor tasks as a normal user. If you need to fix your permissions, run the following command from the root
of your project:

  sudo chown -Rh <username> .meteor/local

Created a new Meteor app in current directory.                                     

To run your new app:                          
  meteor                                      
                                              
If you are new to Meteor, try some of the learning resources here:
  https://www.meteor.com/tutorials            
                                              
When you’re ready to deploy and host your new Meteor application, check out Galaxy:
  https://www.meteor.com/hosting              
                                              
To start with a different app template, try one of the following:

  meteor create --bare       # to create an empty app
  meteor create --minimal    # to create an app with as few Meteor packages as possible
  meteor create --full       # to create a more complete scaffolded app
  meteor create --react      # to create a basic React-based app
  meteor create --typescript # to create an app using TypeScript and React
                                              

```

And most of the files are not created. Probably it does not want to run as root.
Let's try to modify the container so that it runs as a standard user. The base 
image that I use (`node`) have a `node` user already there. Hence the new `Dockerfile`:

```
FROM node:14
USER node
RUN curl https://install.meteor.com/ | sh
ENTRYPOINT /home/node/.meteor/meteor
```

It builds nicely and now `make init` seams to work nicely. There is only one 
issue: `meteor create` only works if the app is created in a path different from
`pwd`. This complicates a bit the file structure but it is also not too bad 
because we can separate strictly meteor stuff from my docker crap.

So, the relevant part of `docker-compose.yml` is:

```
  app:
    build: ./
    volumes:
      - ./app:/app
    working_dir: /app
    environment:
      MONGO_URL: mongodb://db:27017/
```

For the moment  we start mongodb without authentication: this is done by 
running the mongodb container for the first time (when data directory is empty)
without passing `MONGO_INITDB_ROOT_USERNAME` and `MONGO_INITDB_ROOT_PASSWORD`
env variables. Mongodb comes with a nice administration web app so I include it 
to the composition. 

The minimal template app works and we are finally ready to follow the tutorial. 

## Links
 * [Meteor][Meteor]
 * Meteor [todo tutorial][TodoTutorial]
 * Docker Images: [node][NodeDI], [mongo][MongoDI], [mongo express][MEDI]
 * My traefik [configuration][MyTraefik] 

[Meteor]: https://www.meteor.com
[TodoTutorial]: https://www.meteor.com/tutorials/react/creating-an-app
[NodeDI]: https://hub.docker.com/_/node/
[MongoDI]: https://hub.docker.com/_/mongo
[MEDI]: https://hub.docker.com/_/mongo-express
[MyTraefik]: https://github.com/multiscan/dev_traefik