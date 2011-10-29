class Category < ActiveRecord::Base
  include HasPermalink

  # ATTRIBUTES

  # CALLBACKS

  # CONFIGURATION
  has_many :categorizations
  has_many :posts, :through => :categorizations, :source => :content, :source_type => "Post"

  # SCOPES

  # VALIDATIONS
  validates :name, :uniqueness => true, :presence => true

protected

  def default_slug
    name.present? ? "#{name.parameterize}" : nil
  end

end
