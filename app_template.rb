# アプリ名の取得
@app_name = app_name
@db_password = ENV['DB_PASSWORD']
# clean file
run 'mv README.rdoc README.md'

# .gitignore
run 'gibo OSX Ruby Rails JetBrains SASS SublimeText > .gitignore' rescue nil
gsub_file '.gitignore', /^config\/initializers\/secret_token.rb$/, ''
append_file '.gitignore', <<-CODE
config/database.yml
CODE

# add to Gemfile
run 'rm -rf Gemfile'
file 'Gemfile', <<-CODE
source 'https://rubygems.org'

ruby '2.1.0'

## 共通
# 最新のrails
gem 'rails', '4.0.2'

# devise: ユーザー認証gem
gem 'devise'

# mysql コネクタgem
gem 'mysql2'

# SASS スタイルシート導入
gem 'sass', '3.3.0.rc.1'
gem 'sass-rails', '~> 4.0.0'

# LESSにしたい人はこちら
#gem 'less-rails'

# Uglifier: JavaScriptを圧縮&難読化
gem 'uglifier', '>= 1.3.0'

# CoffeeScript導入
gem 'coffee-rails', '~> 4.0.0'

# therubyracerはV8 JavaScriptエンジンをrubyから使うためのgemだが、コンパイルが始まるとインストールに時間がかかるので外してある。参照: http://d.hatena.ne.jp/suu-g/20121222/1356189597
# gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
# Jquery導入

# Turbolinks導入。邪魔だが依存関係があるので入れてある
gem 'turbolinks'

# JSON APIをビルドする。Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # APIドキュメントを生成するには: bundle exec rake doc:rails generates the API under doc/api
  gem 'sdoc', require: false
end

# アセットのログを削除
gem 'quiet_assets'

# HTML5 validation
gem 'html5_validators'

# PG/MySQL ログフォーマッタ
gem 'rails-flog'

# 秘密鍵などをENV経由で利用する https://github.com/laserlemon/figaro
# gem 'figaro'

# ActiveModel でパスワード暗号化に使用。http://bakunyo.hatenablog.com/entry/2013/05/26/bcrypt-ruby%E3%82%92Rails%E3%81%A7%E4%BD%BF%E3%81%86
  gem 'bcrypt-ruby', '~> 3.1.2'

# デプロイ自動化 http://labs.gree.jp/blog/2013/12/10084/
  gem 'capistrano', group: :development

# エラー表示はbetter_errors一択
# gem 'debugger', group: [:development, :test]
  gem 'better_errors'

# Bower Manager => https://rails-assets.org/
source 'https://rails-assets.org'

# jqueryでのturbolinksサポート
gem 'jquery-turbolinks'

# SourceMaps (圧縮されたJavaScriptのバグをブラウザ上でトラックする) http://www.publickey1.jp/blog/12/javascriptcoffeescriptsource_maps.html
gem 'coffee-rails-source-maps'
gem 'sass-rails-source-maps'

# プレゼンター層の追加
gem 'draper'

# Hamlの導入
gem 'haml-rails'

# フォーム作成支援 http://www.ohmyenter.com/?p=197
gem 'simple_form'

# herokuでプロセス管理する場合に使用 http://www.ownway.info/Ruby/index.php?foreman/about
# gem 'foreman'

# ページ切り替え処理
# gem 'kaminari' http://memo.yomukaku.net/entries/238

# パフォーマンス管理・サービス監視 NewRelic https://github.com/newrelic/rpm
gem 'newrelic_rpm'

# エラー時にメール通知 http://www.slideshare.net/morimorihoge1/gem-24158289
# gem 'airbrake'

# HTML/XMLパーサー http://nokogiri.org/
# gem 'nokogiri'

# 重たい処理を非同期で実行 http://blog.nzm-o.com/item/222
# gem 'delayed_job'

