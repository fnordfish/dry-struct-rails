module Dry
  class Struct
    module Rails
      module StructRegistration
        REGISTERED_STRUCTS = Concurrent::Array.new

        def attributes(new_schema)
          unless StructRegistration::REGISTERED_STRUCTS.include?(self)
            # Check to see if we need to remove the registered type
            autoloaded = ActiveSupport::Dependencies.will_unload?(self)
            # ActiveSupport::Dependencies.will_unload?(klass) won't return true yet
            #   if it's the first time a constant is being autoloaded
            #   so we have to see if we're in the middle of loading a missing constants
            autoloaded |= caller.any? { |line| line =~ /\:in.*?new_constants_in/ }

            StructRegistration::REGISTERED_STRUCTS << self if autoloaded
          end
          super
        end
      end

      Dry::Struct.module_eval do
        class << self
          prepend(StructRegistration)
        end
      end

      class Railtie < ::Rails::Railtie
        initializer "dry-struct-rails.configure_rails_initialization" do
          ActiveSupport::Reloader.before_class_unload do
            structs = StructRegistration::REGISTERED_STRUCTS.dup
            structs.each do |struct|
              StructRegistration::REGISTERED_STRUCTS.delete(struct)

              struct.schema({})
              struct.remove_instance_variable(:@attribute_names) if struct.instance_variable_defined?(:@attribute_names)
              struct.equalizer.instance_variable_get(:@keys).clear
            end
          end
        end
      end
    end
  end
end
