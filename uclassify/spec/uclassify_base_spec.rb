require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'lib/uclassify'

describe "UClassify base" do
  it "Should be able to a create a classifier" do
    uclassify = UClassify.new
    uclassify.create_classifier('DUMMY_API_KEY','classifierName','classifierID')
    # uclassify.create_response_XML
  end
end
