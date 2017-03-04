module ApplicationHelper
  require 'securerandom'

  def elm(obj, config = {}, opts = { tag: 'div', id: SecureRandom.uuid })
    return "Cannot render an elm view for NilClass" if obj.nil?
    name = obj.class.name
    flags = config.merge({
      "#{name.downcase}": obj,
      editable: policy(obj).edit?
    })
    elm_view(name, flags: flags, **opts)
  end

  def elm_view(name, flags: nil, tag: 'div', id: SecureRandom.uuid)
    content_for :elm do
      elm_embed(name, id, flags).html_safe
    end

    "<#{tag} id='#{id}'></#{tag}>".html_safe
  end

  private

  def elm_embed(name, id, flags)
    "elmEmbed('#{name.to_s.titleize}', '#{id}', #{as_json(flags)});"
  end

  def as_json(flags)
    return 'undefined' if flags.nil?
    return flags if flags.is_a?(String)
    flags.merge(csrfToken: form_authenticity_token).to_json
  end
end
