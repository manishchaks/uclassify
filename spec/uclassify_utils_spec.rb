require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'lib/uclassify'

describe "UClassify Utils" do
  it "Should take a string and convert it into a valid UClassify ID" do
    UClassifyUtils.string_to_id('Hello how are you').should == '512a1a7503426d5400b1d51011540279'
  end
end
