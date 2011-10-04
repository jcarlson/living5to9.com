ActiveAdmin.register Photo do

  index do
    column :id
    column :image do |photo|
      link_to image_tag(photo.image.thumb('160x120').url), [:admin, photo]
    end
    column :release_date
  end
  
  form do |f|
    f.inputs do
      f.input :release_date, :as => :string
      f.input :image, :as => :file
    end
    f.buttons
  end

end
