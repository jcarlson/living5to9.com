class Category < ActiveRecord::Base
  include Slug

  # ATTRIBUTES

  # CALLBACKS

  # CONFIGURATION
  has_many :categorizations
  has_many :posts, 
    :through => :categorizations, 
    :source => :content, :source_type => "Post",
    :conditions => proc { ["public = ? and publish_at <= ?", true, DateTime.now] }

  # SCOPES

  # VALIDATIONS
  validates :name, :uniqueness => true, :presence => true

protected

  def default_slug
    name.present? ? "#{name.parameterize}" : nil
  end

end
