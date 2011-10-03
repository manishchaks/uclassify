require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'lib/uclassify'

describe "UClassify base" do
  it "Should be able to a create a classifier" do
    uclassify = UClassify.new
    uclassify.write_api_key = 'DUMMY_API_KEY'
    uclassify.create_classifier('DUMMY_CLASSIFIER_NAME','DUMMY_CLASSIFIER_ID')
    
    
    expected_string ="<?xml version=\"1.0\" encoding=\"utf-8\"?>
    <uclassify xmlns=\"http://api.uclassify.com/1/RequestSchema\" version=\"1.0.1\"><writeCalls writeApiKey=\"DUMMY_API_KEY\" classifierName=\"DUMMY_CLASSIFIER_NAME\"><create id=\"DUMMY_CLASSIFIER_ID\"/></writeCalls></uclassify>"
    
    xml_cmp(uclassify.generate_request_string,expected_string).should == true
  end
  
  it "should not allow classifier creation and raise an exception when write api key has not been specified" do
    begin
      uclassify = UClassify.new
      uclassify.create_classifier('DUMMY_CLASSIFIER_NAME','DUMMY_CLASSIFIER_ID')
    rescue Exception => e
      e.to_s.should == "No Write API Key for UClassify. Please specify one with 'uclassify.write_api_key=YOUR_KEY'"
    end

  end
  
end
