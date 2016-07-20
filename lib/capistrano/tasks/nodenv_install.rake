require 'capistrano/dsl/nodenv_install'

include Capistrano::DSL::NodenvInstall

# Heavily depends on 'capistrano-nodenv' variables:
# https://github.com/capistrano/nodenv/blob/master/lib/capistrano/tasks/nodenv.rake#L33-49
# set :nodenv_type               # :user or :system
# set :nodenv_node, '6.3.0'      # node version
# set :nodenv_roles, :all        # where nodenv should be installed
# set :nodenv_path,              # ~/.nodenv or /usr/local/nodenv, depends on :nodenv_type
# set :nodenv_node_dir           # "#{fetch(:nodenv_path)}/versions/#{fetch(:nodenv_node)}" }

namespace :nodenv do
  desc 'Install nodenv'
  task :install_nodenv do
    on roles fetch(:nodenv_roles) do
      next if test "[ -d #{fetch(:nodenv_path)} ]"
      execute :git, :clone, nodenv_repo_url, fetch(:nodenv_path)
    end
  end

  desc 'Install node build - nodenv plugin'
  task :install_node_build do
    on roles fetch(:nodenv_roles) do
      next if test "[ -d #{nodenv_node_build_path} ]"
      execute :git, :clone, node_build_repo_url, nodenv_node_build_path
    end
  end

  desc 'Update node build - nodenv plugin'
  task :update_node_build do
    on roles fetch(:nodenv_roles) do
      next unless test "[ -d #{nodenv_node_build_path} ]"
      within nodenv_node_build_path do
        execute :git, :pull
      end
    end
  end

  desc 'Install node'
  task :install_node do
    on roles fetch(:nodenv_roles) do
      next if test "[ -d #{fetch(:nodenv_node_dir)} ]"
      invoke 'nodenv:update_node_build'
      execute nodenv_bin_executable_path, :install, fetch(:nodenv_node)
    end
  end

  desc 'Install nodenv, node build and node version'
  task :install do
    invoke 'nodenv:install_nodenv'
    invoke 'nodenv:install_node_build'
    invoke 'nodenv:install_node'
  end

  before 'nodenv:validate', 'nodenv:install'
  before 'bundler:map_bins', 'nodenv:install' if Rake::Task.task_defined?('bundler:map_bins')
end
