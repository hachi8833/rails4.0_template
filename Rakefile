#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

RAILS_DIR = "~/dev/rails"
REPOSITORY = "https://raw.github.com/hachi8833/rails4.0_template/master/app_template.rb"
REPOSITORY_F = "https://raw.github.com/hachi8833/rails4.0_template/master/app_template-f.rb"
DEL_OPTION = ""

app = ENV['app']

if app == nil
  puts "usage for creation: rake app=appname"
  puts "usage for deleting: rake clean app=appname"
  puts "作成または削除するアプリ名を「app=アプリ名」の形で引数として指定してください"
  fail
end

task default: :create

desc 'Rail4 アプリ "#{app}" を作成する(デフォルト)'
task :create do
  sh "cd #{RAILS_DIR}"
  sh "rails new #{app} --database=mysql --skip-test-unit --skip-bundle -m #{REPOSITORY}"
end

desc 'Rail4 アプリ "#{app}" を作成する(Foundation版)'
task :createf do
  sh "cd #{RAILS_DIR}"
  sh "rails new #{app} --database=mysql --skip-test-unit --skip-bundle -m #{REPOSITORY_F}"
end

desc 'Rails4アプリ "#{app}" を削除する'
task :clean do
  DEL_OPTION << "'" << "drop database #{app}_development;drop database #{app}_test;" << "'"
  sh "rm -rf #{app}"
  sh "mysql -u root -p -e #{DEL_OPTION}"
end

task add: :create
task new: :create
task clear: :clean
task remove: :clean
task delete: :clean
task destroy: :clean
task kill: :clean
