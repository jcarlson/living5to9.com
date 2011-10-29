module DecoratedResource
  extend ActiveSupport::Concern

  module InstanceMethods
    
    def decorator
      @decorator ||= begin
        Module.const_get "#{active_admin_config.resource}Decorator"
      rescue NameError
        nil
      end
    end
    
    def active_admin_collection
      decorator.nil? ? super : decorator.decorate(super)
    end
    
    def resource
      decorator.nil? ? super : decorator.new(super)
    end
    
  end
  
end

module ActiveAdmin
  class ResourceController < ::InheritedResources::Base
    include DecoratedResource
  end
end