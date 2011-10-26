class UClassifyQuery
  def initialize (read_api_key)
    @read_api_key = read_api_key
    @texts = Array.new
    @classifiers = Array.new
  end
  
  def add_text (text)
    text = UClassifyText.new(text)
    @texts << text
    self
  end
  
  def add_classifier (classifier_name,text)
    classifier = UClassifyClassifier.new(classifier_name,text)
    @classifiers << classifier 
    self  
  end
  
  def classify_text(classifier_name,text)
    add_classifier(classifier_name,text)
    add_text(text)
  end
  
  
  def get_query_string
    @document = Nokogiri::XML::Document.new("1.0")
    @document.encoding="utf-8"
    @uclassify_root_node =  Nokogiri::XML::Node.new('uclassify',@document)
    @uclassify_root_node['xmlns']="http://api.uclassify.com/1/RequestSchema"
    @uclassify_root_node['version']="1.0.1"
    @document.root=@uclassify_root_node
    generate_texts
    generate_read_calls
    @document.to_xml
  end
  
private
  
  def generate_read_calls
    if @classifiers.size > 0 
      read_node = Nokogiri::XML::Node.new('readCalls',@document)
      read_node['readApiKey']=@read_api_key
      @uclassify_root_node.add_child(read_node)
      @classifiers.each do  |classifier|
        node = classifier.to_xml_node(@document)
        read_node.add_child(node)
      end
    else
      raise 'ERROR: Classifiers not specified. Use add_classifier method to add classifiers to use for this query'
    end
  end
  
  def generate_texts
    #add all the text train calls
     if @texts.size >0 
       main_texts_node = Nokogiri::XML::Node.new('texts',@document)
       @uclassify_root_node.add_child(main_texts_node)
       @texts.each do |text|
         node=text.to_xml_node(@document)
         main_texts_node.add_child(node)
       end
     else
       raise 'ERROR: Texts not specified. Use add_text method to add text(s) to run the classifier on'
     end
  end
end