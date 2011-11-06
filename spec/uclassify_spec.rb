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
        <create id="5d32967361454d354c26dde8fab3ce28"/>
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
        <addClass id="451685f25480447daf6f6d7b0a5df79d" className="Class_Name_1"/>
        <addClass id="e0d6cc5b323e77cf61428f3bfc0ef894" className="Class_Name_2"/>
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
        <textBase64 id=\"a9aea8382b0cfabd38baaa7ae6e66937\">U29tZVRleHRPbmU=</textBase64>
        <textBase64 id=\"30baefbb457d5a23b95b184c8f05eb8d\">U29tZVRleHRUd28=</textBase64>
      </texts>
      <writeCalls writeApiKey=\"DUMMY_API_KEY\" classifierName=\"DUMMY_CLASSIFIER\">
      <train id=\"7f2e5c9c34e90179ea539c7f7bc1cc1a\" className=\"ClassOne\" textId=\"a9aea8382b0cfabd38baaa7ae6e66937\"/>
      <train id=\"7911cc8cbb85a37c063049a9c7336acd\" className=\"ClassTwo\" textId=\"30baefbb457d5a23b95b184c8f05eb8d\"/>
      </writeCalls>
    </uclassify>" 

    xml_cmp(uclassify.generate_request_string,expected_string).should==true         
  end
  
  it "should be possible to untrain classifiers on texts" do 
    uclassify = UClassify.new
    uclassify.write_api_key = "Dummy API Key "
    uclassify.with_classifier_name("DUMMY Classifier").untrain_class_with_text("ClassOne","SomeTextOne")
    expected_string = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<uclassify xmlns=\"http://api.uclassify.com/1/RequestSchema\" version=\"1.01\">\n  <texts>\n    <textBase64 id=\"a9aea8382b0cfabd38baaa7ae6e66937\">U29tZVRleHRPbmU=</textBase64>\n  </texts>\n  <writeCalls writeApiKey=\"Dummy API Key \" classifierName=\"DUMMY Classifier\">\n    <untrain id=\"7f2e5c9c34e90179ea539c7f7bc1cc1a\" className=\"ClassOne\" textId=\"a9aea8382b0cfabd38baaa7ae6e66937\"/>\n  </writeCalls>\n</uclassify>\n"
    xml_cmp(uclassify.generate_request_string,expected_string).should == true
  end
end
