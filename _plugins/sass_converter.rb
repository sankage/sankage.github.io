module Jekyll
  class SassConverter < Converter
    require 'sass'
    safe true
    priority :low

    def matches(ext)
      ext =~ /scss/i
    end

    def output_ext(ext)
      ".css"
    end

    def convert(content)
      begin
        puts "Performing Sass Conversion."
        engine = Sass::Engine.new(content, syntax: :scss, load_paths: ["./css/"], style: :compact)
        engine.render
      rescue StandardError => e
        puts "!!! SASS Error: " + e.message
      end
    end
  end
end
