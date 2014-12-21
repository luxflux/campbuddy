module ApplicationHelper
  def icon(type)
    content_tag(:i, "", class: "fa fa-#{type}")
  end

  def ico(type)
    content_tag(:i, "", class: "icon-essential-light-#{type}")
  end

  def nav_link(icon_type, url)
    link_to ico(icon_type), url, class: active_if_current_page(url)
  end

  def active_if_current_page(url)
    :active if current_page? url
  end

  def back_or_default_link(default)
    back_link (params[:back] || default)
  end

  def back_link(url)
    link_to ico(:"01-chevron-left"), url
  end

  def can_see_navigation?
    !current_user.guest?
  end
end
