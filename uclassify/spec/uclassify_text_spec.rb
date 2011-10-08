require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'lib/uclassify'

describe "UClassify Train text" do
  it "should be able to create a simple train text" do\
    train_text = UClassifyText.new("DUMMY_ID","DUMMY_TEXT")
    document = Nokogiri::XML::Document.new
    expected_xml = "<textBase64 id=\"DUMMY_ID\">RFVNTVlfVEVYVA==</textBase64>"
    xml_cmp(train_text.to_xml_node(document).to_xml,expected_xml).should == true
  end

end
