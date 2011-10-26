require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'lib/uclassify'

describe "UClassify base" do
  it "Should be able to a create a classifier" do
    uclassify = UClassify.new
    uclassify.write_api_key = 'DUMMY_API_KEY'
    uclassify.create_classifier('DUMMY_CLASSIFIER')
    expected_string = %Q{
      <?xml version="1.0" encoding="utf-8"?>
    <uclassify xmlns="http://api.uclassify.com/1/RequestSchema" version="1.01">
      <writeCalls writeApiKey="DUMMY_API_KEY" classifierName="DUMMY_CLASSIFIER">
        <create id="dummy_classifier_id"/>
      </writeCalls>
    </uclassify>
    }   
    xml_cmp(uclassify.generate_request_string,expected_string).should == true
  end
  
  it "should not allow classifier creation and raise an exception when write api key has not been specified" do
    begin
      uclassify = UClassify.new
      uclassify.create_classifier('DUMMY_CLASSIFIER')
    rescue Exception => e
      e.to_s.should == "No Write API Key for UClassify. Please specify one with 'uclassify.write_api_key=YOUR_KEY'"
    end
  end
  
  it "should allow classes to be added to a classifier" do
    uclassify = UClassify.new
    uclassify.write_api_key = 'DUMMY_API_KEY'
    uclassify.with_classifier_name("DUMMY_CLASSIFIER_ID").add_class("Class_Name_1").add_class("Class_Name_2")
    
    expected_string = %Q{
      <?xml version="1.0" encoding="utf-8"?>
    <uclassify xmlns="http://api.uclassify.com/1/RequestSchema" version="1.01">
      <writeCalls writeApiKey="DUMMY_API_KEY" classifierName="DUMMY_CLASSIFIER_ID">
        <addClass id="class_name_1_id" className="Class_Name_1"/>
        <addClass id="class_name_2_id" className="Class_Name_2"/>
      </writeCalls>
    </uclassify>
    }
   xml_cmp(uclassify.generate_request_string,expected_string).should==true
  end
  
  it "should be possible to train classes with texts " do
    uclassify = UClassify.new
    uclassify.write_api_key = 'DUMMY_API_KEY'
 uclassify.with_classifier_name("DUMMY_CLASSIFIER").train_class_with_text("ClassOne","SomeTextOne").train_class_with_text("ClassTwo","SomeTextTwo")

    expected_string = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
    <uclassify xmlns=\"http://api.uclassify.com/1/RequestSchema\" version=\"1.01\">
      <texts>
        <textBase64 id=\"sometextone_id\">U29tZVRleHRPbmU=</textBase64>
        <textBase64 id=\"sometexttwo_id\">U29tZVRleHRUd28=</textBase64>
      </texts>
      <writeCalls writeApiKey=\"DUMMY_API_KEY\" classifierName=\"DUMMY_CLASSIFIER\">
      <train id=\"classone_id\" className=\"ClassOne\" textId=\"sometextone_id\"/>
      <train id=\"classtwo_id\" className=\"ClassTwo\" textId=\"sometexttwo_id\"/>
      </writeCalls>
    </uclassify>"  
    xml_cmp(uclassify.generate_request_string,expected_string).should==true         
  end
end
