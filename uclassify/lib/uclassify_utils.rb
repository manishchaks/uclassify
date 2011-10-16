class UClassifyUtils
  def self.string_to_id string
    string = string + " id"
    string.gsub!(' ','_')
    string.downcase!
    string
  end
end