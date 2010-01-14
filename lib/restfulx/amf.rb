$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$:.unshift "#{File.expand_path(File.dirname(__FILE__))}/amf/"

require 'amf/class_mapping'

module RestfulX::AMF
  begin
    raise LoadError, 'C extentions not implemented'
  rescue LoadError
    require 'amf/pure'
  end
  
  ClassMapper = RestfulX::AMF::ClassMapping.new
  
  class << self
    # Serialize the given Ruby data structure _obj_ into an AMF stream
    def serialize(obj, options = {}, &block)
      RestfulX::AMF::AMF3Serializer.new(options).serialize(obj, &block)
    end
  end
  
  # The base exception for AMF errors.
  class AMFError < StandardError; end
end