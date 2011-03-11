
class Kanji
# This class represents the on-disk Kanji and gives easy access
# to the different versions of the xml and svg code.
# It assumes that all SVG files are in #{repo}/SVG and have equi-
# valent XML files in #{repo}/XML
#
  attr_reader :char, :dir, :versions
  
  def self.load_kanjis(dir)
    Dir.glob(File.join(dir,"SVG", "*.svg")).map{|file| File.basename(file)[0..3]}.map{|codepoint| [codepoint.to_i(16)].pack("U")}.uniq.map{|char| Kanji.new(char,dir)}.inject({}){|r, kanji| r[kanji.char] = kanji; r} 
  end

  def initialize(char, dir)
    @char = char
    @dir = dir
    self.read
  end

  def read
    @files = Dir.glob(File.join(dir, "SVG", "#{@char.unpack("U").first.to_s(16)}*.svg"))
  end

  def versions
    @files.size
  end

  def svg(n=0)
    open(@files[n]).read
  end

  def svg_display(n=0)
    open(@files[n]).read.gsub(/^<!DOCTYPE.*$/,"").gsub('width="109"', 'width="400"').gsub('height="109"', 'height="400"')
  end

  def xml(n=0)
    begin 
      open(@files[n].gsub("SVG","XML").gsub("svg","xml")).read 
    rescue  Errno::ENOENT => e
      "No XML for this Kanji"
    end
  end

  def name(n=0)
    @files[n]
  end
end

