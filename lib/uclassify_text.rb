require "Base64"
class UClassifyText
  def initialize(text)
    @text = text
  end
  
  def to_xml_node xml_document
    text_base64_node = Nokogiri::XML::Node.new('textBase64',xml_document)
    text_base64_node['id'] = UClassifyUtils.string_to_id(@text)
    encoded_string = Base64.encode64(@text)   
    
    frag = text_base64_node.parse(encoded_string.strip)
    text_base64_node.add_child(frag)
    text_base64_node   
  end
end