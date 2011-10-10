require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'lib/uclassify'

describe "UClassify base" do
  it "Should be able to a create a classifier" do
    uclassify = UClassify.new
    uclassify.write_api_key = 'DUMMY_API_KEY'
    uclassify.create_classifier('DUMMY_CLASSIFIER_NAME','DUMMY_CLASSIFIER_ID')
    expected_string = %Q{
      <?xml version="1.0" encoding="utf-8"?>
    <uclassify xmlns="http://api.uclassify.com/1/RequestSchema" version="1.0.1">
      <writeCalls writeApiKey="DUMMY_API_KEY" classifierName="DUMMY_CLASSIFIER_NAME">
        <create id="DUMMY_CLASSIFIER_ID"/>
      </writeCalls>
    </uclassify>
    }    
    xml_cmp(uclassify.generate_request_string,expected_string).should == true
  end
  
  it "should not allow classifier creation and raise an exception when write api key has not been specified" do
    begin
      uclassify = UClassify.new
      uclassify.create_classifier('DUMMY_CLASSIFIER_NAME','DUMMY_CLASSIFIER_ID')
    rescue Exception => e
      e.to_s.should == "No Write API Key for UClassify. Please specify one with 'uclassify.write_api_key=YOUR_KEY'"
    end
  end
  
  it "should allow classes to be added to a classifier" do
    uclassify = UClassify.new
    uclassify.write_api_key = 'DUMMY_API_KEY'
    uclassify.with_classifier_name("DUMMY_CLASSIFIER_ID").add_class('Class_ID_1',"Class_Name_1").add_class("Class_ID2","Class_name2")
    
    expected_string = %Q{
      <?xml version="1.0" encoding="utf-8"?>
    <uclassify xmlns="http://api.uclassify.com/1/RequestSchema" version="1.0.1">
      <writeCalls writeApiKey="DUMMY_API_KEY" classifierName="DUMMY_CLASSIFIER_ID">
        <addClass id="Class_ID_1" className="Class_Name_1"/>
        <addClass id="Class_ID2" className="Class_name2"/>
      </writeCalls>
    </uclassify>
    }
   xml_cmp(uclassify.generate_request_string,expected_string).should==true
  end
  
  it "should be possible to train classes with texts " do
    uclassify = UClassify.new
    uclassify.write_api_key = 'DUMMY_API_KEY'
    uclassify.with_classifier_name("DUMMY_CLASSIFIER_ID").train_text("TextID1","SomeTextOne").train_text("TextID2","SomeTextTwo")
    uclassify.add_training_class("ID1","ClassName1","TextID1").add_training_class("ID2","ClassName2","TextID2")

    expected_string = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<uclassify xmlns=\"http://api.uclassify.com/1/RequestSchema\" version=\"1.0.1\">\n  <texts>\n    <textBase64 id=\"TextID1\">U29tZVRleHRPbmU=</textBase64>\n    <textBase64 id=\"TextID2\">U29tZVRleHRUd28=</textBase64>\n  </texts>\n  <writeCalls writeApiKey=\"DUMMY_API_KEY\" classifierName=\"DUMMY_CLASSIFIER_ID\"/>\n  <train id=\"ID1\" className=\"ClassName1\" textId=\"TextID1\"/>\n  <train id=\"ID2\" className=\"ClassName2\" textId=\"TextID2\"/>\n</uclassify>\n"  

    xml_cmp(uclassify.generate_request_string,expected_string).should==true       
  end
end
