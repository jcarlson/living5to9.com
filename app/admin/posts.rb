ActiveAdmin.register Post, :title => :title do
  
  # Define a filter for 'published' posts
  scope :published
  
  # Create resource route to publish posts
  member_action :publish, :method => :put do
    Post.find(params[:id]).publish!
    redirect_to :back
  end
  
  # Add action item to publish posts
  action_item :only => :show do
    link_to "Publish Post", publish_admin_post_path(resource), :method => :put unless resource.public?
  end
  
  # Customize index page
  index do
    id_column
    column :title do |post|
      link_to post.title, admin_post_path(post)
    end
    column :date, :publish_at
    column :status do |post|
      status_tag(post.status)
    end
    default_actions :name => "Actions"
  end
  
  # Customize show page
  show :title => :title do
    panel "Content" do
      div do
        markdown post.content
      end
    end
    panel "Details" do
      attributes_table_for post do
        row(:slug)
        row(:public_url) { nil }
      end
    end
  end
  
  # Show publication sidebar on show page only
  sidebar "Publication", :only => :show do
    attributes_table_for post do
      row("Status") { status_tag post.status }
      row("Published") { post.publish_at }
      row("Created") { post.created_at }
      row("Updated") { post.updated_at }
    end
  end
  
  # Customize form for posts
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
      f.input :public, 
        :as => :radio, 
        :label => "Publication Status", 
        :hint => "Set to 'Draft' to keep hidden from public view",
        :collection => [["Public", true], ["Draft", false]]
    end
    f.inputs "Advanced" do
      f.input :slug, 
        :hint => "Customize the permalink"
    end
    f.buttons
  end
  
end
