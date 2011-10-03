require 'rubygems'
require 'nokogiri'
class UClassifyCreateID
  def initialize (createid)
    @create_id = createid
  end
  
  def to_xml_node xml_document
    # this should create something like
    #  <create id="ID"/>
    create_id_node = Nokogiri::XML::Node.new('create',xml_document)
    create_id_node['id'] = @create_id
    create_id_node
  end
  
end