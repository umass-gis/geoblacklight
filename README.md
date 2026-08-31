# UMass Amherst Portal for Geospatial Data
UMAP GeoData is the University of Massachusetts Amherst's [GeoBlacklight](https://geoblacklight.org) instance, managed and hosted by the University Libraries.

### Current Release Version
UMAP GeoData v1.2.x / GeoBlacklight v4.5

---
### Dependencies

View the full GeoBlacklight release and technology dependency matrix on [geoblacklight.org](https://geoblacklight.org/).

* [Ruby](https://www.ruby-lang.org/en/) 3.3.9
* [Rails](https://rubyonrails.org) 8.0.5.1
* [Apache Solr](https://solr.apache.org/) 9.2.1
* [Node.js](https://nodejs.org/en/) (npm)
* [MySQL](https://dev.mysql.com/downloads/mysql/) 9.7.1

### Setup

[GoRails](https://gorails.com/setup) has great Ruby on Rails setup instructions for macOS, Ubuntu, and Windows. It goes through the general process to get up and running, but it doesn’t cover everything, and it may be preferable to install each dependency following separate tutorials.

Workflow to setup a MacBook with an Apple silicon chip (MX):

1. Follow the latest [documentation](https://brew.sh/) to install **Homebrew**.

1. Install **Ruby dependencies**:

   ```
   brew install openssl@3 libyaml gmp rust
   ```

1. It's recommended to install Ruby on Rails with a version manager, like **mise**, which will handle Ruby, Java, node, and more.

    1. Run the following code to install:
        ```
        curl https://mise.run | sh
        ```
    1. Then, ensure the version manager is loaded in your shell:
        ```
        echo 'eval "$(~/.local/bin/mise activate)"' >> ~/.zshrc
        source ~/.zshrc
        ```

1. Install **Ruby** and **Bundler**, substituting the Ruby version specified above:

   ```
   mise use --global ruby@[version]
   gem update --system
   ```

1. Install **Node.js**, substituting the version you want – as of this release, the current version is 24.18.0. This should also install the package manager **npm**:

   ```
   mise use --global node@[version]
   node -v
   ```

1. Install **Rails**, substituting the Rails version specified above:

   ```
   gem install rails -v [version]
   ```
   
1. Install **java**:
    1. First, check what version of openjdk is supported by the version of solr called in [solr_wrapper.yml](https://github.com/umass-gis/geoblacklight/blob/main/.solr_wrapper.yml).
    1. Use homebrew to install 

`brew install java`, then follow the suggested commands to establish a symlink.

1. Install **mysql** with `brew install mysql`, then start the database with `brew services start mysql`. Optionally, run the suggested commands to secure the database.


### Configure GeoBlacklight

1. Clone the project:

    ```
    cd <your project directory>
    git clone git@github.com:/umass-gis/geoblacklight.git
    ```

1. Duplicate the .example files in the project and remove the .example string from each of their filename:
    
    ```
    cp .example.env.development .env.development  
    cp .example.env.test .env.test
    ```
    Then, update the MYSQL_USER and MYSQL_PASSWORD credentials in these files. These variables are called by `database.yml` when establishing a connection to the database.

1. Navigate to the project directory and install the **ruby gems** with `bundle install`.

1. Install the **yarn packages** with `yarn install`.

1. Create and migrate the databases:

    Development environment:
    ```
    bundle exec rails db:create
    bundle exec rails db:migrate
    ```
    Test environment:
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
