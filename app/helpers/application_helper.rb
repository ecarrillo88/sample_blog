module ApplicationHelper
  def pluralize_phrase(number, word)
    number == 1 ? "#{number} #{word}" : "#{number} #{word.pluralize}"
  end
end
