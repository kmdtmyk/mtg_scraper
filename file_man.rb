class FileMan

  def self.read(path)
    begin
      return File.read(path)
    rescue Exception => e
      return nil
    end
  end

  def self.write(path, text)
    dirname = File.dirname(path)
    unless Dir.exist?(dirname)
      Dir.mkdir(dirname)
    end
    File.open(path, 'w') do |f|
      f.puts(text)
    end
  end

end
