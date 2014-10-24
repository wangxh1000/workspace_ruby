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

  def stringbuilder_append
    input_log = Log::InputLog.new
    file_appender = Log::FileAppender.new(Log::FileAppender::STRING_BUILDER_APPEND)

    result = []

    input_log.all_lines.each do |line|
      line = 'sb.Append("' + line.gsub(/"/, '""').chomp + '" & vbCrLf)'
      result << line
    end

    file_appender.write_new_file(result)
  end

end

test_formatter = TextFormatter.new
test_formatter.stringbuilder_append