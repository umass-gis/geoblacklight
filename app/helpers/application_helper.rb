module ApplicationHelper

  def render_html_description(args)
  simple_format(Array(args[:value]).flatten.join(' '))
end

end
