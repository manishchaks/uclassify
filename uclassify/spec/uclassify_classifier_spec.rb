require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'lib/uclassify'

describe "UClassify Classifer Use" do
  it "Should be able to create a classifier name and text" do
    classifier = UClassifyClassifier.new('classifier_name','text')
    document = Nokogiri::XML::Document.new
    classifier.to_xml_node(document).to_xml.should == "<classify id=\"7fd9109348061ba2dc36223395ae0760\" classifierName=\"classifier_name\" textId=\"1cb251ec0d568de6a929b520c4aed8d1\"/>"
  end
end
