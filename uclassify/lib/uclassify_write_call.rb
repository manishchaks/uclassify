require File.join(File.dirname(__FILE__), 'uclassify_create_id.rb')
class UClassifyWriteCall
  def initialize (write_api_key,classifier_name)
    @api_key = write_api_key
    @classifier_name = classifier_name
    @createIDs = Array.new
    @classes = Array.new
  end
  
  def add_create_id create_id
    @createIDs << create_id
  end
  
  def add_class my_class
    @classes << my_class
  end
  
  def to_xml_node xml_document
    write_call_node= Nokogiri::XML::Node.new('writeCalls',xml_document)
    write_call_node['writeApiKey'] = @api_key
    write_call_node['classifierName']= @classifier_name
    
    @createIDs.each do |id|
      node = id.to_xml_node(xml_document)
      write_call_node.add_child(node)
    end
    
    @classes.each do |my_class|
      node = my_class.to_xml_node(xml_document)
      write_call_node.add_child(node)
    end  
    write_call_node
  end
  
end