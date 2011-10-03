class UClassifyClass
  def initialize(class_id,class_name) 
    @class_id=class_id
    @class_name=class_name
  end
  
  def to_xml_node xml_document
    class_node = Nokogiri::XML::Node.new('addClass',xml_document)
    class_node['id']=@class_id
    class_node['className']=@class_name
    class_node    
  end
end