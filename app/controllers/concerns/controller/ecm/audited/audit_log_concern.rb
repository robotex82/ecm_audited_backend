module Controller
  module Ecm::Audited
    module AuditLogConcern
      extend ActiveSupport::Concern

      def audit_log
        @resource = load_resource
      end

      def revert
        @resource = load_resource
        @target_version = @resource.revision(params[:version])
        if @target_version.save
          redirect_to resource_path(@target_version), notice: t('.success')
        else
          redirect_to resource_path(@target_version), notice: t('.failure')
        end
      end

      def version
        @resource = load_resource.revision(params[:version])
        render :show
      end
    end
  end
end