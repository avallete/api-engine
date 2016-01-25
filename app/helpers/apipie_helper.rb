# require 
module ApipieHelper
  include ActionView::Helpers::TagHelper

      SENTENCE_LINKER = ", associated with the given "
      HAS_PARENT_LINKER = "of the given "
      ACTION_HAS__PARENT_LINKER = "for the given "

  def heading(title, level=1)
    content_tag("h#{level}") do
      title
    end
  end

  def action_to_sentence action, name
    sing = "#{name.singularize.indefinite_article} #{name.downcase.singularize}"
    case action.to_s.downcase
    when "index"
      "Return all the #{name.downcase}"
    when "show"
      "Get #{sing}"
    when "create"
      "Create #{sing}"
    when "update"
      "Update #{sing}"
    when "destroy"
      "Destroy #{sing}"
    end
  end

  def auto_description resource, class_name, m
    end_sentence = resource[:api_url].scan(/:([\w]*)/).reverse.flatten.map(&:humanize)
    desc = action_to_sentence(m[:name], class_name)
    end_sentence.pop if end_sentence.last.try(:downcase) == "id"
    if end_sentence.count > 0
      sent = (['index', 'show'].include?(m[:name].to_s.downcase) ? HAS_PARENT_LINKER : ACTION_HAS__PARENT_LINKER)
      desc = "#{desc} #{sent} #{end_sentence.join(SENTENCE_LINKER)}"
    end
    desc
  end

end
