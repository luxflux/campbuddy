module ApplicationHelper
  def icon(type)
    content_tag(:i, "", class: "fa fa-#{type}")
  end

  def nav_link(icon_type, url)
    link_to icon(icon_type), url, class: active_if_current_page(url)
  end

  def active_if_current_page(url)
    :active if current_page? url
  end
end
