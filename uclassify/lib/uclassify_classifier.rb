class UClassifyClassifier
  def initialize (classifier_name,text)
    @classifier_name = classifier_name
    @text = text
  end
  
  def to_xml_node xml_document
    # <classify id="Classify" classifierName="ManOrWoman" textId="ManOrWomanText"/>
    classifier_node = Nokogiri::XML::Node.new('classify',xml_document)
    classifier_node['id'] = UClassifyUtils.string_to_id(@classifier_name)
    classifier_node['classifierName'] = @classifier_name
    classifier_node['textId'] = UClassifyUtils.string_to_id(@text)
    classifier_node
  end
end