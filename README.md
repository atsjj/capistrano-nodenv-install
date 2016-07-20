# Capistrano::Nodenv::Install

Capistrano plugin for **lightweight** nodes management with nodenv.

Works with Capistrano 3 (only).

### Installation

Install by adding the following to the `Gemfile`:

    gem 'capistrano', '~> 3.2.1'
    gem 'capistrano-nodenv', '~> 1.0' # required
    gem 'capistrano-nodenv-install', '~> 1.0'

then:

    $ bundle install

### Configuration and usage

The following goes to `Capfile`:

    require 'capistrano/nodenv_install'

This plugin heavily relies on
[capistrano-nodenv config options](https://github.com/atsjj/capistrano-nodenv#usage).
So make sure to properly setup `capistrano-nodenv` and you'll be good.

For example, in `config/deploy.rb`:

    set :nodenv_node, '6.3.0'

Other than that, this plugin does not need any setup.

Run:

    $ bundle exec cap production deploy

And watch node being installed.

### Purpose

Installing software packages on servers is called
[provisioning](http://en.wikipedia.org/wiki/Provisioning#Server_provisioning).
Installing and managing nodes falls into that domain, and is best done with a
proper tool like chef, puppet, ansible or something else.

Why this plugin then?

- Capistrano is a great tool that makes deployments easy so, when there's a
need, installing nodes with it should be easy too
- not everyone knows (or has time to learn) how to use provisioning tools
mentioned above
- sometimes installing node manually is just easier than fiddling with your
chef cookbooks. Instead of manually, you can do it with this plugin now

Imagine you want to quickly deploy a node `5.0.0` app to a server that already
has one or more node `6.0.0` apps.
"Oh, let's just quickly update our cookbooks" - yea right! I'd rather manually
`ssh` to the server directly and run `nodenv install 5.0.0`. But I don't
want to manually `ssh` to the server too. In that case I just can install
`capistrano-nodenv-install` and forget about it altogether.

### What it does

It only does the bare minimum that's required for Capistrano to work. That's
why it's a plugin for *lightweight* node management.

It makes sure that:

- `nodenv` and `node build` are installed (installs them using `git`)
- node specified with `:nodenv_node` option is installed

### What it does NOT do

It **does not**:

- manage npm packages

- does not install node dependency packages<br/>
(git-core build-essential libreadline6-dev etc ...). You should probably
install/provision those some other way.

- does not manage `nodenv` plugins<br/>
It only installs `node build` for the purpose of installing node.

- does not setup nodenv for direct use on the server via the command line<br/>
Example: `ssh`ing to the server and manually running node commands is not
supported.

### More Capistrano automation?

Check out [capistrano-plugins](https://github.com/capistrano-plugins) github org.

### Thanks

The authors of [Capistrano::Rbenv::Install](https://github.com/capistrano-plugins/capistrano-rbenv-install)
This would not have been possible without your original work!

### License

[MIT](LICENSE.txt)
