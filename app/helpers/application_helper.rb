module ApplicationHelper
  def sortable(column)
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to sort: column, direction: direction do
      content_tag(:span, column, class: css_class)
    end
  end
end
