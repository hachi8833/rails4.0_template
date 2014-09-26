# アプリ名の取得
@app_name = app_name
@db_password = ENV['DB_PASSWORD']
# clean file
run 'rm README.rdoc'
run 'wget https://raw.github.com/hachi8833/rails4.0_template/master/Readme.md -P .'

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

ruby '2.1.2'

# nokogiriインストールエラー回避のための環境変数設定
ENV['NOKOGIRI_USE_SYSTEM_LIBRARIES'] = 'YES'

#hamlが動くようにするためのおまじない
gem 'macaddr', '1.6.1'

# regular gems http://www.ohmyenter.com/?p=371
gem 'rails', '~> 4.1.1'
gem 'haml-rails'
gem 'mysql2'
gem 'sass-rails', '~> 4.0.3'
gem 'compass-rails'
gem 'uglifier', '>= 1.3.0'   #JavaScriptの圧縮&難読化
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks' # jqueryでのturbolinksサポート
gem 'jbuilder'   # JSON APIをビルドする。Read more: https://github.com/rails/jbuilder
gem "autoprefixer-rails" # css に自動でベンダープレフィックスを与えてくれる

gem 'foundation-rails'
gem 'foundation-icons-sass-rails'

gem 'draper' #Presenter層の追加
gem 'ransack' #簡易検索機能
gem 'simple_form' # フォーム作成支援 http://www.ohmyenter.com/?p=197
gem 'angularjs-rails'
gem 'annotate' #bundle exec annotateでモデルにスキーマコメントを追加
gem 'figaro' # 秘密鍵などをENV経由で利用する https://github.com/laserlemon/figaro
gem 'i18n_generators' # ja.ymlの取得と生成

group :development do
# gem 'rack-mini-profiler' #パフォーマンス測定
  gem 'brakeman', :require => false #appディレクトリでbrakemanコマンドを実行してセキュリティチェック
  gem 'rails_best_practices' # リファクタリングのアシスタント
  gem 'bullet' #N+1問題を検出 http://p.tl/Ev-s
  gem "meta_request" #ChromeでRailsデバッグ用タブ追加
  gem 'web-console' #ブラウザから使用できるコンソール。当然developmentのみ
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
  gem 'whiny_validation' #バリデーションエラーをログに出力する http://p.tl/FW8O
  gem 'fuubar' #RSpec出力を見やすくフォーマット
end

group :test do
  gem "shoulda-matchers"
  gem 'factory_girl_rails'
  gem 'launchy' #save_and_open_pageをspecに追加するとブラウザを表示する
  gem 'capybara' #ブラウザのテストに使う
  gem 'faker' #それっぽいテストデータを生成する
  gem 'faker-japanese'
  gem 'poltergeist' #phantomjsをインストールする必要あり。スクショも撮れる
  gem 'simplecov', require: false #カバレッジ
  gem 'database_rewinder'   # テスト環境のテーブルをきれいにする
  gem 'turnip' #ユーザー指向テスティング http://qiita.com/moriyaman/items/af2a0264adbaaa0d2029
  gem 'turnip_formatter' # turnipログ整形 https://github.com/gongo/turnip_formatter
  gem 'gnawrnip' #turnipエラーのスクリーンショットを撮る https://github.com/gongo/gnawrnip
end

group :doc do
  gem 'sdoc', '~> 0.4.0', require: false
end

group :production, :staging do
  gem 'unicorn' # 本番用Webサーバー
  # gem 'rails_12factor'   # ログ保存先変更、静的アセット Heroku 向けに調整
  gem 'exception_notification' #エラー時にメールを送信する。メールサーバーを設定する必要あり https://github.com/smartinez87/exception_notification
end

