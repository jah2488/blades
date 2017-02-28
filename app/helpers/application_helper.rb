module ApplicationHelper
  require 'securerandom'

  def elm_component(name, flags = nil)
    id = SecureRandom.uuid
    content_for :elm do
      if flags
        if flags.is_a?(String)
          json_flags = flags
        else
          json_flags = flags.to_json
        end
        """ Elm.#{name.to_s.titleize}.embed(document.getElementById('#{id}'), #{json_flags});
        """.html_safe
      else
        """ Elm.#{name.to_s.titleize}.embed(document.getElementById('#{id}'));
        """.html_safe
      end
    end
    """ <div id='#{id}'></div> """.html_safe
  end
end
