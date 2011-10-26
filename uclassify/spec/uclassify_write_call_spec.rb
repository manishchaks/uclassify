require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'lib/uclassify'

describe "UClassify Create Call" do
  it "Should be able to create a classifier with a given name and createID" do
    write_call = UClassifyWriteCall.new("DUMMY_WRITE_API_KEY","DUMMY_CLASSIFIER_ID")
    
    # add a create operation to the write call
    create_id = UClassifyCreateID.new('DUMMY_CREATE_ID')
    write_call.add_create_id(create_id)
    
    document = Nokogiri::XML::Document.new
    expected_string=  "<writeCalls writeApiKey=\"DUMMY_WRITE_API_KEY\" classifierName=\"DUMMY_CLASSIFIER_ID\"><create id=\"DUMMY_CREATE_ID\"/></writeCalls>"
      
    xml_cmp(write_call.to_xml_node(document).to_xml , expected_string).should == true
  end
end
