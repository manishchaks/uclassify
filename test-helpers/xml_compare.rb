require 'rubygems'
require 'rexml/document'

# A simple method to compare two XML files - regardless of whitepsace and carriage returns
 def xml_cmp a, b
   a = REXML::Document.new(a.to_s)
   b = REXML::Document.new(b.to_s)

   normalized = Class.new(REXML::Formatters::Pretty) do
     def write_text(node, output)
       super(node.to_s.strip, output)
     end
   end

   normalized.new(indentation=0,ie_hack=false).write(node=a, a_normalized='')
   normalized.new(indentation=0,ie_hack=false).write(node=b, b_normalized='')

   a_normalized == b_normalized
 end