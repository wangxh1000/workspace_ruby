

class LogManager

  def neo_error
    output_log_to_new_file(OUTPUT_FILE_NEO_ERROR,
                       get_line_match(/^Neo.Error:/))
  end

  def neo_log
    output_log_to_new_file(OUTPUT_FILE_NEO_LOG,
                       get_line_match(/^Neo.Log:/))
  end

  def reveal_log
    file_name = OUTPUT_FILE_REVEAL_LOG
    output_log_to_new_file(file_name,
                           get_data_match(/Hop\s#.*\n^.*\n^.*/))
    append_log_to_file(file_name, get_all_lines.select{|line| has_reveal_log_keyword(line)})
  end

  def job_recommendation_log
    output_log_to_new_file(OUTPUT_FILE_JOB_RECOMMENDATION,
                       get_all_lines.select{|line| has_job_recommendation_keyword(line)})
  end


  def test(pattern)
  end

private

  IN_FILE = 'c:/Log/In.txt'

  OUTPUT_FILE_NEO_LOG = 'c:/Log/NeoLog.txt'
  OUTPUT_FILE_NEO_ERROR = 'c:/Log/NeoError.txt'
  OUTPUT_FILE_REVEAL_LOG = 'c:/Log/RevealLog.txt'
  OUTPUT_FILE_JOB_RECOMMENDATION = 'c:/Log/JobRecommendationLog.txt'

  # get file line match the given regex pattern
  def get_line_match(pattern)
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

  def get_all_lines
    data = Array.new
    File.open(IN_FILE, 'r') do |file|
      file.each do |line|
        data << line
      end
    end
    data
  end

  # get file data match the given regex pattern
  def get_data_match(pattern)
    data = Array.new
    content = File.open(IN_FILE, 'r') {|f| f.read}
    content.scan(pattern).each do |m|
      data << m
    end
    data
  end

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

  def output_log_to_new_file(filename, data)
    File.open(filename, 'w+') do |file|
      data.each { |line| file.puts line }
    end
  end

  def append_log_to_file(filename, data)
    File.open(filename, 'a+') do |file|
      data.each { |line| file.puts line }
    end
  end

end

log_manager = LogManager.new
# log_manager.neo_log
log_manager.reveal_log
# log_manager.job_recommendation_log
