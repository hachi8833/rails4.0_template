a# アプリ名の取得
@app_name = app_name
@db_password = ENV['DB_PASSWORD']
# clean file
# run 'mv README.rdoc README.md'

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

# regular gems http://www.ohmyenter.com/?p=371
gem 'rails', '~> 4.0.2'
gem 'haml-rails'
gem 'mysql2'
gem 'sass-rails'
gem 'uglifier'   #JavaScriptの圧縮&難読化
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks' # jqueryでのturbolinksサポート
gem 'jbuilder'   # JSON APIをビルドする。Read more: https://github.com/rails/jbuilder

gem 'draper' #Presenter層の追加
gem 'ransack' #簡易検索機能
gem 'simple_form' # フォーム作成支援 http://www.ohmyenter.com/?p=197
gem 'angularjs-rails'
gem 'annotate' #bundle exec annotateでモデルにスキーマコメントを追加
gem 'figaro' # 秘密鍵などをENV経由で利用する https://github.com/laserlemon/figaro

group :development do
  gem 'rack-mini-profiler' #パフォーマンス測定
  gem 'brakeman', :require => false #appディレクトリでbrakemanコマンドを実行してセキュリティチェック
  gem 'rails_best_practices' # リファクタリングのアシスタント
  gem 'bullet' #N+1問題を検出 http://p.tl/Ev-s
end

group :development, :test do
  gem 'thin' # ローカルweb server
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-byebug'
  gem 'pry-coolline' #Pry入力色付け
  gem 'awesome_print' #Pry色付け
  gem 'hirb' #pryのSQLを整形
  gem 'hirb-unicode'
  gem 'rspec-rails'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem "shoulda-matchers"
  gem 'factory_girl_rails'
  gem 'launchy' #save_and_open_pageをspecに追加するとブラウザを表示する
  gem 'capybara' #ブラウザのテストに使う
  gem 'faker' #それっぽいテストデータを生成する
  gem 'faker-japanese'
  gem 'poltergeist' #phantomjsをインストールする必要あり。スクショも撮れる
  gem "simplecov", require: false #カバレッジ
  gem 'database_rewinder'   # テスト環境のテーブルをきれいにする
end

group :doc do
  gem 'sdoc', require: false
end

group :production, :staging do
  gem 'unicorn' # 本番用Webサーバー
  # gem 'rails_12factor'   # ログ保存先変更、静的アセット Heroku 向けに調整
end

# オプション ############
# gem 'devise' #ユーザー認証
# gem 'sqlite3' #
# gem 'rails-erd' #rake erdでERD図自動生成
# gem 'acts-as-taggable-on' #SEO用タグ生成 http://morizyun.github.io/blog/acts-as-taggable-on-gem-rails/
# gem 'carrierwave' #画像アップロード用
# gem 'paranoia' #論理削除 https://github.com/radar/paranoia
# gem 'therubyracer', platforms: :ruby
# gem 'quiet_assets' # アセットのログを削除
# gem 'html5_validators' # フォーム入力の自動バリデーションhttps://github.com/amatsuda/html5_validators
# gem 'jpmobile' #スマホとPCのビュー自動切り替え
# gem 'rails_autolink' #URLを自動的にリンク化する
# gem 'rails-flog' # PG/MySQL ログフォーマッタ
# gem 'bcrypt-ruby', '~> 3.1.2' # ActiveModel でパスワード暗号化に使用。http://bakunyo.hatenablog.com/entry/2013/05/26/bcrypt-ruby%E3%82%92Rails%E3%81%A7%E4%BD%BF%E3%81%86
# gem 'capistrano', group: :development # デプロイ自動化 http://labs.gree.jp/blog/2013/12/10084/
# SourceMaps (圧縮されたJavaScriptのバグをブラウザ上でトラックする) http://www.publickey1.jp/blog/12/javascriptcoffeescriptsource_maps.html
  # gem 'coffee-rails-source-maps'
  # gem 'sass-rails-source-maps'
# gem 'foreman' # herokuでプロセス管理する場合に使用 http://www.ownway.info/Ruby/index.php?foreman/about
# gem 'kaminari' # ページ切り替え処理 http://memo.yomukaku.net/entries/238
# gem 'newrelic_rpm' # パフォーマンス管理・サービス監視 NewRelic https://github.com/newrelic/rpm
# gem 'airbrake' # エラー時にメール通知 http://www.slideshare.net/morimorihoge1/gem-24158289
# gem 'nokogiri' # HTML/XMLパーサー http://nokogiri.org/
# gem 'delayed_job' # 重たい処理を非同期で実行 http://blog.nzm-o.com/item/222
# gem 'whenever' # cron処理 http://morizyun.github.io/blog/whenever-gem-rails-ruby-capistrano/
# gem 'paperclip' # 添付ファイルをActiveRecord透過で保存できる (ImageMagick必要) https://github.com/thoughtbot/paperclip
# gem 'roo' #Excelやcsvを透過的に扱える
# gem 'thinreports' #高品質なPDF帳票作成ライブラリ http://www.thinreports.org/
# gem 'virtus' #rubyのクラスを拡張できる https://github.com/solnic/virtus
# gem 'speed_gun' #パフォーマンス測定 http://rosylilly.hatenablog.com/entry/2013/12/03/184748
# gem 'hashie' # Hashの拡張
# gem 'prawn-rails' # PDFサポート。ただしMIMEタイプがらみでwarningが出る。
# gem 'doorkeeper' #OAuth2認証
# gem 'friendly_id' #URLをクエリ形式にする

