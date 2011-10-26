require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'lib/uclassify'

describe "UClassify Classifer Use" do
  it "Should be able to create a classifier name and text" do
    classifier = UClassifyClassifier.new('classifier_name','text')
    document = Nokogiri::XML::Document.new
    classifier.to_xml_node(document).to_xml.should == "<classify id=\"classifier_name_id\" classifierName=\"classifier_name\" textId=\"text_id\"/>"
  end
end
