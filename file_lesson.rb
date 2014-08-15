#encoding: utf-8
require 'pry'

class FileLesson

  def file_open_lesson
    File.open('c:/DevProgramList.txt') do |file|
      file.each_line{|line| puts line}
      file.close
    end
  end

  def file_readline_lesson
   # myfile = File.open('c:/DevProgramList.txt', 'r+')

    File.open('c:/DevProgramList.txt', 'r:bom|utf-8') do |file|
      file.each_with_index do |line, index|
        puts line
      end
    end
    # binding.pry
    # puts myfile.readline
  end
end

file = FileLesson.new
file.file_readline_lesson