group :development do
  gem 'erb2haml' # Converter erb => haml
  # view/cssの更新監視・ブラウザリロード
  # gem 'guard-livereload'
  # gem 'em-websocket'
end

group :development, :test do
  # gem 'rake_shared_context'
  # gem 'webmock'   # HTTP requestのモックアップ作成 http://d.hatena.ne.jp/kitamomonga/20100325/ruby_hello_webmock
  gem 'guard' #ファイル更新をウオッチ
  gem 'guard-rspec'
  gem 'guard-spring'
  # gem 'guard-bundler' # Gemfileが更新されたら自動でbundle installを実行
end

CODE

# install gems
run 'bundle install --path vendor/bundle'

# set config/application.rb
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
      g.assets false
      g.helper false
      g.orm :active_record
      g.template_engine :haml
      g.test_framework  :rspec, :fixture => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
      g.view_specs false
      g.controller_specs false
      g.routing_specs true
      g.helper_specs false
      g.request_specs true
      g.feature_specs true
      g.decorator_specs true
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

# Bootstrap/Bootswach/Font-Awesome
insert_into_file 'app/views/layouts/application.html.haml',%(
%script{:src=>'//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js'}
%link{:href=>'//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css', :rel=>'stylesheet'}
%link{:href=>'//netdna.bootstrapcdn.com/bootswatch/3.0.3/simplex/bootstrap.min.css', :rel=>'stylesheet'}
), after: '= csrf_meta_tags'

# Simple Form
generate 'simple_form:install --bootstrap'

# Kaminari config
# generate 'kaminari:config'
# generate 'kaminari:views  bootstrap'

# run 'rm -rf app/view/kaminari/_paginator.html.haml'
# file 'app/view/kaminari/_paginator.html.haml', <<-FILE
# = paginator.render do
#   .pagination{style: 'text-align: center; display: block;'}
#     %ul.pagination
#       = first_page_tag unless current_page.first?
#       = prev_page_tag unless current_page.first?
#       - each_page do |page|
#         - if page.left_outer? || page.right_outer? || page.inside_window?
#           = page_tag page
#         - elsif !page.was_truncated?
#           = gap_tag
#       = next_page_tag unless current_page.last?
#       = last_page_tag unless current_page.last?
# FILE

# Database
run 'rm -rf config/database.yml'
run 'wget https://raw.github.com/hachi8833/rails4.0_template/master/config/database.yml -P config/'
gsub_file 'config/database.yml', /APPNAME/, @app_name
run 'cp config/database.yml config/database_sample.yml'
gsub_file 'config/database.yml', /PASSWD/, @db_password
db_password = "'" + @db_password + "'"
run 'bundle exec rake RAILS_ENV=development db:create'
run 'bundle exec rake RAILS_ENV=test db:create'

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

insert_into_file 'spec/spec_helper.rb',%(
  require 'factory_girl_rails'
  require 'simplecov'
  require 'shoulda-matchers'
  require 'capybara'
  require 'capybara/rspec'
  require 'capybara/poltergeist'
  Capybara.javascript_driver = :poltergeist
), after: "require 'rspec/rails'"

insert_into_file 'config/environments/development.rb',%(
  Rack::MiniProfiler.config.position = 'right'

  config.after_initialize do
  Bullet.enable = true
  Bullet.alert = true
  Bullet.bullet_logger = true
  Bullet.console = true
  Bullet.growl = true
  Bullet.xmpp = { :account  => 'bullets_account@jabber.org',
                  :password => 'bullets_password_for_jabber',
                  :receiver => 'your_account@jabber.org',
                  :show_online_status => true }
  Bullet.rails_logger = true
  Bullet.airbrake = true
  Bullet.add_footer = true
), after: 'config.assets.debug = true'

gsub_file 'app/views/layouts/application.html.haml', /= yield/, ''

insert_into_file 'app/views/layouts/application.html.haml',%(
    %meta{ :charset => "UTF-8" }'
), after: '  %head'
insert_into_file 'app/views/layouts/application.html.haml',%(
    %div.container
      %header
      %section
        = yield
      %aside
      %footer
  ), after: '  %body'

gsub_file 'spec/spec_helper.rb', "require 'rspec/autorun'", ''

# Guard
run 'bundle exec guard init'
gsub_file 'Guardfile', 'guard :rspec do', "guard :rspec, cmd: 'bundle exec spring rspec -f doc' do"

run 'bundle install'

# git flow init
run 'git flow init'
