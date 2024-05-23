# Safe Stremio Web

## Enter the Cyberpunk Domain of Stremio Streaming

**Safe Stremio Web** is not just any Docker setup—it's the UI fortress for accessing the Stremio service. Cloaked behind nginx, this container acts as your cyber gateway to endless streaming possibilities. Here's how to bring this rebel base online.

## Features

- **Stremio Web UI**: Direct access to Stremio's vast library of films, series, and beyond—all from a web interface ([Stremio Service](https://www.stremio.com/download-service) required).
- **Nginx**: Works like the cyber-guardian of this portal, handling incoming connections with ease and grace (and a bit of auth).
- **Custom Environment Variables**: Set your USERNAME and PASSWORD to keep things under lock and key.

## Setting Up Your Streaming Haven

### Using Docker Compose

For the modern cybernaut who likes to keep things tidy and efficient:

1. **Compose Your Symphony**:

   Create a `docker-compose.yml` file to define and run the service using Docker Compose. Here’s a sample configuration:

   ```yaml
   version: "3.8"
   services:
     safe-stremio-web:
       image: psyb0t/safe-stremio-web:latest
       environment:
         - USERNAME=user
         - PASSWORD=pass
       ports:
         - "8080:80"
       restart: always
   ```

   This setup will ensure your service is always ready to go, even after reboots, mapping port 8080 on your local machine to port 80 on the container, securing the access with basic authentication.

2. **Deploy the Service**:

   ```sh
   docker-compose up -d
   ```

   This command will bring your Stremio UI to life in detached mode, letting you continue your terminal adventures without interruption.

### Using Docker Directly

Prefer to go old-school? No problem. Run the container directly with Docker:

```sh
docker run -d -p 8080:80 -e USERNAME='user' -e PASSWORD='pass' --restart always psyb0t/safe-stremio-web:latest
```

This will pull the image from the Docker Hub, fire up your Stremio UI, and make it accessible on port 8080 of your host machine. Remember, change 'user' and 'pass' to your desired credentials unless you're cool with everyone crashing your streaming party.

## Dive In

Now that your digital fortress is set, access the Stremio UI by navigating to `http://localhost:8080` in your favorite browser. Enter your credentials, and let the binge-watching begin. Welcome to your personal escape into the world of streaming—anarchy style. Just remember, with great power comes great responsibility (to keep binging). Enjoy the chaos!

## License

This project is unleashed into the digital wilds under the WTFPL – Do What the Fuck You Want to Public License. That's right, use it however the fuck you want. Modify it, distribute it, strip it down to build something new; the only limit is your own creativity and respect for other internet denizens.
