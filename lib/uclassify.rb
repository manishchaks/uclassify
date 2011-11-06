require 'rubygems'
require 'nokogiri'
require File.join(File.dirname(__FILE__), 'uclassify_write_call.rb')
require File.join(File.dirname(__FILE__), 'uclassify_create_id.rb')
require File.join(File.dirname(__FILE__), 'uclassify_class.rb')
require File.join(File.dirname(__FILE__), 'uclassify_text.rb')
require File.join(File.dirname(__FILE__), 'uclassify_training_class.rb')
require File.join(File.dirname(__FILE__), 'uclassify_untraining_class.rb')
require File.join(File.dirname(__FILE__), 'uclassify_classifier.rb')
require File.join(File.dirname(__FILE__), 'uclassify_query.rb')
require File.join(File.dirname(__FILE__), 'uclassify_request.rb')
require File.join(File.dirname(__FILE__), 'uclassify_utils.rb')
class UClassify
  attr_accessor :write_api_key
  attr_accessor :read_api_key
  
  def initialize
    @write_calls = Array.new
    @text_trains = Array.new
  end
   
  def create_classifier(classifier_name)
    check_for_write_key
    @write_api_key = write_api_key
    write_call = UClassifyWriteCall.new(write_api_key,classifier_name)
    id = UClassifyCreateID.new(UClassifyUtils.string_to_id(classifier_name))
    write_call.add_create_id(id)
    @write_calls << write_call
  end
  
  def generate_request_string
    @document = Nokogiri::XML::Document.new("1.0")
    @document.encoding="utf-8"
    @uclassify_root_node =  Nokogiri::XML::Node.new('uclassify',@document)
    @uclassify_root_node['xmlns']="http://api.uclassify.com/1/RequestSchema"
    @uclassify_root_node['version']="1.01"
    @document.root=@uclassify_root_node
    generate_train_texts
    generate_write_calls
    xml_string = @document.to_xml
    xml_string.split.join("\n")
    xml_string   
  end
  
  def fire_request
    request = UClassifyRequest.new
    @last_response = request.fire_request(generate_request_string)
    if is_response_valid?
      puts "SUCCESS!"
    else
      puts "FAILURE"
    end
    puts "Reply from server:"  
    @last_response
  end
  
  def is_response_valid? 
    response_as_hash['uclassify']['status']['success'] == "true"
  end
  
  def response_as_hash
    if @last_response
          @last_response.parsed_response
      else
        raise "No request has been fired yet. Please do a uclassify.fire_request"
      end
  end
  
  def with_classifier_name classifier_name 
    check_for_write_key
    write_call = UClassifyWriteCall.new(@write_api_key,classifier_name)
    @write_calls << write_call
    self
  end
  
  def add_class (class_name)
    new_class = UClassifyClass.new(class_name)
    @write_calls.last.add_class(new_class)
    self
  end 
  
  def train_class_with_text (class_name,text)
    train_id = UClassifyUtils.string_to_id(class_name)
    text_id = UClassifyUtils.string_to_id(text)
    add_training_class(train_id,class_name,text_id)
    train_text(text)
  end
  
  def untrain_class_with_text(class_name,text)
    train_id = UClassifyUtils.string_to_id(class_name)
    text_id = UClassifyUtils.string_to_id(text)
    untrain_class(train_id,class_name,text_id)
    train_text(text)
    
  end
  
private

  def add_training_class (train_id,class_name,text_id)
    training_class = UClassifyTrainClass.new(train_id,class_name,text_id)
    @write_calls.last.add_training_class(training_class)  
    self
  end
  
  def untrain_class(train_id,class_name,text_id)
    untraining_class = UClassifyUnTrainClass.new(train_id,class_name,text_id)
    @write_calls.last.add_training_class(untraining_class)
  end

  def train_text(text)
    text = UClassifyText.new(text)
    @text_trains << text
    self
  end
  
  def generate_train_texts
    #add all the text train calls
     if @text_trains.size >0 
       main_texts_node = Nokogiri::XML::Node.new('texts',@document)
       @uclassify_root_node.add_child(main_texts_node)
       @text_trains.each do |text_train|
         node=text_train.to_xml_node(@document)
         main_texts_node.add_child(node)
       end
     end
  end
  
  def generate_write_calls 
    #add all the write calls
    if @write_calls.size > 0
      @write_calls.each do |write_call|
        node=write_call.to_xml_node(@document)
        @uclassify_root_node.add_child(node)
      end
    end
  end
  
  def check_for_write_key
    if (!@write_api_key) 
      raise "No Write API Key for UClassify. Please specify one with 'uclassify.write_api_key=YOUR_KEY'"
    end
  end
end