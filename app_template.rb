# アプリ名の取得
@app_name = app_name
@db_password = ENV['DB_PASSWORD']
# clean file
run 'rm README.rdoc'

# .gitignore
run 'gibo OSX Ruby Rails JetBrains SASS SublimeText > .gitignore' rescue nil
gsub_file '.gitignore', /^config\/initializers\/secret_token.rb$/, ''

# add to Gemfile
run 'rm -rf Gemfile'
file 'Gemfile', <<-CODE
source 'https://rubygems.org'

ruby '2.1.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass', '3.3.0.rc.1'
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Assets log cleaner
gem 'quiet_assets'

# HTML5 Validator
gem 'html5_validators'

# PG/MySQL Log Formatter
gem 'rails-flog'

# App configuration
gem 'figaro'

# Use ActiveModel has_secure_password
  gem 'bcrypt-ruby', '~> 3.1.2'

# Use Capistrano for deployment
  gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
  gem 'better_errors'

# Bower Manager => https://rails-assets.org/
source 'https://rails-assets.org'

# turbolinks support
gem 'jquery-turbolinks'

# Source Map
gem 'coffee-rails-source-maps'
gem 'sass-rails-source-maps'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# CSS Support
#gem 'less-rails'

# App Server
# gem 'puma'

# Presenter Layer
gem 'draper'

# Haml
gem 'haml-rails'

# Assets log cleaner
gem 'quiet_assets'

# Form Builders
gem 'simple_form'

# # Process Management
gem 'foreman'

# HTML5 Validator
gem 'html5_validators'

# PG/MySQL Log Formatter
gem 'rails-flog'

# Migration Helper
gem 'migrant'

# Pagenation
gem 'kaminari'

# NewRelic
gem 'newrelic_rpm'

# Airbrake
gem 'airbrake'

# HTML Parser
gem 'nokogiri'

# App configuration
gem 'figaro'

# Rails/Rack Profiler
gem 'speed_gun'

# Hash extensions
gem 'hashie'

# PDF support
gem 'prawn-rails'

# refactoring suggestions
gem 'rails_best_practices'

group :development do
  # Converter erb => haml
  gem 'erb2haml'
end

group :development, :test do

  # ローカルweb server
  gem 'thin'

  # Rails application preloader
  gem 'spring'

  # Railsコンソールの多機能版
  gem 'pry-rails'

  # pryの入力に色付け
  gem 'pry-coolline'

  # デバッカー
  gem 'pry-byebug'

  # Pryでの便利コマンド
  gem 'pry-doc'

  # PryでのSQLの結果を綺麗に表示
  gem 'hirb'
  gem 'hirb-unicode'

  # pryの色付けをしてくれる
  gem 'awesome_print'

  # Rspec
  gem 'rspec-rails'
  gem 'rake_shared_context'

  # fixtureの代わり
  gem "factory_girl_rails"

  # テスト環境のテーブルをきれいにする
  gem 'database_rewinder'

  # Guard
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spring'
end

group :production, :staging do
  # ログ保存先変更、静的アセット Heroku 向けに調整
  gem 'rails_12factor'

  # Use unicorn as the app server
  gem 'unicorn'
end
CODE

# install gems
run 'bundle install --path vendor/bundle'

# set config/`rb
application  do
  %q{
    # Set timezone
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    # 日本語化
    I18n.enforce_available_locales = true
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja

    # generatorの設定
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
      g.test_framework  :rspec, :fixture => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
      g.view_specs false
      g.controller_specs false
      g.routing_specs false
      g.helper_specs false
      g.request_specs false
      g.assets false
      g.helper false
    end

    # libファイルの自動読み込み
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
  }
end

run 'rm -rf config/initializers/secret_token.rb'
file 'config/initializers/secret_token.rb', <<-FILE
#{@app_name.classify}::Application.config.secret_key_base = ENV['SECRET_KEY_BASE'] || '#{`rake secret`}'
FILE

