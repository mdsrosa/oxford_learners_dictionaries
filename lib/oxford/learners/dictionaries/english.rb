module Oxford
  module Learners
    module Dictionaries
      class English
        attr_reader :definition, :word, :page

        def initialize word
          @word = word
          @page = Nokogiri::HTML(open("http://www.oxfordlearnersdictionaries.com/definition/english/#{word}"))
          @definition = Hash.new
          parse
        end

        private
        def parse
          if @page.css(".n-g").count > 0
            multiple_definitions
          else
            unique_definition
          end
        end

        def unique_definition
          @definition[:definition] = @page.css(".d").text
        end

        def multiple_definitions
          @page.css(".n-g").each_with_index do |definition, index|
            @definition["definition_#{index}".to_sym] = definition.css(".d").text
          end
        end

      end
    end
  end
end

# definition.css(".x-g").each do |examples|
#   puts "# #{examples.css(".x").text}"
# end
