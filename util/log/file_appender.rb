
module Log

  class FileAppender

    NEO_LOG = 'c:/Log/NeoLog.txt'
    NEO_ERROR = 'c:/Log/NeoError.txt'
    REVEAL_LOG = 'c:/Log/RevealLog.txt'
    JOB_RECOMMENDATION_LOG = 'c:/Log/JobRecommendationLog.txt'

    RSPEC_TEST = 'c:/Log/RspecTest.txt'

    def initialize(file_name)
      @file_name = file_name
    end

    def write_new_file(data_list)
      File.open(@file_name, 'w+') do |f|
        data_list.each { |data| f.puts data }
      end
    end

    def append_file(data_list)
      File.open(@file_name, 'a+') do |f|
        data_list.each { |data| f.puts data }
      end
    end

private


  end

end
