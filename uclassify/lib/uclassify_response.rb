require File.join(File.dirname(__FILE__), 'uclassify_create_id.rb')
class UClassifyResponse < HTTParty::Response
  def initialize ( uclassify_response)
    @uclassify_response = uclassify_response
  end
  
  def is_valid?
    @uclassify_response.parsed_response['uclassify']['status']['success'] == "true"
  end
  
  def response_as_hash
    @uclassify.parsed_response
  end
  
end