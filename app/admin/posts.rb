ActiveAdmin.register Post do
  
  member_action :publish, :method => :put do
    Post.find(params[:id]).publish!
    redirect_to :back
  end
  
  form do |f|
    f.inputs "Content" do
      f.input :title
      f.input :content,
        :hint => "Content is authored as Markdown"
    end
    f.inputs "Publication" do
      f.input :publish_date, 
        :label => "Publication Date", 
        :hint => "Leave blank to publish now"
      f.input :published, 
        :as => :radio, 
        :label => "Publication State", 
        :hint => "Set to 'Draft' to keep hidden from public view",
        :collection => [["Published", true], ["Draft", false]]
    end
    f.inputs "Advanced" do
      f.input :slug, 
        :hint => "Customize the permalink"
    end
    f.buttons
  end
  
end
