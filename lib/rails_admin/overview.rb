module RailsAdmin
  module Config
    module Actions
      class Overview < RailsAdmin::Config::Actions::Base
        
        register_instance_option :link_icon do
          'icon-home'
        end
        # You may or may not want pjax for your action
        register_instance_option :pjax? do
          false
        end
      end
    end
  end
end