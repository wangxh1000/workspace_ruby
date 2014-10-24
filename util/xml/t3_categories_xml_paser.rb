require_relative '../../util/log/input_log'
require 'nokogiri'

class T3CategoriesXmlPaser

  attr_reader :job_categories_group

  def initialize
    @job_categories_group = Array.new

    input_log = Log::InputLog.new
    doc_str = input_log.all_lines.join(' ')

    parse(doc_str)
  end

  def to_s
    s = ''
    @job_categories_group.each do |group|
      s << group.name
      s << "\n"

      group.categories.each do |item|
        s << "  "+item.name
        s << "\n"
      end
    end
    s
  end

  def to_xml
    builder = Nokogiri::XML::Builder.new(:encoding=>'UTF-8') do |xml|
      xml.Categories {
        @job_categories_group.each do |group|
          xml.Category('name'=>group.name) do
            group.categories.each do |item|
              xml.Type('name'=>item.name)
            end
          end
        end
      }
    end
    builder.to_xml
  end

  private

  def parse(doc_str)
    doc = Nokogiri::HTML(doc_str)

    doc.css('.grp_container').each do |job_categories_group|
      group = T3JobCategoriesGroup.new
      group.name = job_categories_group.css('.cat_title span').text

      categories = Array.new
      job_categories_group.css('.sub_container a').each do |job_category|
        if job_category.text.include? "View All"
          next
        end

        item = T3JobCategory.new
        item.name = job_category.text
        categories << item
      end
      group.categories = categories

      @job_categories_group << group
    end
  end
end

class T3JobCategoriesGroup
  attr_accessor :name, :categories
end

class T3JobCategory
  attr_accessor :name
end

parser = T3CategoriesXmlPaser.new
# puts parser.to_s
puts parser.to_xml