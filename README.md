# Exchange Rate gem demo client

This is a simple Sinatra web app to demonstrate the functionality of the ExchangeRateJt gem.

## Running

### Docker

There is a working docker-compose file which is probably the quickest way to spin up the server.

Assuming you have docker-compose installed and your docker machine is running, you can start the server with the command:

```
docker-compose up
```
The web app should now be available on port 3000 of the docker machine's IP, which by default is http://192.168.99.100/ .

### Native

Of course, if you have a Ruby environment set up on your machine then it should also be reasonably trivial to run the web app natively; install any dependencies and run:

```
rackup
```
