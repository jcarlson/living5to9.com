ActiveAdmin.register Post, :title => :title do
  
  scope :published
  
  member_action :publish, :method => :put do
    Post.find(params[:id]).publish!
    redirect_to :back
  end
  
  action_item :only => :show do
    link_to "Publish Post", publish_admin_post_path(resource), :method => :put unless resource.published?
  end
  
  index do
    id_column
    column :title do |post|
      link_to post.title, admin_post_path(post)
    end
    column :date, :publish_at
    column :status do |post|
      status_tag(post.published? ? "Published" : "Draft")
    end
    default_actions :name => "Actions"
  end
  
  show :title => :title do
    panel "Content" do
      div do
        post.content
      end
    end
    panel "Details" do
      attributes_table_for post do
        row(:slug)
        row(:public_url) { nil }
      end
    end
  end
  
  sidebar "Publication", :only => :show do
    attributes_table_for post do
      row("Status") { status_tag post.published? ? "Published" : "Draft" }
      row("Published") { post.publish_at }
      row("Created") { post.created_at }
      row("Updated") { post.updated_at }
    end
  end
  
  form do |f|
    f.inputs "Content" do
      f.input :title
      f.input :content,
        :hint => "Content is authored as Markdown"
    end
    f.inputs "Publication" do
      f.input :publish_at, 
        :label => "Publication Date", 
        :hint => "Leave blank to publish now"
      f.input :published, 
        :as => :radio, 
        :label => "Publication Status", 
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
