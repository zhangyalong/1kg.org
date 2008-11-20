module SchoolHelper
  def radio_choice(form, object)
    [[0,"否"], [1,"是"], [2, "未知"]].collect {|r| form.radio_button(object, r[0]) + r[1]}
  end
  
  def radio_value(value)
    result = %w(没有 有 未知)
    result[value]
  end
  
end