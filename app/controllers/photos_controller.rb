class PhotosController < InheritedResources::Base

  actions :show

  def latest
    @photo = Photo.released.first
    show! {|format|
      format.html { render :action => 'show' }
    }
  end

end
