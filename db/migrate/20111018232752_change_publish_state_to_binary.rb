class ChangePublishStateToBinary < ActiveRecord::Migration
  def up
    posts = Post.all.map { |p| [p.id, p.publish_state] }
    remove_column :posts, :publish_state
    add_column :posts, :publish_state, :boolean, :default => false
    posts.each { |p| Post.find(p[0]).update_attributes :publish_state => (p[1] == 'published') }
  end

  def down
    posts = Post.all.map { |p| [p.id, p.publish_state] }
    remove_column :posts, :publish_state
    add_column :posts, :publish_state, :string, :default => 'draft'
    posts.each { |p| Post.find(p[0]).update_attributes :publish_state => (p[1] ? 'published' : 'draft') }
  end
end
