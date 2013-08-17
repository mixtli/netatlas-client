module NetAtlas::Renderer
  class Table
    include CommandLineReporter

    def initialize(data, *args)
      @data = data
      @headers = args.map do |arg|
        if arg.kind_of?(Hash)
          arg[:label] ||= arg[:field].to_s
          arg
        else
          {:field => arg, :label => arg.to_s}
        end
      end
    end

    def render
      suppress_output
      if @data.kind_of?(Array)
        render_array
      else
        render_resource
      end
      return capture_output
    end

    def render_resource
      puts "in render_resource"
      @headers = @data.attributes.keys.map {|k| {:field => k, :label => k.to_s}} if @headers.empty?
      table(:border => true) do
        @headers.each do |h|
          row do
            column h[:label], :width => @headers.map {|f| f[:label].size }.max
            column @data.attributes[h[:field]], :width => 40
          end
        end
      end
    end
    def render_array
      puts "in render array"
      table(:border => true ) do
        row :header => true do
          @headers.each do |h|
            h[:width] ||= 80 / @headers.size
            column h[:label], h.slice(:width, :padding, :align, :bold, :underline, :reversed)
          end
        end
        @data.each do |record|
          row do
            @headers.each do |h|
              column record[h[:field]]
            end
          end
        end
      end
    end
  end
end
