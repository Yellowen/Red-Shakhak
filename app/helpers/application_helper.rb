module ApplicationHelper

  # Hack link_to helper of rails to support font_awesome icons
  def link_to(name = nil, options = nil, html_options = nil, &block)
    unless block_given?
      icons = html_options ? html_options.delete(:icons) : nil
      if icons

        return super(options, html_options) do
          "<i class=\"#{icons}\"></i> #{name}".html_safe
        end
      end
    end

    super
  end

  def back_btn_class
    "btn btn-warning"
  end

  def back_btn_icon
    "icon-chevron-right"
  end

  def show_btn_class
    "btn"
  end

  def show_btn_icon
    "icon-check-sign"
  end

  def edit_btn_class
    "btn btn-info"
  end

  def edit_btn_icon
    "icon-edit"
  end

  def add_btn_class
    "button success"
  end

  def add_btn_icon
    "icon-plus"
  end

  def del_btn_class
    "btn btn-danger"
  end

  def del_btn_icon
    "icon-remove"
  end
end
