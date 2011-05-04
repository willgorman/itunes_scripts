require 'win32ole'
require 'rubygems'
#require 'id3lib'
require 'nokogiri'
require 'builder'
require 'cgi'


#find mp3 tracks with no rating
#ok, it looks like there isn't a good way to find tracks with no rating
#(other than spinning through the whole library) so i'll just make it for
#selectedtracks for now

itunes = WIN32OLE.new('iTunes.Application')

#look up each in the
file = File.new("medialibrary.xml")
parser = Nokogiri::XML(file)


tracks = itunes.SelectedTracks
tracks.each do |track|
	 tag = WIN32OLE.new('ID3Com.ID3ComTag')
	tag.link track.location
	tag.setproperty('Popularity', 'will.gorman@gmail.com', track.Rating/20*51)
	tag.SaveV2Tag  

  
end
