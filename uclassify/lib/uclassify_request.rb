require 'rubygems'
require 'httparty'
class UClassifyRequest
  include HTTParty
  format :xml
  base_uri 'http://api.uclassify.com'
  
  def self.fire_request(string)
  end

end