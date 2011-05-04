require 'win32ole'
require 'rubygems'
require 'id3lib'
require 'nokogiri'
require 'builder'
require 'cgi'


#find mp3 tracks with no rating
#ok, it looks like there isn't a good way to find tracks with no rating
#(other than spinning through the whole library) so i'll just make it for
#selectedtracks for now

winamp = WIN32OLE.new('ActiveWinamp.Application')

#look up each in the
file = File.new("medialibrary.xml")
parser = Nokogiri::XML(file)

#unscaped_str = CGI.unescapeHTML(File.read('medialibrary.xml'))
#parser = Nokogiri::XML(unscaped_str)

tracks = winamp.playlist

tracks.each do |track|
  
  #first, try file name
  filename = track.Filename
  #todo: need to escape filename
  xm = Builder::XmlMarkup.new
  filename = xm.text! filename
  puts filename
  query = '//songs/song[filename="'+filename+'"]'
  puts query
  nodes = parser.root.xpath(query)
  puts nodes
  #need to handle multiple matches differently from no matches
  if (nodes.length == 1)
    puts (nodes.first.xpath('./rating').first.content).to_i
    track.Rating = (nodes.first.xpath('./rating').first.content).to_i
  end
  
  #todo: check if it's an mp3 and add the rating to the tag
  
end
