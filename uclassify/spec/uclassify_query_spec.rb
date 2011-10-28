require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'lib/uclassify'

describe "UClassify Query" do
  it "Should be able to add classifier to a query" do
    document = Nokogiri::XML::Document.new
    query = UClassifyQuery.new('DUMMY_READ_KEY')
    query.classify_text('classifier_name','text')
    expected_string ="<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<uclassify xmlns=\"http://api.uclassify.com/1/RequestSchema\" version=\"1.0.1\">\n  <texts>\n    <textBase64 id=\"1cb251ec0d568de6a929b520c4aed8d1\">dGV4dA==</textBase64>\n  </texts>\n  <readCalls readApiKey=\"DUMMY_READ_KEY\">\n    <classify id=\"7fd9109348061ba2dc36223395ae0760\" classifierName=\"classifier_name\" textId=\"1cb251ec0d568de6a929b520c4aed8d1\"/>\n  </readCalls>\n</uclassify>\n"
    xml_cmp(query.get_query_string,expected_string).should == true  
  end

end
