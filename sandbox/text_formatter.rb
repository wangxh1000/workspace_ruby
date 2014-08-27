require '../util/log/input_log'
require '../util/log/file_appender'

class TextFormatter

  def rspec_test
    input_log = Log::InputLog.new
    file_appender = Log::FileAppender.new(Log::FileAppender::RSPEC_TEST)
    result = []

    input_log.match_lines(/context\s\'(\d.*)\sdo$/).each do |line|
      line = line.gsub(/context '/, '')
      line = line.gsub(/' do/, '')
      result << line
    end

    file_appender.write_new_file(result)
  end

end

test_formatter = TextFormatter.new
test_formatter.rspec_test