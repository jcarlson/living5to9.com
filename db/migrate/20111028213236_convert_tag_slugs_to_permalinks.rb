class ConvertTagSlugsToPermalinks < ActiveRecord::Migration
  def up
    # iterate through all tags and re-save them... thus creating a corresponding permalink
    # if a tag's new permalink isn't valid, we're just going to move on, thus #save, not #save!
    Tag.all.each &:save
    # now remove the slug column from tags
    remove_column :tags, :slug
  end

  def down
    # add a slug column back to tags
    add_column :tags, :slug, :string
    # iterate tags and set the slug to #{term.parameterize}
    Tag.all.each do |tag|
      tag.slug = tag.term.parameterize
      tag.save
    end
    # finally, destroy any Permalinks referencing Tags
    Permalink.find_by_content_type("Tag").each &:destroy
  end
end
