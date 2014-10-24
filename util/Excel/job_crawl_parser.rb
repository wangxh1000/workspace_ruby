require 'win32ole'
require '../../util/Excel/talent_need'

class Job_Crawl_Parser

  def talent_demand_doctor_20140926
    @excel = WIN32OLE::new("EXCEL.APPLICATION")
    WIN32OLE.codepage = WIN32OLE::CP_UTF8

    @workbook = @excel.Workbooks.Open("D:\\temp\\talent_demand_doctor_20140926.xls")

    @sheet = @excel.Sheets("sheet1")

    @all_talent_needs = []

    @current_line = 3

    while not @sheet.range("A#{@current_line}").value.nil?
      @data_of_current_line = @sheet.Range("A#{@current_line}:Q#{@current_line}").value

      @talent_need = TalentNeed.new
      @talent_need.company_name = @sheet.Range("A#{@current_line}").value
      @talent_need.company_property = @sheet.Range("B#{@current_line}").value
      @talent_need.company_competent_authority = @sheet.Range("C#{@current_line}").value
      @talent_need.company_address = @sheet.Range("D#{@current_line}").value
      @talent_need.company_contact = @sheet.Range("E#{@current_line}").value
      @talent_need.company_telephone = @sheet.Range("F#{@current_line}").value
      @talent_need.company_description = @sheet.Range("G#{@current_line}").value
      @talent_need.position = @sheet.Range("H#{@current_line}").value
      @talent_need.major = @sheet.Range("I#{@current_line}").value
      @talent_need.education = @sheet.Range("J#{@current_line}").value
      @talent_need.num = @sheet.Range("K#{@current_line}").value
      @talent_need.resume = @sheet.Range("L#{@current_line}").value
      @talent_need.requirement = @sheet.Range("M#{@current_line}").value
      @talent_need.treatment = @sheet.Range("N#{@current_line}").value
      @talent_need.location = @sheet.Range("O#{@current_line}").value
      @talent_need.introduction_way = @sheet.Range("P#{@current_line}").value
      @talent_need.introduction_type = @sheet.Range("Q#{@current_line}").value

      puts @talent_need.to_s
      #@all_talent_needs.push(@talent_need)
      @current_line += 1
      puts @current_line
    end

    @workbook.close
    @excel.Quit

    #puts @all_talent_needs.to_s

  end

end

parser = Job_Crawl_Parser.new
parser.talent_demand_doctor_20140926