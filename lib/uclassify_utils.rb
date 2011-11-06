require 'MD5'
class UClassifyUtils
  def self.string_to_id string
    MD5.hexdigest(string)
  end
end