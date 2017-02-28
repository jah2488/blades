module ApplicationHelper
  require 'securerandom'

  def elm_view(name, flags = nil, tag: 'div', id: SecureRandom.uuid)
    content_for :elm do
      elm_embed(name, id, flags).html_safe
    end

    "<#{tag} id='#{id}'></#{tag}>".html_safe
  end

  private

  def elm_embed(name, id, flags)
    "#{embed_str(name, id)});" if flags.nil?
    "#{embed_str(name, id)}, #{as_json(flags)});"
  end

  def embed_str(name, id)
    "Elm.#{name.to_s.titleize}.embed(document.getElementById('#{id}')"
  end

  def as_json(flags)
    return flags if flags.is_a?(String)
    flags.to_json
  end
end
