require 'json'

module Jekyll

  class ImageGalleryEmbed < Liquid::Tag
    @markup = nil

    def initialize(tag_name, markup, tokens)
      #strip leading and trailing spaces
      @markup = markup.strip
      super
    end

    def split_params(params)
      params.split("|")
    end

    def change_last_string_occurence(old_str, pattern, replacement)
      old_str.reverse.sub(pattern.reverse, replacement.reverse).reverse
    end

    def render(context)
      if @markup.empty?
        return "Error processing input, expected syntax: {% image_gallery [array] %}"
      end

      #render the markup
      parameters = split_params(@markup)

      if parameters.length != 1
        return "Error processing input, expected syntax: {% image_gallery [array] %}"
      end

      gallery_data = JSON.parse("#{context[parameters[0]]}")
      main_image = split_params(gallery_data[0])

      output = "<section class=\"gallery\">\n"
      output += "<figure class=\"full\" onclick=\"return changeImage(event);\">\n"
      output += "<img data-src=\"#{main_image[0]}\" alt=\"#{main_image[1]}\" title=\"#{main_image[1]}\" />\n"
      output += "<noscript><img src=\"#{main_image[0]}\" alt=\"#{main_image[1]}\" title=\"#{main_image[1]}\" /></noscript>\n"
      output += "</figure>\n"
      output += "<figure class=\"thumbnails\">\n"

      #for image_data in gallery_data do
      gallery_data.each_with_index do |image_data, index|
        image = split_params(image_data)
        thumbnail_url = change_last_string_occurence(image[0], '/', '/thumbs/')
        first_markup = index == 0 ? "class=\"active\"" : ""

        output += "<img data-src=\"#{thumbnail_url}\" #{first_markup} alt=\"#{image[1]}\" title=\"#{image[1]}\" />"
      end

      output += "<figcaption>Click on the thumbnail to see the larger image, or click the photo itself to move to the previous/next photo.</figcaption>\n"
      output += "</figure>\n"
      output += "</section>\n"

      return output
    end
  end
end

Liquid::Template.register_tag("image_gallery", Jekyll::ImageGalleryEmbed)