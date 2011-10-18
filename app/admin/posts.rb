ActiveAdmin.register Post do
  
  
  form do |f|
    f.inputs "Content" do
      f.input :title
      f.input :content
    end
    f.inputs "Publication" do
      f.input :publish_date, :hint => "Leave blank to publish now"
      f.input :publish_state
    end
    f.inputs "Advanced" do
      f.input :slug
    end
    f.buttons
  end
  
end
