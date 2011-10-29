ActiveAdmin.register Post do
  
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
    panel "Taxonomy" do
      attributes_table_for post do
        row(:tags) { post.tag_terms }
      end
    end
    panel "Details" do
      attributes_table_for post do
        row(:public_url) { link_to post.permalink.slug, slug_path(post) }
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
        :hint => "Author content in Markdown"
    end
    f.inputs "Taxonomy" do
      f.input :tag_terms,
        :hint => "Enter tags as comma-separated list, e.g. 'ruby, rails, code'"
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
    f.inputs "Permalink" do
      f.input :slug, :hint => "leave blank for default slug"
    end
    f.buttons
  end
  
end
