require 'set'
require 'fileutils'

require 'redcarpet'

require 'active_support/core_ext/string/output_safety'
require 'active_support/core_ext/object/blank'
require 'action_controller'
require 'action_view'

require File.join(File.dirname(__FILE__), 'helpers')

module ColombianProgrammingContests
  class Generator
    attr_reader :guides_dir, :source_dir, :output_dir
    GUIDES_RE = /\.(?:md|html\.erb)$/

    def initialize(output=nil)
      initialize_dirs(output)
      create_output_dirs_if_needed
    end

    def generate
      generate_guides
      copy_assets
    end

    private
    def initialize_dirs(output)
      @guides_dir = File.join(File.dirname(__FILE__), ".")
      @source_dir = File.join(@guides_dir, "source")
      @output_dir = output || File.join(@guides_dir, "output")
    end

    def create_output_dirs_if_needed
      FileUtils.mkdir_p(output_dir)
      guides_to_generate.each do |guide|
        FileUtils.mkdir_p(File.join(output_dir, File.dirname(guide)))
      end
    end

    def copy_assets
      FileUtils.cp_r(Dir.glob("#{guides_dir}/assets/*"), output_dir)
    end
    
    def generate_guides
      guides_to_generate.each do |guide|
        output_file = output_file_for(guide)
        generate_guide(guide, output_file) if generate?(guide, output_file)
      end
    end

    def guides_to_generate
      guides = Dir.glob(File.join(source_dir, "**", "*")).grep(GUIDES_RE)
      guides.map { |g| g.gsub(source_dir, "") }
    end

    def output_file_for(guide)
      guide.sub(GUIDES_RE, '.html')
    end

    def generate?(source_file, output_file)
      fin  = File.join(source_dir, source_file)
      fout = File.join(output_dir, output_file)
      !File.exists?(fout) || File.mtime(fout) < File.mtime(fin)
      true
    end

    def generate_guide(guide, output_file)
      puts "Generating #{output_file}"
      File.open(File.join(output_dir, output_file), 'w') do |f|
        view = ActionView::Base.new(source_dir)
        view.extend(Helpers)

        if guide =~ /\.html\.erb$/
          # Generate the special pages like the home.
          result = view.render(:layout => 'layout', :file => guide)
        else
          body = File.read(File.join(source_dir, guide))
          # Render index
          view.content_for(:index_section) { Redcarpet::Markdown.new(Redcarpet::Render::HTML_TOC).render(body).html_safe }
          # Render content
          markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true, :superscript => true)
          body = markdown.render(view.render(:inline => body))
          result = view.render(:layout => 'layout', :text => body)
        end
        f.write result
      end
    end
  end
end