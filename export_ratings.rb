require 'win32ole'
require 'Builder'


#This isn't too bad but there are still a few issues to address:
# - character escaping.  & is becoming &amp; etc. On the other hand, as long as the parser
#   I use converts them back, no big deal.
# - consider case sensitivity issues (really probably more on the import side)
# - sort by artist?
# - the biggest concern might be differences between winamp titles vs itunes titles vs
#   id3 tag titles.  Adding filename to help provide more ways to identify

winamp = WIN32OLE.new("ActiveWinamp.Application");

medialibrary = winamp.MediaLibrary

file = File.new("medialibrary.xml", "w+")
builder = Builder::XmlMarkup.new(:target=>file, :indent=>2, :margin=>1)

file << "<songs>\n"
medialibrary.each do |item|
	builder.song{|t| t.artist(item.Artist); t.album(item.Album); t.track(item.Track); 
				t.title(item.Title); t.rating(item.Rating); t.filename(item.Filename)}
end

file << "</songs>"

