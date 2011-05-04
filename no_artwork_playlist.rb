require 'win32ole'
require 'rubygems'
require 'id3lib'

itApp = WIN32OLE.new('iTunes.Application')
itLibSrc = itApp.LibrarySource
playlists = itLibSrc.Playlists
lrp = nil
playlists.each do |playlist|
  if playlist.Name == "No Album Art"
    lrp = playlist
    break
  end
end

if (lrp == nil)
  lrp = itApp.CreatePlaylistInSource("No Album Art", itApp.LibrarySource)
end

tracks = itApp.SelectedTracks
tracks.each do |track|
  tag = ID3Lib::Tag.new(track.Location)
  picframes = tag.select{|frame| frame[:id] == :APIC}
  
  if picframes.size == 0
    lrp.AddTrack(track)
  end     
end
