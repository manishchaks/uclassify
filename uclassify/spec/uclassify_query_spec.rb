require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'lib/uclassify'

describe "UClassify Query" do
  it "Should use the classifier to figure out if the " do
    document = Nokogiri::XML::Document.new
    query = UClassifyQuery.new('DUMMY_READ_KEY')
    query.add_classifier('classifier_id','classifier_name','text_id').add_text ('text_id','text')
    expected_string ="<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<uclassify xmlns=\"http://api.uclassify.com/1/RequestSchema\" version=\"1.0.1\">\n  <texts>\n    <textBase64 id=\"text_id\">dGV4dA==</textBase64>\n  </texts>\n  <readCalls readApiKey=\"DUMMY_READ_KEY\">\n    <classify id=\"classifier_id\" classifierName=\"classifier_name\" textId=\"text_id\"/>\n  </readCalls>\n</uclassify>\n"
    xml_cmp(query.get_query_string,expected_string).should == true  
  end
end
