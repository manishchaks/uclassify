require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'lib/uclassify'

describe "UClassify Utils" do
  it "Should take a string and convert it into a valid UClassify ID" do
    UClassifyUtils.string_to_id('Hello how are you').should == 'hello_how_are_you_id'
  end
end
