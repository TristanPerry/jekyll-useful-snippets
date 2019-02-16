module Jekyll

  class LazyloadImagesEmbed < Liquid::Tag
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
        return "Error processing input, expected syntax: {% lazyload-image imageurl altdesc optionalclass %}"
      end

      #render the markup
      parameters = split_params(@markup)

      if parameters.length < 2
        return "Error processing input, expected syntax: {% lazyload-image imageurl altdesc optionalclass %}"
      end

      image_url = parameters[0].strip
      alt_desc = parameters[1].strip
      class_value = parameters[2].nil? ? "" : parameters[2]

      output = "<img data-src=\"#{image_url}\" alt=\"#{alt_desc}\" title=\"#{alt_desc}\" class=\"#{class_value}\" />"
      output += "<noscript><img src=\"#{image_url}\" alt=\"#{alt_desc}\" title=\"#{alt_desc}\" class=\"#{class_value}\" /></noscript>"
      return output
    end
  end
end

Liquid::Template.register_tag("lazyload_image", Jekyll::LazyloadImagesEmbed)