# オプション ############
# gem 'devise' #ユーザー認証
# gem 'sqlite3' #
# gem 'rails-erd' #rake erdでERD図自動生成
# gem 'acts-as-taggable-on' #SEO用タグ生成 http://morizyun.github.io/blog/acts-as-taggable-on-gem-rails/
# gem 'carrierwave' #画像アップロード用
# gem 'paranoia' #論理削除 https://github.com/radar/paranoia
# gem 'therubyracer', platforms: :ruby
# gem 'quiet_assets' # アセットのログ出力抑制
# gem 'html5_validators' # フォーム入力の自動バリデーションhttps://github.com/amatsuda/html5_validators
# gem 'jpmobile' #スマホとPCのビュー自動切り替え
# gem 'rails_autolink' #URLを自動的にリンク化する
# gem 'rails-flog' # PG/MySQL ログフォーマッタ
# gem 'bcrypt', '~> 3.1.7' # ActiveModel でパスワード暗号化に使用。http://bakunyo.hatenablog.com/entry/2013/05/26/bcrypt-ruby%E3%82%92Rails%E3%81%A7%E4%BD%BF%E3%81%86
# gem 'capistrano-rails', group: :development # デプロイ自動化 http://labs.gree.jp/blog/2013/12/10084/
# gem 'nokogiri' # HTML/XMLパーサー http://nokogiri.org/
# SourceMaps (圧縮されたJavaScriptのバグをブラウザ上でトラックする) http://www.publickey1.jp/blog/12/javascriptcoffeescriptsource_maps.html
  # gem 'coffee-rails-source-maps'
  # gem 'sass-rails-source-maps'
# gem 'foreman' # herokuでプロセス管理する場合に使用 http://www.ownway.info/Ruby/index.php?foreman/about
# gem 'kaminari' # ページ切り替え処理 http://memo.yomukaku.net/entries/238
# gem 'newrelic_rpm' # パフォーマンス管理・サービス監視 NewRelic https://github.com/newrelic/rpm
# gem 'airbrake' # エラー時にメール通知 http://www.slideshare.net/morimorihoge1/gem-24158289
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
# gem 'acts_as_list' #リストの並べ替えや移動を行えるようにする https://github.com/swanandp/acts_as_list

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
  # gem 'letter_opener' #メール送信をブラウザ表示に差し替える http://p.tl/01GH
end

CODE

# install gems
run 'bundle install --path vendor/bundle'

# Foundation & Simple Form
generate 'layout:install foundation5'
generate 'simple_form:install --foundation'

# set Japanese locale
generate 'i18n_locale ja'
run 'rm -rf config/locales/ja.yml'
run 'wget https://raw.github.com/hachi8833/rails4.0_template/master/config/locales/ja.yml -P config/locales/'

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
      g.orm :active_record
      g.template_engine :haml
      g.test_framework  :rspec, :fixture => true
      g.fixtures true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
      g.view_specs false
      g.controller_specs true #scaffoldのテスト生成用
      g.routing_specs false
      g.helper_specs false
      g.request_specs false # パブリックAPIのテスト用
      g.feature_specs true #結合テスト用
      g.acceptance_specs true #受入テスト用
      g.decorator_specs true
      g.assets false
      g.helper false
    end

    # libファイルの自動読み込み
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
  }
end

#●Rails 4.1でのsecrets.ymlの扱いの変更について要対応
run 'rm -rf config/initializers/secret_token.rb'
file 'config/initializers/secret_token.rb', <<-FILE
#{@app_name.classify}::Application.config.secret_key_base = ENV['SECRET_KEY_BASE'] || '#{`rake secret`}'
FILE


# application.js(turbolink setting)
run 'rm -rf app/assets/javascripts/application.js'
run 'wget https://raw.github.com/hachi8833/rails4.0_template/master/app/assets/javascripts/application.js -P app/assets/javascripts/'

# HAML
run 'bundle exec rake haml:replace_erbs'

gsub_file 'app/views/layouts/application.html.haml', /= yield/, ''

# insert_into_file 'app/views/layouts/application.html.haml',%(
#     %meta{ :charset => "UTF-8" }'
# ), after: '  %head'
# insert_into_file 'app/views/layouts/application.html.haml',%(
#     .container
#       %header
#       %section
#         = yield
#       %aside
#       %footer
#   ), after: '  %body'

