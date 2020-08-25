# README

#### Running application with Docker

Run `docker-compose up` (or `docker-compose up --build` if you've done some changes) to run the app on port 3000.
To enter rails console the container run `docker container exec -it graphql_meetup_rails_1 rails c`.
To stop the containers run `docker-compose down`.
TO stop the containers and remove volumes run `docker-compose down --volumes`.

#### ENV variables

Create `env.*.local` files for development and test environments based on `env.*.local.example` files.

#### Database

Run `bundle exec rails db:create db:migrate db:seed` to create the database and fill it with seeds if you are not using docker.
If you are using docker run `docker-compose exec rails rake db:seed`
Seed user account data:
email: `user@example.com`
password: `password`

#### Linters

Setup [overcommit](https://github.com/sds/overcommit) to run linters and udpate GraphQL schema automatically before every commit

#### Credentials

Run `EDITOR=nano bundle exec rails credentials:edit --environment test` and `EDITOR=nano bundle exec rails credentials:edit --environment test`
to edit credentials.
Note: This app was created for educational purposes. It contains `development.key` and `test.key`.
Always add your keys to .gitignore in real-life applications.

#### Generated UserAccount
- 1 list with 2 movies
- 2 favorite movies
- 2 watchlist movies

```ruby
email: 'user@example.com'
password: 'password'
```