# frozen_string_literal: true

desc 'Run test suite'
task :ci do
  shared_solr_opts = { managed: true, verbose: true, persist: false, download_dir: 'tmp' }
  shared_solr_opts[:version] = ENV['SOLR_VERSION'] if ENV['SOLR_VERSION']

  success = true
  SolrWrapper.wrap(shared_solr_opts.merge(port: 8985, instance_dir: 'tmp/blacklight-core')) do |solr|
    solr.with_collection(name: "blacklight-core", dir: Rails.root.join("solr", "conf").to_s) do
      system 'RAILS_ENV=test bundle exec rake umass:index:seed'
      success = system 'RUBYOPT=W0 RAILS_ENV=test TESTOPTS="-v" bundle exec rails test:system test'
    end
  end

  exit!(1) unless success
end

namespace :umass do
  desc 'Run Solr and GeoBlacklight for interactive development'
  task :server, [:rails_server_args] do
    require 'solr_wrapper'

    shared_solr_opts = { managed: true, verbose: true, persist: false, download_dir: 'tmp' }
    shared_solr_opts[:version] = ENV['SOLR_VERSION'] if ENV['SOLR_VERSION']

    SolrWrapper.wrap(shared_solr_opts.merge(port: 8983, instance_dir: 'tmp/blacklight-core')) do |solr|
      solr.with_collection(name: "blacklight-core", dir: Rails.root.join("solr", "conf").to_s) do
        puts "Solr running at http://localhost:8983/solr/blacklight-core/, ^C to exit"
        puts ' '
        begin
          Rake::Task['umass:index:seed'].invoke
          system "bundle exec rails s -b 0.0.0.0"
          sleep
        rescue Interrupt
          puts "\nShutting down..."
        end
      end
    end
  end

  desc "Start solr server for testing."
  task :test do
    if Rails.env.test?
      shared_solr_opts = { managed: true, verbose: true, persist: false, download_dir: 'tmp' }
      shared_solr_opts[:version] = ENV['SOLR_VERSION'] if ENV['SOLR_VERSION']

      SolrWrapper.wrap(shared_solr_opts.merge(port: 8985, instance_dir: 'tmp/blacklight-core')) do |solr|
        solr.with_collection(name: "blacklight-core", dir: Rails.root.join("solr", "conf").to_s) do
          puts "Solr running at http://localhost:8985/solr/#/blacklight-core/, ^C to exit"
          begin
            Rake::Task['umass:index:seed'].invoke
            sleep
          rescue Interrupt
            puts "\nShutting down..."
          end
        end
      end
    else
      system('rake umass:test RAILS_ENV=test')
    end
  end

  desc "Start solr server for development."
  task :development do
    shared_solr_opts = { managed: true, verbose: true, persist: false, download_dir: 'tmp' }
    shared_solr_opts[:version] = ENV['SOLR_VERSION'] if ENV['SOLR_VERSION']

    SolrWrapper.wrap(shared_solr_opts.merge(port: 8983, instance_dir: 'tmp/blacklight-core')) do |solr|
      solr.with_collection(name: "blacklight-core", dir: Rails.root.join("solr", "conf").to_s) do
        puts "Solr running at http://localhost:8983/solr/#/blacklight-core/, ^C to exit"
        begin
          Rake::Task['umass:index:seed'].invoke
          sleep
        rescue Interrupt
          puts "\nShutting down..."
        end
      end
    end
  end

  namespace :index do
    desc 'Put all sample data into solr'
    task :seed => :environment do
      docs = Dir['test/fixtures/files/**/*.json'].map { |f| JSON.parse File.read(f) }.flatten
      Blacklight.default_index.connection.add docs
      Blacklight.default_index.connection.commit
    end

    desc 'Put umass sample data into solr'
    task :umass => :environment do
      docs = Dir['test/fixtures/files/umass_documents/*.json'].map { |f| JSON.parse File.read(f) }.flatten
      Blacklight.default_index.connection.add docs
      Blacklight.default_index.connection.commit
    end

    desc 'Delete all sample data from solr'
    task :delete_all => :environment do
      Blacklight.default_index.connection.delete_by_query '*:*'
      Blacklight.default_index.connection.commit
    end
  end

end
