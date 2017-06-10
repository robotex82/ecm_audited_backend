Itsf::Backend.configure do |config|
  config.resource_links  += [
    {
      condition: ->(view) { Ecm::Audited.audited_models.call.keys.include?(view.controller.resource_class) },
      target:    ->(view) { view.url_for(action: :audit_log) },
      link_to:   ->(view) { 
        view.link_to(
          view.t(".audit_log", audits_count: view.instance_variable_get(:@resource)),
          view.url_for(action: :audit_log)
        )
      }
    }
  ]

  # This has to be refactored
  config.additional_resource_route_blocks += [
    ->(router) do
      # Find out if the resource uses audited
      __controller = router.instance_variable_get(:@scope).instance_variable_get(:@hash)[:controller]
      __namespaces = []
      __actual_scope = router.instance_variable_get(:@scope)
      while __actual_scope.instance_variable_get(:@parent).present?
        __namespaces << __actual_scope.instance_variable_get(:@parent).instance_variable_get(:@hash).try(:[], :module)
        __actual_scope = __actual_scope.instance_variable_get(:@parent)
      end
      __namespace = __namespaces.uniq.reverse.compact.join("/")

      __controller = "#{__namespace}/#{__controller}_controller".camelize.constantize
      # This should be lazy
      __resource_class = __controller.resource_class
      __is_audited = Ecm::Audited.audited_models.call.keys.include?(__resource_class)

      # Add routes
      if __is_audited
        Rails.logger.info "Injecting audited routes to #{__resource_class} backend routes"
        router.get  'audit_log',         action: :audit_log, on: :member
        router.post 'revert/:version',   action: :revert,    on: :member
        router.get  'versions/:version', action: :version,   on: :member
      end
    end
  ]
end