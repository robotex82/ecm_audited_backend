module Ecm::Audited::Backend
  class AuditLogsController < Itsf::Backend::Resource::BaseController
    def self.resource_class
      Ecm::Audited::AuditLog
    end

    private

    def disabled_features
      [:ransack]
    end
  end
end