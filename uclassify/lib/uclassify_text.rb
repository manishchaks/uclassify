require "Base64"
class UClassifyText
  def initialize(text_id,text)
    @text_id = text_id
    @text = text
  end
  
  def to_xml_node xml_document
    text_base64_node = Nokogiri::XML::Node.new('textBase64',xml_document)
    text_base64_node['id'] = @text_id.to_s
    encoded_string = Base64.encode64(@text)   
    
    # Nokogiri doesnt give me an easy way to add a text node
    frag = text_base64_node.parse(encoded_string.strip)
    text_base64_node.add_child(frag)
    text_base64_node   
  end
end