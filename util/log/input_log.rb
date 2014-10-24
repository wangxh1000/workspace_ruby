
module Log

class InputLog

  def all_lines
    data = Array.new
    File.open(IN_FILE, 'r') do |file|
      file.each do |line|
        data << line
      end
    end
    data
  end

  def select(method_name)
    all_lines.select{|c| send(method_name, c)}
  end

  # lines match the given regex pattern
  def match_lines(pattern)
    data = Array.new
    File.open(IN_FILE, 'r') do |file|
      file.each do |line|
        if line =~ pattern
          data << line
        end
      end
    end
    data
  end

  # multilines match the given regex pattern (some pattern will match multi lines)
  def match_multilines(pattern)
    data = Array.new
    content = File.open(IN_FILE, 'r') {|f| f.read}
    content.scan(pattern).each do |m|
      data << m
    end
    data
  end

private

  IN_FILE = 'c:/Log/In.txt'

  def has_job_recommendation_keyword(line)
    (line =~ /JobRecsServiceRecEmail/) ||
        (line =~ /KDJobMatchingService/) ||
        (line =~ /JobMatcher/) ||
        (line =~ /ResumeContentLoader/)
  end

  def has_reveal_log_keyword(line)
    (line =~ /^Hop/) ||
        (line =~ /^\[Info\]/) ||
        (line =~ /^\[Warn\]/) ||
        (line =~ /^\[Error\]/)
  end

  def has_temp_keyword(line)
    (line =~ /^.*\)/)
  end

end

end