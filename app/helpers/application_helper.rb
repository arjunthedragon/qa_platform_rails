module ApplicationHelper

  def bullet_list(array_list, ul_class_name)
    return unless array_list.is_a?(Array)
  
    content_tag(:ul, :class => ul_class_name) do
      array_list.collect { |ele|
        content_tag(:li, ele)
      }.join.html_safe
    end
  end
  
end
