class Permalink < ActiveRecord::Base
  
  belongs_to :content, :polymorphic => true
  before_save :validate_content
  
  validates_presence_of   :slug
  validates_uniqueness_of :slug
  
private

  def validate_content
    errors.add :content_id, "cannot be blank" unless content_id.present?
    errors.add :content_type, "cannot be blank" unless content_type.present?
    errors.empty?
  end
  
end
