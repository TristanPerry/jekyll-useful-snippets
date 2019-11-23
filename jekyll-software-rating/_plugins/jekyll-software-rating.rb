module Jekyll

  class SoftwareRatingEmbed < Liquid::Tag
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
        return "Error processing input, expected syntax: {% rating name url rating price os review %}"
      end

      #render the markup
      parameters = split_params(@markup)

      if parameters.length < 6
        return "Error processing input, expected syntax: {% rating name url rating price os review %}"
      end

      product_name = parameters[0].strip
      url = parameters[1].strip
      rating = parameters[2].strip
      price = parameters[3].strip
      supported_os = parameters[4].strip
      review_body = parameters[5].strip

      output = "<section class='review' itemscope itemtype='http://schema.org/Review'>\n"
      output += "<h1>#{product_name} -  <span class='reviewRating' itemprop='reviewRating' itemscope itemtype='http://schema.org/Rating'>\n"
      output += "                    <span itemprop='ratingValue'>#{rating}</span>/<span itemprop='bestRating'>10</span>\n"
      output += "                </span></h1>\n"
      output += "<div class='softwaresummary' itemprop='itemReviewed' itemscope itemtype='http://schema.org/SoftwareApplication'>\n"
      output += "    <link itemprop='applicationCategory' href='https://schema.org/DesignApplication'/>\n"
      output += "    <ul>\n"
      output += "        <li><strong>Software:</strong> <span itemprop='name'><a href='#{url}' title='Go to website for #{product_name}' target='_blank'>#{product_name}</a></span></li>\n"
      output += "        <li><strong>OS:</strong> <span itemprop='operatingSystem'>#{supported_os}</span></li>\n"
      output += "        <li itemprop='offers' itemscope itemtype='https://schema.org/Offer'>\n"
      output += "            <strong>Price:</strong> $<span itemprop='price'>#{price}</span>\n"
      output += "            <meta itemprop='priceCurrency' content='USD' />\n"
      output += "        </li>\n"
      output += "    </ul>\n"
      output += "</div>\n"
      output += "<p class='author' itemprop='author' itemscope itemtype='http://schema.org/Person'>\n"
      output += "    <strong>Reviewer:</strong> <span itemprop='name'>Tristan Perry</span>\n"
      output += "</p>\n"
      output += "<p class='reviewsummary' itemprop='reviewBody'>\n"
      output += "    #{review_body}\n"
      output += "</p>\n"
      output += "</section>"
      return output
    end
  end
end

Liquid::Template.register_tag("rating", Jekyll::SoftwareRatingEmbed)