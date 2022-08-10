module ApplicationHelper
  include Pagy::Frontend

  def full_title page_title
    base_title = "Movie booking"
    page_title.empty? ? base_title : [page_title, base_title].join(" | ")
  end
end
