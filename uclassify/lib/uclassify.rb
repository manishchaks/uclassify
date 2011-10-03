require File.join(File.dirname(__FILE__), 'uclassify_write_call.rb')
require File.join(File.dirname(__FILE__), 'uclassify_create_id.rb')
class UClassify
  def initialize
    puts "UClassify initialized"
    @write_calls = []
  end
  
  def create_classifier(api_key,classifier_name,create_id)
    write_call = UClassifyWriteCall.new(api_key,classifier_name)
    write_call.add_create_id(create_id)
    @write_calls << write_call
  end
  
end