# set Japanese locale
run 'wget https://raw.github.com/svenfuchs/rails-i18n/master/rails/locale/ja.yml -P config/locales/'

# application.js(turbolink setting)
run 'rm -rf app/assets/javascripts/application.js'
run 'wget https://raw.github.com/hachi8833/rails4.0_template/master/app/assets/javascripts/application.js -P app/assets/javascripts/'

# HAML
run 'rake haml:replace_erbs'

# Bootstrap/Bootswach/Font-Awaresome
insert_into_file 'app/views/layouts/application.html.haml',%(
%script{:src=>'//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js'}
%link{:href=>'//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css', :rel=>'stylesheet'}
%link{:href=>'//netdna.bootstrapcdn.com/bootswatch/3.0.3/simplex/bootstrap.min.css', :rel=>'stylesheet'}
), after: '= csrf_meta_tags'

# Simple Form
generate 'simple_form:install --bootstrap'

# Kaminari config
generate 'kaminari:config'
generate 'kaminari:views  bootstrap'

run 'rm -rf app/view/kaminari/_paginator.html.haml'
file 'app/view/kaminari/_paginator.html.haml', <<-FILE
= paginator.render do
  .pagination{style: 'text-align: center; display: block;'}
    %ul.pagination
      = first_page_tag unless current_page.first?
      = prev_page_tag unless current_page.first?
      - each_page do |page|
        - if page.left_outer? || page.right_outer? || page.inside_window?
          = page_tag page
        - elsif !page.was_truncated?
          = gap_tag
      = next_page_tag unless current_page.last?
      = last_page_tag unless current_page.last?
FILE

# Database
run 'rm -rf config/database.yml'
run 'wget https://raw.github.com/hachi8833/rails4.0_template/master/config/database.yml -P config/'
gsub_file 'config/database.yml', /APPNAME/, @app_name
gsub_file 'config/database.yml', /PASSWD/, @db_password
run "mysql -e create user #{@app_name} identified by #{@db_password}"
run 'bundle exec rake RAILS_ENV=development db:create'

# Rspec/Spring/Guard
# ----------------------------------------------------------------
# Rspec
generate 'rspec:install'
run "echo '--color --drb -f d' > .rspec"

insert_into_file 'spec/spec_helper.rb',%(
  config.before :suite do
    DatabaseRewinder.clean_all
  end

  config.after :each do
    DatabaseRewinder.clean
  end

  config.before :all do
    FactoryGirl.reload
  end

  config.include FactoryGirl::Syntax::Methods
), after: 'RSpec.configure do |config|'

insert_into_file 'spec/spec_helper.rb', "\nrequire 'factory_girl_rails'", after: "require 'rspec/rails'"
gsub_file 'spec/spec_helper.rb', "require 'rspec/autorun'", ''

# Spring
run 'wget https://raw.github.com/jonleighton/spring/master/bin/spring -P bin/'
run 'sudo chmod a+x bin/spring'

# Guard
run 'bundle exec guard init'
gsub_file 'Guardfile', 'guard :rspec do', "guard :rspec, cmd: 'spring rspec -f doc' do"

run 'bundle install'

# git init
# ----------------------------------------------------------------
git :init
git :add => '.'
git :commit => "-a -m 'first commit'"

# GitHub
# ----------------------------------------------------------------
if !use_bitbucket and yes?('Push GitHub? [yes or ELSE]')
  git_uri = `git config remote.origin.url`.strip
  unless git_uri.size == 0
    say 'Repository already exists:'
    say "#{git_uri}"
  else
    email = ask 'What is your GitHub login E-Mail address?'
    run "curl -u #{email} -d '{\"name\":\"#{@app_name}\"}' https://api.github.com/user/repos"
    username = ask 'What is your GitHub username?'
    git remote: %Q{ add origin git@github.com:#{username}/#{@app_name}.git }
    git push: %Q{ origin master }
  end
end