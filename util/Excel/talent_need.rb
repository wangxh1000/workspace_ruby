#coding: utf-8

class TalentNeed
  attr_accessor :company_name
  attr_accessor :company_property
  attr_accessor :company_competent_authority
  attr_accessor :company_address
  attr_accessor :company_contact
  attr_accessor :company_telephone
  attr_accessor :company_description
  attr_accessor :position
  attr_accessor :major
  attr_accessor :education
  attr_accessor :num
  attr_accessor :resume
  attr_accessor :requirement
  attr_accessor :treatment
  attr_accessor :location
  attr_accessor :introduction_way
  attr_accessor :introduction_type

  def to_s
    s = "START JOB\n"
    s << "HHAction: ADD\n"
    s << "HHUserJobID: zggzrc2014-"
    s << "HHJobTitle: #{@position}\n"
    s << "HHCity: #{@location}\n"
    s << "HHEducation: #{@education}\n"
    s << "HHContactPhone:\n"
    s << "HHDescription: 需求描述: #{@requirement}\n"
    s << "需求专业（职称）：#{@major}\n"
    s << "履历要求：#{@resume}\n"
    s << "引进方式：#{@introduction_way}\n"
    s << "引进类型：#{@introduction_type}\n"
    s << "提供待遇：#{@treatment}\n"
    s << "单位名称：#{@company_name}\n"
    s << "单位性质：#{@company_property}\n"
    s << "主管部门：#{@company_competent_authority}\n"
    s << "单位地址：#{@company_address}\n"
    s << "单位联系人：#{@company_contact}\n"
    s << "联系电话：#{@company_telephone}\n"
    s << "单位简介：#{@company_description}\n"
    s << "END JOB\n\n"
  end
end