require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'lib/uclassify'

describe "UClassify Create Class" do
  it "Should be able to create a simple class" do
    
    # This test is to unit-test UClassify create ID creation. This class is not meant to be used by the end-user"
    create_class = UClassifyClass.new("DUMMY_CLASS")
    document = Nokogiri::XML::Document.new
    
    expected_string =  "<create id=\"DUMMY_CREATE_ID\"/>"
    # xml_cmp(create_class.to_xml_node(document).to_xml, expected_string).should == true
   create_class.to_xml_node(document).to_xml.should =="<addClass id=\"dummy_class_id\" className=\"DUMMY_CLASS\"/>"
  end
end
