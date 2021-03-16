# UMass Amherst GeoData
UMass Amherst's GeoBlacklight instance

## Installation

### Dependencies

* [Ruby](https://www.ruby-lang.org/en/) 2.7.2
* [Java](https://www.java.com/en/) 8 or greater (Solr)
* [Node.js](https://nodejs.org/en/) (yarn)

[GoRails](https://gorails.com/setup) has great Ruby on Rails setup instructions for macOS, Ubuntu, and Windows.

### Clone the Project

```bash
cd <your project directory>
git clone git@github.com:/umass-gis/geoblacklight.git
```

### Configuration

Duplicate the .example files in the project and remove the .example string from each of their filename. Configure each file as necessary, or keep the default values.

```bash
cp .example.env.development .env.development  
cp .example.env.test .env.test
```

### Bundle RubyGems

Test with Bundler 2.1.4

```bash
bundle
```

### Run the Database Migrations

```bash
bin/rails db:migrate RAILS_ENV=development
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
