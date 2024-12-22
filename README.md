# Example disco Astro static site

You can clone this repo, OR you can follow these steps to make the repo
yourself:

1. Create a site with [Astro](https://astro.build/):

   ```sh
   npm create astro@latest
   ```

   This will walk you through creating an Astro site.

2. [Create a new repository on github](https://github.com/new). These
   instructions will refer to the repository as USERNAME/REPONAME, but it'll
   actually be something like `john/my-site`.

3. Navigate to the directory that you created:

   ```sh
   cd REPODIR
   ```

   above, replace `REPODIR` with whereever you told Astro to put your project
   (e.g. `./my-project`).

4. Push your new site to github:

   ```sh
   git remote add origin git@github.com:USERNAME/REPONAME.git
   git branch -M main
   git push -u origin main
   ```

   above, replace `USERNAME/REPONAME` with your username and the repository
   you created (e.g. `john/my-project`)

5. Install the [node adapter](https://docs.astro.build/en/guides/integrations-guide/node/)
   to enable Astro's "on-demand rendered routes."

   ```sh
   npx astro add node
   ```

6. Add [this Dockerfile](Dockerfile) to your project:

   ```
   FROM node:lts

   WORKDIR /code

   # start with dependencies to enjoy caching
   COPY ./package.json /code/package.json
   COPY ./package-lock.json /code/package-lock.json
   RUN npm ci

   # copy rest and build
   COPY . /code/.
   RUN --mount=type=secret,id=.env env $(cat /run/secrets/.env | xargs) npm run build

   # start the server
   ENV HOST=0.0.0.0
   ENV PORT=4321
   CMD ["node", "/code/dist/server/entry.mjs"]
   ```

7. Add [this disco.json file](disco.json) to your project:

   ```
   {
     "version": "1.0",
     "services": {
       "web": {
         "port": 4321
       }
     }
   }
   ```

8. Add those files to git and push:

   ```sh
   git add package.json package-lock.json astro.config.mjs Dockerfile disco.json
   git commit -a -m "Ready to disco 🪩"
   git push
   ```
