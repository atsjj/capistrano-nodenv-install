module Capistrano
  module DSL
    module NodenvInstall
      def nodenv_node_build_path
        "#{fetch(:nodenv_path)}/plugins/node-build"
      end

      def nodenv_bin_executable_path
        "#{fetch(:nodenv_path)}/bin/nodenv"
      end

      def nodenv_repo_url
        'https://github.com/nodenv/nodenv.git'
      end

      def node_build_repo_url
        'https://github.com/nodenv/node-build.git'
      end
    end
  end
end
