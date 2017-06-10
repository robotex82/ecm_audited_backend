module Ecm
  module Audited
    module Backend
      class Engine < ::Rails::Engine
        isolate_namespace Ecm::Audited::Backend  

        config.paths.add root.join(*%w(app extensions concerns)).to_s, eager_load: true
        
        config.to_prepare do
          puts "Including Controller::Ecm::Audited::AuditLogConcern into Itsf::Backend::Resource::BaseController."
          Itsf::Backend::Resource::BaseController.send(:include, Controller::Ecm::Audited::AuditLogConcern)
        end
      end
    end
  end
end



