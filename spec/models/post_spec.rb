require 'spec_helper'

describe Post do
  
  context "public scope" do
    
    before do
      Timecop.freeze DateTime.now.beginning_of_day
      
      # generate some posts
      @post1 = Factory :post, :title => "No publication date", :public => true
      @post2 = Factory :post, :title => "Published yesterday", :publish_at => DateTime.yesterday, :public => true
      @post3 = Factory :post, :title => "Published tomorrow", :publish_at => DateTime.tomorrow, :public => true
      
      # throw in some extra posts, just to keep it interesting
      Factory :post
      Factory :post, :publish_at => DateTime.yesterday
      Factory :post, :publish_at => DateTime.tomorrow
      
      Timecop.return
    end
    
    it "should include only published posts" do
      Post.published.size.should == 2
    end
    
    it "should include posts published before now" do
      Post.published.should include(@post2)
    end
    
    it "should exclude posts published after now" do
      Post.published.should_not include(@post3)
    end
    
  end
  
  context "tags" do
    
    #it "should create new teg terms as necessary"
    
    #it "should reuse existing tag terms where possible"
    
    #it "should remove tag terms no longer in use"
    
    #it "should reuse tagging associations where possible"
    
  end
  
end
