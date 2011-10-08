require 'rubygems'
require 'nokogiri'
require File.join(File.dirname(__FILE__), 'uclassify_write_call.rb')
require File.join(File.dirname(__FILE__), 'uclassify_create_id.rb')
require File.join(File.dirname(__FILE__), 'uclassify_class.rb')
require File.join(File.dirname(__FILE__), 'uclassify_text.rb')
class UClassify
  attr_accessor :write_api_key
  attr_accessor :read_api_key
  
  def initialize
    @write_calls = Array.new
  end
   
  def create_classifier(classifier_name,create_id)
    check_for_write_key
    @write_api_key = write_api_key
    write_call = UClassifyWriteCall.new(write_api_key,classifier_name)
    id = UClassifyCreateID.new(create_id)
    write_call.add_create_id(id)
    @write_calls << write_call
  end
  
  def generate_request_string
    document = Nokogiri::XML::Document.new("1.0")
    document.encoding="utf-8"
    uclassify_root_node =  Nokogiri::XML::Node.new('uclassify',document)
    uclassify_root_node['xmlns']="http://api.uclassify.com/1/RequestSchema"
    uclassify_root_node['version']="1.0.1"
    document.root=uclassify_root_node
    
    #add all the write calls
    @write_calls.each do |write_call|
      node=write_call.to_xml_node(document)
      uclassify_root_node.add_child(node)
    end
    document.to_xml
  end
  
  def with_classifier_name classifier_name 
    check_for_write_key
    write_call = UClassifyWriteCall.new(@write_api_key,classifier_name)
    @write_calls << write_call
    self
  end
  
  def add_class (class_id, class_name)
    new_class = UClassifyClass.new(class_id,class_name)
    @write_calls.last.add_class(new_class)
    self
  end 
  
  def check_for_write_key
    if (!@write_api_key) 
      raise "No Write API Key for UClassify. Please specify one with 'uclassify.write_api_key=YOUR_KEY'"
    end
  end
end