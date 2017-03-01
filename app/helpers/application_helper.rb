module ApplicationHelper
  require 'securerandom'

  def elm_view(name, flags: nil, tag: 'div', id: SecureRandom.uuid)
    content_for :elm do
      elm_embed(name, id, flags).html_safe
    end

    "<#{tag} id='#{id}'></#{tag}>".html_safe
  end

  private

  def elm_embed(name, id, flags)
    "elmEmbed('#{name.to_s.titleize}', '#{id}', #{as_json(flags)});\n"
  end

  def as_json(flags)
    return 'undefined' if flags.nil?
    return flags if flags.is_a?(String)
    flags.to_json
  end
end
