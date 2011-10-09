require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'lib/uclassify'

describe "UClassify Train Class" do
  it "Should be able to create a training class given and ID, Name and Text" do
    train_class = UClassifyTrainClass.new("DUMMY_ID","DUMMY_CLASS_NAME", "DUMMY_TEXT_ID")
    document = Nokogiri::XML::Document.new
    train_class.to_xml_node(document).to_xml.should == "<train id=\"DUMMY_ID\" className=\"DUMMY_CLASS_NAME\" textId=\"DUMMY_TEXT_ID\"/>"
  end
end
