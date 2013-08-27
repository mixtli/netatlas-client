module NetAtlas
  module Resource
    class Base 
      include Her::Model
      uses_api(NetAtlas::API)
      include_root_in_json true
      parse_root_in_json true
      def self.schema
        @schema
      end

      def self.schema=(schema)
        @schema = schema
      end

    end
  end
end
