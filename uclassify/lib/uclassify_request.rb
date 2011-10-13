require 'rubygems'
require 'httparty'
class UClassifyRequest
  include HTTParty
  format :xml
  base_uri 'http://api.uclassify.com'
  headers 'Content-Type' => 'text/xml' 
  
  def fire_request(string)
    self.class.post('',:body=>string)
  end

end