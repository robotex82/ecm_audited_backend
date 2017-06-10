module Ecm
  module Audited
    module Backend
      module Configuration
        def configure
          yield self
        end
      
        mattr_accessor(:registered_controllers) { -> { [] } }
        mattr_accessor(:registered_services)    { -> { [] } }
      end
    end
  end
end
