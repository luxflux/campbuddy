module ApplicationHelper
  def icon(type)
    content_tag(:i, "", class: "fa fa-#{type}")
  end

  def ico(type)
    content_tag(:i, "", class: "icon-essential-light-#{type}")
  end

  def ico_nav(type, text)
    content_tag :span do
      content_tag(:i, "", class: "icon-essential-light-#{type}") +
        content_tag(:span, text, class: :text)
    end
  end

  def nav_link(icon_type, url, text, options = {})
    options.merge! class: active_if_current_page(url)
    link_to ico_nav(icon_type, text), url, options
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
