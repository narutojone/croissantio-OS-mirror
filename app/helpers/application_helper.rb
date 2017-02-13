module ApplicationHelper
  def table_hidden?
    'col-hidden' if @action == 'Edit'
  end

  def form_hidden?
    'col-hidden' if @action != 'Edit'
  end
end
