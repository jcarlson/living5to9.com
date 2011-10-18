require 'spec_helper'

describe Post do
  
  context "published scope" do
    
    before do
      Timecop.freeze DateTime.now.beginning_of_day
      @post1 = Factory :post, :title => "No publication date"
      @post2 = Factory :post, :title => "Published yesterday", :publish_date => DateTime.yesterday
      @post3 = Factory :post, :title => "Published tomorrow", :publish_date => DateTime.tomorrow
      Timecop.return
    end
    
    it "should include only published posts" do
      Post.published.size.should == 2
    end
    
    it "should include posts with no publication date" do
      Post.published.should include(@post1)
    end
    
    it "should include posts published before now" do
      Post.published.should include(@post2)
    end
    
    it "should exclude posts published after now" do
      Post.published.should_not include(@post3)
    end
    
  end
  
end
