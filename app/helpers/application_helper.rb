module ApplicationHelper
  LOCALE_LABELS = { 'en' => 'English', 'pt-BR' => 'Português' }.freeze

  def locale_links(exclude:)
    (locales = LOCALE_LABELS.dup).delete(exclude)

    locales.map do |locale_type, locale_label|
      link_to locale_label, locale_root_path(locale: locale_type)
    end
  end
end
