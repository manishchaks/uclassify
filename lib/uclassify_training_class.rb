class UClassifyTrainClass
  def initialize(train_id,class_name,text_id) 
    @train_id = train_id
    @class_name = class_name
    @text_id = text_id
  end
  
  def to_xml_node xml_document
    class_node = Nokogiri::XML::Node.new('train',xml_document)
    class_node['id']=@train_id
    class_node['className']=@class_name
    class_node['textId']=@text_id
    class_node    
  end
end