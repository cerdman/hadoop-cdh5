require 'yaml'

class MyVagrantLib
    @required_plugins = %w( vagrant-omnibus vagrant-berkshelf vagrant-lxc )

    def initialize()
    end 

    def check_plugins
        @required_plugins.each do |plugin|
          if Vagrant.has_plugin? plugin
            puts "vagrant plugin #{plugin} already present"
          else
            system "vagrant plugin install #{plugin}"
          end
        end
    end

    def get_provider(default_config)
        provider = nil
        if !default_config.nil and !default_config.empty
          config = YAML.load_file default_config
          provider = config['provisioner']
          if provider.nil or provider.empty or provider == "default"
            provider = nil
          end
        end
        if provider.nil
          if ARGV[1] and \
             (ARGV[1].split('=')[0] == "--provider" or ARGV[2])
            provider = (ARGV[1].split('=')[1] || ARGV[2]).to_sym
          else
            provider = (ENV['VAGRANT_DEFAULT_PROVIDER'] || :virtualbox).to_sym
          end
        end
        return provider
    end
end
