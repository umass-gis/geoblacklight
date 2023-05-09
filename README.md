# UMass Amherst Portal for Geospatial Data
UMAP GeoData is the University of Massachusetts Amherst's [GeoBlacklight](https://geoblacklight.org) instance, managed and hosted by the University Libraries.

### Current Release Version
UMAP GeoData v1.0.0 / GeoBlacklight v4.0.

---
### Dependencies

View the full GeoBlacklight release and technology dependency matrix here: [Releases](https://geoblacklight.org/docs/overview/releases/).

* [Ruby](https://www.ruby-lang.org/en/) 3.2.0
* [Rails](https://rubyonrails.org) 7.0.4
* [Java](https://www.java.com/en/) 8 or greater (Solr)
* [Node.js](https://nodejs.org/en/) (yarn)
* [MySQL](https://dev.mysql.com/downloads/mysql/) v8

### Setup

[GoRails](https://gorails.com/setup) has great Ruby on Rails setup instructions for macOS, Ubuntu, and Windows. It goes through the general process to get up and running, but it doesn’t cover everything, and it may be preferable to install each dependency following separate tutorials.

Workflow to setup an M1 MacBook:

1. Follow the latest [documentation](https://brew.sh/) to install Homebrew.

1. It's recommended to install Ruby on Rails with a version manager, like **rbenv**:

    ```
    brew install rbenv
    ```
    Then, ensure the version manager is loaded in your shell. For Macs using zsh, use `nano ~/.zshrc` to open the file and add the following lines of code:
    ```
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
    ```
    Save, then restart with `source ~/.zshrc`.

1. Install **ruby**, **bundler**, and **rails** (see this tutorial by [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-macos#step-2-installing-ruby)).

1. Install **node.js** with `brew install node`. This should also install **npm**.

1. Follow the latest [documentation](https://yarnpkg.com/getting-started/install) to install **yarn**.

1. Install **java** with `brew install java`, then follow the suggested commands to establish a symlink.

1. Install **mysql** with `brew install mysql`, then start the database with `brew services start mysql`. Optionally, run the suggested commands to secure the database.


### Configure GeoBlacklight

1. Clone the project:
    ```
    cd <your project directory>
    git clone git@github.com:/umass-gis/geoblacklight.git
    ```

1. Configure your mysql credentials:
  1. Duplicate the .example files in the project and remove the .example string from each of their filename.
    ```
    cp .example.env.development .env.development  
    cp .example.env.test .env.test
    ```
  1. Update the MYSQL_USER and MYSQL_PASSWORD credentials. These variables are called by `database.yml` when establishing a connection to the database.

1. Navigate to the project directory and install the **ruby gems** with `bundle install`.

1. Install the **yarn packages** with `yarn install`.

1. Create and migrate the databases:
  1. Development environment

    ```
    bundle exec rails db:create
    bundle exec rails db:migrate
    ```
  1. Test environment
    ```
    RAILS_ENV=test bundle exec rails db:create
    RAILS_ENV=test bundle exec rails db:migrate
    ```

### Run the Application

The rake task below will spin up Solr, index the test fixture documents, and start the default Rails web server.

```bash
bundle exec rake umass:server
```

* View the application at [http://localhost:3000](http://localhost:3000)
* View the Solr admin panel at [http://localhost:8983](http://localhost:8983)

### Run the Test Suite

Stop any instances of GeoBlacklight before running this command.

```bash
RAILS_ENV=test bundle exec rake ci
```

### Run the Rake Tasks for Solr

Delete all data from the Solr index

```bash
bundle exec rake umass:index:delete_all
```

Index just the UMass test fixtures

```bash
bundle exec rake rake umass:index:umass
```
