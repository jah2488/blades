class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_create do
    if self.respond_to?(:name)
      self.slug = name.downcase.parameterize
    end
  end

  def self.find(id)
    if id.to_i.zero?
      self.find_by(slug: id)
    else
      super
    end
  end

  def to_param
    if self.slug
      slug
    else
      super
    end
  end

  def to_s
    if self.respond_to?(:name)
      name
    end
  end
end
