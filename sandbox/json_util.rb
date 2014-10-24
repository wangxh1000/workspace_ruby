require_relative '../util/log/input_log'
require 'json'

class JsonUtil

  def Job_Search_Api_Items
    input_log = Log::InputLog.new

    tempstr = input_log.all_lines.join(' ')
    output = JSON.parse tempstr

    result = 0
    output.to_hash["Item"].each do |item|
      result += item["Count"].to_i
    end

    puts result
  end

end

log_manager = JsonUtil.new
log_manager.Job_Search_Api_Items
