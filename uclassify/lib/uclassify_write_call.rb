require File.join(File.dirname(__FILE__), 'uclassify_create_id.rb')
class UClassifyWriteCall
  def initialize (write_api_key,classifier_id)
    @api_key = write_api_key
    @classifier_id = classifier_id
    @createIDs = Array.new
  end
  
  def add_create_id create_id
    create_id = UClassifyCreateID.new(create_id)
    @createIDs << create_id
  end
  
end