# cron処理 http://morizyun.github.io/blog/whenever-gem-rails-ruby-capistrano/
# gem 'whenever'

# 添付ファイルをActiveRecord透過で保存できる (ImageMagick必要) https://github.com/thoughtbot/paperclip
# gem 'paperclip'

# Rails/Rack Profiler
# gem 'speed_gun'

# Hash extensions
# gem 'hashie'

# PDFサポート。ただしMIMEタイプがらみでwarningが出る。
gem 'prawn-rails'

# refactoring suggestions
gem 'rails_best_practices'

# doorkeeper: OAuth2 authentication
# gem 'doorkeeper'

#------- reserverd ---------#
# friently_id: changes URL to non-REST string form
# gem 'friendly_id'

# ransack: search form
# gem 'ransack'

group :development do
  # Converter erb => haml
  gem 'erb2haml'

  # view/cssの更新監視・ブラウザリロード
  gem 'guard-livereload'
  gem 'em-websocket'

end

group :development, :test do

  # ローカルweb server
  gem 'thin'

  # Rails application preloader
  gem 'spring'
  gem 'spring-commands-rspec'

  # Railsコンソールの多機能版
  gem 'pry-rails'

  # pryの入力に色付け
  gem 'pry-coolline'

  # pryの色付けをしてくれる
  gem 'awesome_print'

  # デバッカー
  gem 'pry-byebug'

  # Pryでの便利コマンド
  gem 'pry-doc'

  # PryでのSQLの結果を綺麗に表示
  gem 'hirb'
  gem 'hirb-unicode'

  # coverage
  gem "simplecov", require: false

  # Rspec
  gem 'rspec-rails'
  gem 'rake_shared_context'
  gem 'capybara'

  # fixtureの代わり
  gem "factory_girl_rails"
  gem 'faker'
  gem 'faker-japanese'

  # HTTP requestのモックアップ作成 http://d.hatena.ne.jp/kitamomonga/20100325/ruby_hello_webmock
  gem 'webmock'

  # 追加マッチャー集 http://morizyun.github.io/blog/shoulda-matchers-rspec-matcher/
  gem 'shoulda-matchers'

  # テスト環境のテーブルをきれいにする
  gem 'database_rewinder'

  # Guard
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spring'

  # Gemfileが更新されたら自動でbundle installを実行
  gem 'guard-bundler'

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
      g.routing_specs true
      g.helper_specs false
      g.request_specs false
      g.feature_specs true
      g.decorator_specs false
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
run 'wget https://gist.github.com/kawamoto/4729292/raw/devise.ja.yml -P config/locales/'

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
run 'cp config/database.yml config/database_sample.yml'
gsub_file 'config/database.yml', /PASSWD/, @db_password
run "mysql -e create user #{@app_name} identified by #{@db_password}"
run 'bundle exec rake RAILS_ENV=development db:create'

# Rspec/Spring/Guard
# ----------------------------------------------------------------
# Rspec
generate 'rspec:install'
run "echo '--color --drb -f d' > .rspec"

insert_into_file 'spec/spec_helper.rb',%(
  require 'simplecov'
  SimpleCov.start

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

insert_into_file 'spec/spec_helper.rb', "\nrequire 'factory_girl_rails'", "\nrequire 'simplecov'", "\nrequire 'shoulda-matchers'", after: "require 'rspec/rails'"
gsub_file 'spec/spec_helper.rb', "require 'rspec/autorun'", ''

# Spring
run 'wget https://raw.github.com/jonleighton/spring/master/bin/spring -P bin/'
run 'sudo chmod a+x bin/spring'

# Guard
run 'bundle exec guard init'
gsub_file 'Guardfile', 'guard :rspec do', "guard :rspec, cmd: 'bundle exec spring rspec -f doc' do"

run 'bundle install'

# git flow init
# ----------------------------------------------------------------
run 'git flow init'
# git :init
git :add => '.'
git :commit => "-a -m 'first commit'"
