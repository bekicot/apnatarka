module ApplicationHelper

  def language_options
    options = []
    options << [t('header.english'), "en"]
    options << [t('header.arabic'), "ar"]
  end

  def active_class(path, path_1 = "", path_2 = "")
    current_page?(path) || (path_1.present? && current_page?(path_1)) || (path_2.present? && current_page?(path_2)) ? "active" : ""
  end

end
