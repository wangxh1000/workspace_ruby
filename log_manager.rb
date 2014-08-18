

class LogManager

  IN_FILE = 'c:/Log/In.txt'

  OUTPUT_FILE_NEO_LOG = 'c:/Log/NeoLog.txt'
  OUTPUT_FILE_NEO_ERROR = 'c:/Log/NeoError.txt'
  OUTPUT_FILE_JOB_RECOMMENDATION = 'c:/Log/JobRecommendationLog.txt'

  def neo_error
    output_log_to_file(OUTPUT_FILE_NEO_ERROR,
                       get_data_match(/^Neo.Error:/))
  end

  def neo_log
    output_log_to_file(OUTPUT_FILE_NEO_LOG,
                       get_data_match(/^Neo.Log:/))
  end


  def job_recommendation_log
    output_log_to_file(OUTPUT_FILE_JOB_RECOMMENDATION,
                       get_all_data.select{|line| has_job_recommendation_keyword(line)})
  end

private

  # get data match the given regex pattern
  def get_data_match(pattern)
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

  def get_all_data
    data = Array.new
    File.open(IN_FILE, 'r') do |file|
      file.each do |line|
        data << line
      end
    end
    data
  end

  def has_job_recommendation_keyword(line)
    (line =~ /JobRecsServiceRecEmail/) ||
        (line =~ /KDJobMatchingService/) ||
        (line =~ /JobMatcher/) ||
        (line =~ /ResumeContentLoader/)
  end

  def output_log_to_file(filename, data)
    File.open(filename, 'w+') do |file|
      data.each { |line| file.puts line }
    end
  end

end

log_manager = LogManager.new
# log_manager.neo_log
log_manager.job_recommendation_log