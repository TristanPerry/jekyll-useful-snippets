module Jekyll

  class FrequentlyAskedQuestionBlock < Liquid::Tag
    @markup = nil

    def initialize(tag_name, markup, tokens)
      #strip leading and trailing spaces
      @markup = markup.strip
      super
    end

    def split_params(params)
      params.split("|")
    end

    def render(context)
      if @markup.empty?
        return "Error processing input, expected syntax: {% faq [array] %}"
      end

      #render the markup
      parameters = split_params(@markup)

      if parameters.length != 1
        return "Error processing input, expected syntax: {% faq [array] %}"
      end

      faq_data = JSON.parse("#{context[parameters[0]]}")
      output = ""

      faq_data.each_with_index do |faq, index|
        question_answer = split_params(faq)
        question = question_answer[0].strip
        answer = question_answer[1].strip
        html_before = question_answer[2] ? question_answer[2].strip : ""

        output += "#{html_before}\n"
        output += "<section class='faq' itemscope itemprop='mainEntity' itemtype='https://schema.org/Question'>\n"
        output += "<h1 itemprop='name'>#{question}</h1>\n"
        output += "<div class='softwaresummary' itemscope itemprop='acceptedAnswer' itemtype='http://schema.org/Answer'>\n"
        output += "    <p itemprop='text'>#{answer}</p>\n"
        output += "</div>\n"
        output += "</section>"
      end


      return output
    end
  end
end

Liquid::Template.register_tag("faq", Jekyll::FrequentlyAskedQuestionBlock)