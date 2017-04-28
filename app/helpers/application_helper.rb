module ApplicationHelper

  def active_class(controller)
    'link--active' if params[:controller] == controller
  end

end
