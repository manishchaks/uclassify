require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'lib/uclassify'

describe "UClassify Create Call" do
  it "Should be able to create a classifier with a given name and createID" do
    
    # This test is to unit-test UClassify classifer creation with write call. This class is not meant to be used by the end-user"
    
    # create a simple write call
    write_call = UClassifyWriteCall.new("DUMMY_WRITE_API_KEY","DUMMY_CLASSIFIER_ID")
    
    # add a create operation to the write call
    create_id = UClassifyCreateID.new('DUMMY_CREATE_ID')
    write_call.add_create_id(create_id)
    
    # create and XML document - (required for testing puposes)
    document = Nokogiri::XML::Document.new
    
    # Check if the write call is correctly formed  
    expected_string=  "<writeCalls writeApiKey=\"DUMMY_WRITE_API_KEY\" classifierName=\"DUMMY_CLASSIFIER_ID\"><create id=\"DUMMY_CREATE_ID\"/></writeCalls>"
    
    xml_cmp(write_call.to_xml_node(document).to_xml , expected_string).should == true
  end
end
