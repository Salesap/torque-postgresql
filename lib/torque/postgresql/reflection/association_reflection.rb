# frozen_string_literal: true

module Torque
  module PostgreSQL
    module Reflection
      module AssociationReflection

        def initialize(name, scope, options, active_record)
          super

          raise ArgumentError, <<-MSG.squish if options[:array] && options[:polymorphic]
            Associations can't be connected through an array at the same time they are
            polymorphic. Please choose one of the options.
          MSG
        end

        private

          # Check if the foreign key should be pluralized
          def derive_foreign_key
            result = super
            result = ActiveSupport::Inflector.pluralize(result) \
              if collection? && connected_through_array?
            result
          end

      end

      ::ActiveRecord::Reflection::AssociationReflection.prepend(AssociationReflection)
    end
  end
end
