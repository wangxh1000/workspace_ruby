require_relative '../util/log/input_log'
require_relative '../util/log/file_appender'

class LogManager

  def neo_error
    input_log = Log::InputLog.new
    file_appender = Log::FileAppender.new(Log::FileAppender::NEO_ERROR)
    file_appender.write_new_file(input_log.match_lines(/^Neo.Error:/))
  end

  def neo_log
    input_log = Log::InputLog.new
    file_appender = Log::FileAppender.new(Log::FileAppender::NEO_LOG)
    file_appender.write_new_file(input_log.match_lines(/^Neo.Log:/))
  end

  def reveal_log
    input_log = Log::InputLog.new
    file_appender = Log::FileAppender.new(Log::FileAppender::REVEAL_LOG)
    file_appender.write_new_file(input_log.match_multilines(/Hop\s#.*\n^.*\n^.*/))
    file_appender.append_file(input_log.select(:has_reveal_log_keyword))
  end

  def job_recommendation_log
    input_log = Log::InputLog.new
    file_appender = Log::FileAppender.new(Log::FileAppender::JOB_RECOMMENDATION_LOG)
    file_appender.write_new_file(input_log.select(:has_job_recommendation_keyword))
  end

  def temp_log
    input_log = Log::InputLog.new
    file_appender = Log::FileAppender.new(Log::FileAppender::TEMP_LOG)
    file_appender.write_new_file(input_log.select(:has_temp_keyword))
  end



private

end

log_manager = LogManager.new
log_manager.temp_log
#log_manager.reveal_log
#log_manager.job_recommendation_log
