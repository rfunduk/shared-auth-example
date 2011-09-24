# Shared Auth Example App

This little app is a demo/companion to a
[blog post](http://ryanfunduk.com/shared-auth-for-rack-apps)
on how you can use
[Warden](https://github.com/hassox/warden/wiki/overview)
to share authentication between a Rails app and mounted
rack apps such as `Resque::Server`.

## Setup

    git clone git@github.com:rfunduk/shared-auth-example.git
    cd shared-auth-example
    bundle install
    rake db:migrate
    rake db:seed
    bundle exec thin start -p 3000

## Notes

The majority of the interesting code is in `lib/initializers/warden.rb`
and is discussed in the blog post. See `config/routes.rb` for a
starting point on how the app is organized.

Short version:

- public, no auth required -> `app/controllers/main_controller.rb`
- private, authentication required -> `app/controllers/admin/main_controller.rb`

See `db/seeds.rb` for login info to try it out easily.
