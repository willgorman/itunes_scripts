require 'win32ole'
require 'rubygems'
require 'mp3info'
require 'iconv'
require 'id3lib'

itunes = WIN32OLE.new('iTunes.Application')
tracks = itunes.SelectedTracks
tracks.each do |track|

  Mp3Info.open(track.Location) do |mp3info|
    #puts mp3info.tag2["POPM"].unpack("Z*C")

    #AmazonMp3 encodes some tags as iso 8859-1, some as UTF-16
    #mp3info seems to treat them all as 8859 though
    mp3info.tag2.options[:encoding] = "utf-16"
    puts mp3info.tag2.options
    puts mp3info.tag.title
    mp3info.tag.title.each_byte do |byte|
      puts byte
    end

    puts mp3info.tag2.options
    puts mp3info.tag2.version
  end
  
   tag = ID3Lib::Tag.new(track.Location)
   puts tag.title
  #todo - look into using String::unpack to format the data

  #is the counter worth it?
  a = ["will.gorman@gmail.com", 255]
  puts a.pack('Z*Cxxxx')
  
end

#  tag = ID3Lib::Tag.new(track.Location)
#  popm = tag.frame(:POPM)
#  puts popm[:rating]
#  puts popm[:email]