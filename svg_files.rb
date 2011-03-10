
class SVG_files
  def initialize(dir)
   
    @svg_files = Dir.glob(File.join(dir,"SVG", "*.svg")).sort.inject(Hash.new{|h, k| h[k] = []})  do |r, filename| 
      basename = File.basename(filename) 
      num = basename[0..3]
      char = num.to_i(16)
      r[[char].pack("U*")] << filename 
      r
    end
  end

  def keys
    @svg_files.keys
  end

  def exists?(char)
    not @svg_files[char].empty?  
  end

  def get_code(char, version = 0, width = 400, height = 400)
    open(@svg_files[char][version]).read.gsub(/^<!DOCTYPE.*$/,"").gsub('width="109"', 'width="400"').gsub('height="109"', 'height="400"')
  end

  def get_raw(char, version)
    open(@svg_files[char][version]).read
  end

  def get_filename(char, version)
    @svg_files[char][version]
  end

  def versions(char)
    @svg_files[char].size
  end

end
