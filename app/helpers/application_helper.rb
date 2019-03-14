module ApplicationHelper
  def flash_classes(level)
    case level
      when 'notice' then "alert alert-info"
      when 'success' then "alert alert-success"
      when 'error' then "alert alert-danger"
      when 'alert' then "alert alert-warning"
    end
  end

  def body_classes
    [controller_name, action_name, "bg#{(1..4).to_a.shuffle.first}"].join(' ')
  end
end
