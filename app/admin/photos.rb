ActiveAdmin.register Photo do

  index do
    column :id
    column :image do |photo|
      link_to image_tag(photo.image.thumb('160x120').url), [:admin, photo]
    end
    column :release_date
  end
  
  show :title => :image_name do
    panel "Photo" do
      image_tag photo.image.thumb('640x480').url
    end
  end
  
  # Show publication sidebar on show page only
  sidebar "Photo Details", :only => :show do
    attributes_table_for photo do
      row(:id)
      row(:release_date)
    end
  end
  sidebar "Taxonomy", :only => :show do
    attributes_table_for photo do
      row(:tags) { photo.tag_terms }
    end
  end
  sidebar "Details", :only => :show do
    attributes_table_for photo do
      row(:public_url) { link_to photo.permalink.slug, slug_for(photo) }
    end
  end
  
  form do |f|
    f.inputs do
      f.input :release_date, :as => :string
      f.input :image, :as => :file
    end
    f.inputs "Taxonomy" do
      f.input :tag_terms,
        :hint => "Enter tags as comma-separated list, e.g. 'ruby, rails, code'"
    end
    f.inputs "Permalink" do
      f.input :slug, :hint => "leave blank for default slug"
    end
    f.buttons
  end

end
