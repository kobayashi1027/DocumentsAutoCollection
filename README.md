# DocumensAutoCollection

本プログラムは，ローカルで日々編集・参照しているドキュメントを自動収集するものである．

## 使用方法

1. rbenv と ruby-build をインストール

    ``` sh
    $ git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    $ git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    ```
1. ruby と bundler をインストール

    ``` sh
    # Install ruby 2.2.1
    $ rbenv install 2.2.1

    # Installation check
    $ rbenv global 2.2.1
    $ ruby -v # -> You will see: ruby 2.2.1...

    # Install bundler for your new Ruby
    $ gem install bundler

    # Activate bundler
    $ rbenv rehash

    # Get back to your sytem default Ruby if you want
    $ rbenv global system # say, /usr/bin/ruby
    $ ruby -v
    ```

3. リポジトリをclone

4. gemをインストール

    ``` sh
    $ cd DocumentsAutoCollection
    $ bundle install --path vendor/bundle
    ```

5. Documents_fileディレクトリを作成

    ``` sh
    $ mkdir Documents_file
    ```

6. setting_cronファイルの内容に従い，cronを設定
