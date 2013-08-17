module NetAtlas
  module Resource
    class Base 
      #include Her::Model
      #uses_api(NetAtlas::API)

      def self.schema
        @schema
      end

      def self.schema=(schema)
        @schema = schema
      end

      # We do this garbage due to an inheritance bug in her.
      # Hopefully it will be resolved soon
      def self.inherited(base)
        base.send(:include, Her::Model)
        base.send(:include, InstanceMethods)
        base.send(:uses_api, NetAtlas::API)
        base.send(:include_root_in_json, true)
        base.send(:parse_root_in_json, true)
      end
      module InstanceMethods
        def error?
          self.errors.any?
        end
      end
    end
  end
end
