require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'lib/uclassify'

describe "UClassify base" do
  it "Should be able to a create a classifier" do
    uclassify = UClassify.new
    uclassify.create_classifier('DUMMY_API_KEY','DUMMY_CLASSIFIER_NAME','DUMMY_CLASSIFIER_ID')
    
    
    expected_string ="<?xml version=\"1.0\" encoding=\"utf-8\"?>
    <uclassify xmlns=\"http://api.uclassify.com/1/RequestSchema\" version=\"1.0.1\"><writeCalls writeApiKey=\"DUMMY_API_KEY\" classifierName=\"DUMMY_CLASSIFIER_NAME\"><create id=\"DUMMY_CLASSIFIER_ID\"/></writeCalls></uclassify>"
    
    xml_cmp(uclassify.generate_request_string,expected_string).should == true
  end
end
