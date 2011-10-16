class UClassifyClassifier
  def initialize (classifier_name,text_id)
    @classifier_name = classifier_name
    @text_id = text_id
  end
  
  def to_xml_node xml_document
    # <classify id="Classify" classifierName="ManOrWoman" textId="ManOrWomanText"/>
    classifier_node = Nokogiri::XML::Node.new('classify',xml_document)
    classifier_node['id'] = UClassifyUtils.string_to_id(@classifier_name)
    classifier_node['classifierName'] = @classifier_name
    classifier_node['textId'] = @text_id
    classifier_node
  end
end