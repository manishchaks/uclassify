require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'lib/uclassify'

describe "UClassify Create ID" do
  it "Should be able to a create a classifier" do
    
    # This test is to unit-test UClassify create ID creation. This class is not meant to be used by the end-user"
    create_id = UClassifyCreateID.new('DUMMY_CREATE_ID')
    document = Nokogiri::XML::Document.new
    
    expected_string =  "<create id=\"DUMMY_CREATE_ID\"/>"
    xml_cmp(create_id.to_xml_node(document).to_xml, expected_string).should == true
  end
end
