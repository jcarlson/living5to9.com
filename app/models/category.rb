class Category < ActiveRecord::Base
  include HasPermalink

  # ATTRIBUTES

  # CALLBACKS

  # CONFIGURATION

  # SCOPES

  # VALIDATIONS
  validates :name, :uniqueness => true, :presence => true

protected

  def default_slug
    name.present? ? "#{name.parameterize}" : nil
  end

end
