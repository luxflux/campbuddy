module ApplicationHelper
  def icon(type)
    content_tag(:i, "", class: "fa fa-#{type}")
  end

  def ico(type)
    content_tag(:i, "", class: "icon-essential-light-#{type}")
  end

  def nav_link(icon, url, text, options = {})
    options.merge! class: active_if_current_page(url)
    link_to url, options do
      icon + content_tag(:span, text, class: :text)
    end
  end

  def active_if_current_page(url)
    :active if current_page? url
  end

  def back_or_default_link(default, options = {})
    back_link (params[:back] || default), options
  end

  def back_link(url, options = {})
    link_to ico(:"01-chevron-left"), url, options
  end

  def can_see_navigation?
    !current_user.guest?
  end
end
