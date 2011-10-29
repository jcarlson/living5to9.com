require 'spec_helper'

describe Permalink do
  
  it "should require a slug" do
    subject.should have(1).error_on(:slug)
  end
  
end
