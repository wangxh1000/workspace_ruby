require 'win32ole'

class Excel_Util

  def time_now
    initialize
    @t =Time.now
    a = @t.to_s.split(" ")
    s = a[-1].to_s+'-'+"#{@t.mon}"+'-'+a[2].to_s
    @time_now= s+' '+a[3].to_s
    #@time_now=@t.year+''+@t.ymonth+''+@t.mday
    @time_now_hsm =a[3].to_s
  end

  def initialize
    @OnlyInitOnce = true
    @t
    @objSheet
    @excel
    @sStatus
    @sStepName
    @sStepName
    @sStepName
    @sDetails
    @@TestcaseName=@@a
  end

  def excel_new(encoding="utf-8")
    initialize
    @worksheets_name =[]
    @excel = WIN32OLE::new("EXCEL.APPLICATION")
    @excel.visible=true
    @workbook = @excel.Workbooks.Add()
    @encoding = encoding
  end

  def excelsheet_name(name)
    while @@worksheets_name.include?(name)
      name +="1"
    end
    @@worksheets_name << name
    worksheet = @workbook.Worksheets.Add()
    worksheet.Activate
    worksheet.name = name
  end

  def excel_quit
    @excel.Quit                      # 退出当前Excel文件
    # @workbook.close                        关闭表sheet空间
    # exec('taskkill /f /im Excel.exe ')  强制关闭所有的Excel进程
  end

  def CreateResultFile(filepath)
    excel_new
    @excel.DisplayAlerts = false

    @objSheet =  @excel.Sheets.Item(1)
    @excel.Sheets.Item(1).Select
    @objSheet.Name = "测试概要"

    @objSheet.Range("B1").Value = "测试结果"
    #合并单元格
    @objSheet.Range("B1:E1").Merge
    #水平居中 -4108
    @objSheet.Range("B1:E1").HorizontalAlignment = -4108
    @objSheet.Range("B1:E1").Interior.ColorIndex = 53
    @objSheet.Range("B1:E1").Font.ColorIndex = 5
    @objSheet.Range("B1:E1").Font.Bold = true
    @objSheet.Range("B1:E1").Font.Size =24

    @objSheet.Range("B2:E2").Merge
    @objSheet.Rows(2).RowHeight = 20

    rowNum = [3,4,5,6,7,8]
    rowNum.each {|re|  @objSheet.Range("C#{re}:E#{re}").Merge}

    @objSheet.Range("B9:E9").Merge
    @objSheet.Rows(9).RowHeight = 30

    #Set the Date and time of Execution
    @objSheet.Range("B3").Value = "测试日期: "
    @objSheet.Range("B4").Value = "开始时间: "
    @objSheet.Range("B5").Value = "结束时间: "
    @objSheet.Range("B6").Value = "持续时间: "
    #@objSheet.Range("C3").Value = Date
    @objSheet.Range("C4").Value = time_now
    @objSheet.Range("C5").Value = time_now
    @objSheet.Range("C6").Value = "=R[-1]C-R[-2]C"
    @objSheet.Range("C6").NumberFormat ="[h]:mm:ss;@"

    #Set the Borders for the Date & Time Cells
    @objSheet.Range("B3:E8").Borders(1).LineStyle = 1
    @objSheet.Range("B3:E8").Borders(2).LineStyle = 1
    @objSheet.Range("B3:E8").Borders(3).LineStyle = 1
    @objSheet.Range("B3:E8").Borders(4).LineStyle = 1

    #Format the Date and Time Cells
    @objSheet.Range("B3:E8").Interior.ColorIndex = 40
    @objSheet.Range("B3:E8").Font.ColorIndex = 12
    @objSheet.Range("B3:A8").Font.Bold = true

    #Track the Row Count and insrtuct the viewer not to disturb this
    @objSheet.Range("C7").AddComment
    @objSheet.Range("C7").Comment.Visible = false
    @objSheet.Range("C7").Comment.Text "这点生成的数据大家不要删除哦"
    @objSheet.Range("C7").Value = "0"
    @objSheet.Range("B7").Value = "用例总数:"

    #Track the Testcase Count Count and insrtuct the viewer not to disturb this
    @objSheet.Range("C8").AddComment
    @objSheet.Range("C8").Comment.Visible = false
    @objSheet.Range("C8").Comment.Text "这点数据别删除了 删除了 你会后悔的"
    @objSheet.Range("C8").Value = "0"
    @objSheet.Range("B8").Value = "步骤总数:"

    @objSheet.Range("B10").Value = "测试用例名称"
    @objSheet.Range("D10").Value = "状态"
    @objSheet.Range("E10").Value = "步骤数"
    @objSheet.Hyperlinks.Add(@objSheet.Range("B9"), "","测试结果!A1")
    @objSheet.Range("B9").Value = "点击测试用例名称打开详情页面."

    #      @objSheet.Hyperlinks.Add(@objSheet.Range("B9"), "http://www.163.com")
    #Format the Heading for the Result Summery
    @objSheet.Range("B10:C10").Merge
    @objSheet.Range("B10:E10").Interior.ColorIndex = 53
    @objSheet.Range("B10:E10").Font.ColorIndex = 19
    @objSheet.Range("B10:E10").Font.Bold = true

    #Set the Borders for the Result Summery
    @objSheet.Range("B10:E10").Borders(1).LineStyle = 1
    @objSheet.Range("B10:E10").Borders(2).LineStyle = 1
    @objSheet.Range("B10:E10").Borders(3).LineStyle = 1
    @objSheet.Range("B10:E10").Borders(4).LineStyle = 1

    #Set Column width
    @objSheet.Columns("B:E").Select

    #@objSheet.Columns("B:D").Autofit

    @objSheet.Range("B11").Select
    @objSheet.Range("B11").ColumnWidth=12
    @objSheet.Range("C11").ColumnWidth=50
    @objSheet.Range("D11").ColumnWidth=15
    @objSheet.Range("E11").ColumnWidth=15

    #Freez pane
    @excel.ActiveWindow.FreezePanes = true

    #Get the object of the first sheet in the workbook
    @objSheet = @excel.Sheets.Item(2)
    @excel.Sheets.Item(1).Select


    #Rename the first sheet to "Test_Result"
    @objSheet.Name = "测试结果"

    #Set the Column widths
    @objSheet.Columns("A:A").ColumnWidth = 30
    @objSheet.Columns("B:B").ColumnWidth = 8
    @objSheet.Columns("C:D").ColumnWidth = 35
    @objSheet.Columns("E:E").ColumnWidth = 35
    @objSheet.Columns("A:E").HorizontalAlignment =  -4131

    @objSheet.Columns("A:E").WrapText = true

    #Set the Heading for the Result Columns
    @objSheet.Range("A1").Value = "步骤"
    @objSheet.Range("B1").Value = "状态"
    @objSheet.Range("C1").Value = "期望结果"
    @objSheet.Range("D1").Value = "实际结果"
    @objSheet.Range("E1").Value = "错误信息"

    #Format the Heading for the Result Columns
    @objSheet.Range("A1:E1").Interior.ColorIndex = 53
    @objSheet.Range("A1:E1").Font.ColorIndex = 19
    @objSheet.Range("A1:E1").Font.Bold = true

    #Set the Borders for the Result Header
    @objSheet.Range("A1:E1").Borders(1).LineStyle = 1
    @objSheet.Range("A1:E1").Borders(2).LineStyle = 1
    @objSheet.Range("A1:E1").Borders(3).LineStyle = 1
    @objSheet.Range("A1:E1").Borders(4).LineStyle = 1
    #                    .Range("A2").Select

    #Freez pane
    @excel.ActiveWindow.FreezePanes = true

    @objSheet = @excel.Sheets.Item(3)
    @excel.Sheets.Item(1).Select

    @objSheet.Name = "使用说明"
    @objSheet.Columns("A:A").ColumnWidth = 100
    @objSheet.Rows("2:2").RowHeight = 150
    @objSheet.Range("A1:A1").Font.Bold = true
    @objSheet.Range("A1").Value = "测试报告使用说明"
    @objSheet.Range("A2").Value = "点击测试用例名称即可打开测试结果页面"

    @excel.ActiveWindow.FreezePanes = true
    #Save the Workbook at the specified Path with the Specified Name
    @excel.ActiveWorkbook.saveas "#{filepath}"
    @workbook.close
  end

  def reporter (sStatus, sStepName,sExpected,sActual, sDetails)
    #path =  File.join(File.dirname(__FILE__))
    #定位到具体的excel文件,本功能对应excel为:发布宝贝.xls

    #data_source = File.join(path,'发布宝贝.xls')
    #@@TestcaseName =@@a #__FILE__
    @WorkBookopen= @excel.Workbooks.Open("D:\\test.xls")
    @objSheet = @excel.Sheets("测试概要")
    @excel.Sheets("测试概要").Select
    @Row = (@objSheet.Range("C8").Value + 2*@objSheet.Range("C7").Value + 2).to_i
    @TCRow = (@objSheet.Range("C7").Value + 11).to_i
    @NewTC = false
    @objSheet.Range("B#{@Row+9}:C#{@Row+9}").Merge
    #Check if it is a new Tetstcase
    if @objSheet.Cells(@TCRow-1, 2).Value != @@TestcaseName
      @objSheet.Range("B#{@Row+9}:C#{@Row+9}").Merge
      @objSheet.Cells(@TCRow, 2).Value = @@TestcaseName
      @objSheet.Hyperlinks.Add @objSheet.Cells(@TCRow, 2), "", "测试结果!A#{ @Row+1}", @@TestcaseName
      @objSheet.Cells(@TCRow,4).Value = sStatus

      case sStatus
        when "Fail"
          @objSheet.Range("D#{@TCRow}").Font.ColorIndex = 3
        when "Pass"
          @objSheet.Range("D#{@TCRow}").Font.ColorIndex = 50
        when "Warning"
          @objSheet.Range("D#{@TCRow}").Font.ColorIndex = 46
        else
          puts "报告参数书写错误：请输入 Fail or Pass or Warning 三个值"
      end

      @objSheet.Cells(@TCRow, 5).Value = 1
      @NewTC = true
      @objSheet.Range("C7").Value = @objSheet.Range("C7").Value + 1

      #Set the Borders for the Result Header
      @objSheet.Range("B#{@TCRow}:E#{@TCRow}").Borders(1).LineStyle = 1
      @objSheet.Range("B#{@TCRow}:E#{@TCRow}").Borders(2).LineStyle = 1
      @objSheet.Range("B#{@TCRow}:E#{@TCRow}").Borders(3).LineStyle = 1
      @objSheet.Range("B#{@TCRow}:E#{@TCRow}").Borders(4).LineStyle = 1

      #Set color and Fonts for the Header
      @objSheet.Range("B#{@TCRow}:E#{@TCRow}").Interior.ColorIndex = 19
      @objSheet.Range("B#{@TCRow}").Font.ColorIndex = 53
      @objSheet.Range("B#{@TCRow}:E#{@TCRow}").Font.Bold = true
    else
      @objSheet.Range("E#{@TCRow-1}").Value = (@objSheet.Range("E#{@TCRow-1}").Value) + 1
    end

    if  (@NewTC!=true) and (sStatus == "Fail")
      @objSheet.Cells(@TCRow-1, 4).Value = "Fail"
      @objSheet.Range("D#{@TCRow-1}").Font.ColorIndex = 3
    end
    if  (@NewTC!=true) and (sStatus == "Warning")
      if @objSheet.Cells(@TCRow-1, 4).Value == "Pass"
        @objSheet.Cells(@TCRow-1, 4).Value = "Warning"
        @objSheet.Range("D#{@TCRow-1}").Font.ColorIndex = 46
      end
    end

    @objSheet.Range("C8").Value = @objSheet.Range("C8").Value + 1
    #Update the End Time
    @objSheet.Range("C5").Value = time_now

    #Set Column width
    @objSheet.Columns("B:E").Select
    @objSheet.Columns("B:E").Autofit

    #Select the Result Sheet
    @objSheet = @excel.Sheets("测试结果")
    @excel.Sheets("测试结果").Select

    #Enter the Result
    if @NewTC
      @objSheet.Range("A#{@Row}:E#{@Row}").Interior.ColorIndex = 15
      @objSheet.Range("A#{@Row}:E#{@Row}").Merge
      @Row = @Row + 1
      @objSheet.Range("A#{@Row}:E#{@Row}").Merge
      @objSheet.Range("A#{@Row}").Value = @@TestcaseName
      #Set color and Fonts for the Header
      @objSheet.Range("A#{@Row}:E#{@Row}").Interior.ColorIndex = 19
      @objSheet.Range("A#{@Row}:E#{@Row}").Font.ColorIndex = 53
      @objSheet.Range("A#{@Row}:E#{@Row}").Font.Bold = true
      @Row = @Row + 1
    end
    @objSheet.Range("A#{@Row}").Value = sStepName
    @objSheet.Range("B#{@Row}").Value = sStatus
    @objSheet.Range("B#{@Row}").Font.Bold = true

    case sStatus
      when "Pass"
        @objSheet.Range("B#{@Row}").Font.ColorIndex = 50
        @objSheet.Range("B#{@Row}").Font.Bold = true
      when "Fail"
        @objSheet.Range("A#{@Row}:E#{@Row}").Font.ColorIndex = 3
      when "Warning"
        @objSheet.Range("A#{@Row}:E#{@Row}").Font.ColorIndex = 46
      else
        puts "你的报告参数书写错误：请输入 Fail or Pass or Warning 三个值"
    end

    @objSheet.Range("B#{@Row}").Font.Bold = true
    @objSheet.Range("C#{@Row}").Value = sExpected
    @objSheet.Range("D#{@Row}").Value = sActual
    @objSheet.Range("E#{@Row}").Value = sDetails

    #Set the Borders
    @objSheet.Range("A#{@Row}:E#{@Row}").Borders(1).LineStyle = 1
    @objSheet.Range("A#{@Row}:E#{@Row}").Borders(2).LineStyle = 1
    @objSheet.Range("A#{@Row}:E#{@Row}").Borders(3).LineStyle = 1
    @objSheet.Range("A#{@Row}:E#{@Row}").Borders(4).LineStyle = 1
    @objSheet.Range("A#{@Row}:E#{@Row}").VerticalAlignment = -4160

    @excel.Sheets("测试概要").Select
    @excel.Sheets("测试概要").Range("B1").Select
    #Save the Workbook
    @WorkBookopen.save
  end

end