run 'https://raw2.github.com/MiraitSystems/enju_trunk/master/config/locales/simple_form.ja.yml -P config/locales/'

# Figaro
generate 'figaro:install'

# Kaminari config
# generate 'kaminari:config'

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
run 'cp config/database.yml config/database.yml.sample'
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

  # config.before :suite do
  #   DatabaseRewinder.clean_all
  # end

  # config.after :each do
  #   DatabaseRewinder.clean
  # end

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
#  require 'database_rewinder'
  Capybara.javascript_driver = :poltergeist
), after: "require 'rspec/rails'"

insert_into_file 'config/environments/development.rb',%(
# Rack::MiniProfiler.config.position = 'right'

  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.growl = false
    Bullet.rails_logger = true
    Bullet.airbrake = false
    Bullet.add_footer = true
  end
), after: 'config.assets.debug = true'

gsub_file 'spec/spec_helper.rb', "require 'rspec/autorun'", ''

# Guard
run 'bundle exec guard init'
gsub_file 'Guardfile', 'guard :rspec do', "guard :rspec, cmd: 'bundle exec spring rspec -f doc' do"

run 'bundle install'

# git flow init
run 'git flow init'

# devise
if yes?('Deviseをモデル:Userでインストールしますか?')
  gsub_file 'Gemfile', "# gem 'devise'", "gem 'devise'"
  run 'bundle install'
  run 'bundle exec rails generate devise:install'
  run 'rm -rf app/views/layouts/application.html.haml'
  run 'wget https://raw.github.com/hachi8833/rails4.0_template/master/app/views/layouts/application.html.haml -P app/views/layouts/'
  insert_into_file 'config/environments/development.rb',%(
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
), after: '  config.action_mailer.raise_delivery_errors = false'
  run 'bundle exec rails generate devise user'
  run 'bundle exec rake db:migrate'
  run 'bundle exec rails generate devise:views'
  run 'wget https://raw.github.com/hachi8833/rails4.0_template/master/config/locales/devise.ja.yml -P config/locales/'
  insert_into_file 'app/controllers/application_controller.rb',%(
  before_action :authenticate_user!
), after: '  protect_from_forgery with: :exception'

  puts "● devise設定完了しました。"
  puts "● application_controller.rbにdeviseのbefore_actionを追加しましたので、アプリケーション全体で認証が必要となっています。"
  puts "● 必ずroute.rb で root_to を設定してから起動してください。"
end

puts "● 「be rails g scaffold 単数形のモデル名」を実行できる。"
puts "string 文字列
text  長い文字列
integer 整数
float 浮動小数
decimal 精度の高い小数
datetime  日時
timestamp より細かい日時
time  時間
date  日付
binary  バイナリデータ
boolean Boolean型"

puts "● 中間テーブルでは主キーを無効化し、タイムスタンプ列を削除すること"

puts "● マイグレーション後、bundle exec annotateを実行するとモデルにスキーマ情報が追記される"
puts "● モデル作成後にrails g i18n_translation jaを実行すると、ローカライズ用translation_ja.ymlが生成される"
puts "● ブレークポイントを仕込みたいソースコード上にbinding.pryという文字列を仕込むことで、rails serverで起動したコンソール上でブレークポイントを通るときにpryによるデバッガが立ち上がる。"
puts "● マイグレーションファイルの生成は「be rails g migration Addカラム名Toテーブル名 カラム名:型名」"
puts "● Launchyをインストールしてあるので、RSpecのデバッグに save_and_open_pageが使える"
puts "● appディレクトリでbrakemanコマンドを実行することでセキュリティチェックを行える"
puts "● rspec -r turnip_formatter --format RSpecTurnipFormatter --out report.html を実行することturnipの出力がフォーマットされる"
puts "● gnawrnipでテストをキャプチャしたいときは以下をfeatureファイルに追加する"
puts "● require 'gnawrnip"
puts "● Gnawrnip.ready!"