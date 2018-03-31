# BlogML import script originally sourced from:
#   https://github.com/philippkueng/philippkueng.github.com/tree/30ef1570f06d33938b18d5eee7767d6641b9a779/source/_import
# Best post I could find about how to use it was here:
#   http://philippkueng.ch/migrate-from-blogengine-dot-net-to-jekyll.html
#
# how to install
# --------------
#   mkdir source/_importer
#   cp blogml.rb to the source/_importer/ you created above
#   cp your BlogML.xml to the same source/_importer/ directory
#
# make sure to change the "categories" output at the end of this script
# to be the final resting place of your imported posts.  i chose to put mine
# all into the /blog/archives/ folder personally.  by using categories like
# this, it uses the folder structure for all posts to render in that one
# directory.
#
# if you, on the other hand, want to retain your categories as categories
# in your new blog, feel free to remove the TAGs portion and copy it to the
# CATEGORIES portion in the final output below.  It will render the categories
# per your BlogML.
#
# how to run
# --------------
# I prefer this method below so you can run the importer multiple times without
# effecting any new and existing posts you may have created.  because the import
# BLOWS OUT YOUR _posts FOLDER!
#   cd source/_importer/
#   ruby -r './blogml.rb' -e 'Jekyll::BlogML.process()'
#
# that will execute the script only with that folder
#
# change Log by eduncan911:
#
# 2014-04-08
#   added "alias: " to output, changed old_url to be an array with the original old_url as well as a lowercased version
#   added "date: " to output
#   added "tags: " to output to read from categories (since I abused that 10 years ago)
#      you can change this to "categories: " easily and have the same array for them
#   added "published: " to output
#

module Jekyll

  require 'rexml/document'
  require 'time'
  require 'YAML'
  require 'fileutils'
  require 'base64'

  module BlogML
    #Reads posts from an BlogML dump.
    #It creates a post file for each entry in the dump.
    def self.process(source = "BlogML.xml")
      FileUtils.rmtree "_posts"
      FileUtils.mkdir_p "_posts"
      content = ""
      open(source, "r") { |f| content << f.read }

        # first, we need to parse the existing categories into a known hash for later lookup
        cats = Hash.new
        catdoc = REXML::Document.new(content)
        catdoc.elements.each("blog/categories/category") do |category|
          cats[category.attributes["id"]] = category.elements["title"].text
        end
        puts "Categories found: #{cats.values}"

        doc = REXML::Document.new(content)
        posts = 0
        doc.elements.each("blog/posts/post") do |item|

          puts
          link = item.attributes["post-url"]

          title = item.elements["title"].text
          puts "        title: #{title}"

          # Use the URL after the last slash as the post's name
          name = link.split("/")[-1]
          puts "original name: #{name}"

          # Lowercase name for uniformity
          name.downcase!

          # Remove extensions (.html, .aspx, etc)
          name = $1 if name =~ /(.*)\.(.*)/
          puts "  parsed name: #{name}"

          # # Remove the leading digits and dash that Serendipity adds
          # name = $1 if name =~ /\d+\-(.*)/
          # puts "name 3: #{name}"
          # puts "name: #{name}"

          ## an important note. my blogml.xml had a few spaces and \r\n before
          # the <![CDATA[ markers in the content.  this caused the Ruby REXML parser
          # to ignore all content within element.  i had to remove all of those
          # in order for this line to parse.
          content = Base64.decode64(item.elements["content"].text)

          ## i'd like to cut off old content from showing in the blog roll. since
          # it requires <!-- more --> to be inserted, we'll just do it at the
          # very top.  someone with more time can make it insert after the first
          # paragraph or something.
          content = "<!-- more -->\r\n" + content + "\r\n\r\n"

          ## This section is used to cleanup any content data.
          #
          # Replace blockquote with code (as i used blockquote mostly for code formatting)
          content.gsub!(/<blockquote>\s*<p>/, "<p><code>")
          content.gsub!(/<\/p>\s*<\/blockquote>/, "</code><\/p>")

          # Replace /image.axd?picture= with /images/
          content.gsub!(/\/image\.axd\?picture\=/, "/assets/archive/")
          # Replace /file.axd?file= with /files/
          # content.gsub!(/\/file\.axd\?file\=/, "/assets/")
          # Replace encoded /'s with real thing
          #content.gsub!(/\%2f/, "/")
          content.gsub!(/http:\/\/www.ntsystems.it/, "")  # remove the domain from my links and images
          content.gsub!(/http:\/\/ntsystems.it/, "")  # remove the domain from my links and images
          content.gsub!(/https:\/\/www.ntsystems.it/, "")  # remove the domain from my links and images
          content.gsub!(/https:\/\/ntsystems.it/, "")  # remove the domain from my links and images

          ## is this published?
          ## published = item.attributes["approved"]
          ## puts "published: #{published}"

          timestamp = Time.parse(item.attributes["date-created"])
          puts "timestamp: #{timestamp}"

          # post_file_name = "#{timestamp.strftime("%Y-%m-%d")}-#{name}"
          #filename = "_posts/#{timestamp.strftime("%Y-%m-%d")}-#{name}.html"
          filename = "_posts/#{timestamp.strftime("%Y-%m-%d")}-#{name}.md"
          puts "filename: #{filename}"

          ## Keep old URL but remove .aspx
          # old_url = name
          # htaccess.puts "RewriteRule ^#{name}$ "
          # for GitHub pages, we need to setup an alias
          old_url = [ item.attributes["post-url"].gsub!(/\.aspx/,"") ]
          if item.attributes["post-url"] != item.attributes["post-url"].downcase
            old_url.push(item.attributes["post-url"].downcase)
          end
          #old_url = old_url.gsub!(/\.aspx/,"")
          puts "old_url: #{old_url}"

          # since BlogML doesn't support tags, and I haphazardly used categories as tags,
          # we are going to read categories and use them as tags.
          tags = Array.new
          item.elements.each("categories/category") do |category|
            tags.push(cats[category.attributes["ref"]])
          end
          puts "tags: #{tags}"

          #author = item.elements["authors"]
          #puts "author: #{author}"

          author = String.new
          item.elements.each("authors/author") do |author_name|
            author = author_name.attributes["ref"].downcase
          end
          puts "author: #{author}"

          # puts "#{link} -> #{filename}"
          File.open(filename, "w") do |f|
            # YAML.dump(
            #   {
            #     "layout" => "default",
            #     # "name" => name,
            #     "title" => title,
            #     # "time" => timestamp,
            #   },
            f.puts <<-HEADER
---
layout: post
title: "#{title}"
date: #{timestamp.strftime("%Y-%m-%d %H:%M:%S %z")}
comments: true
category: Archive
tags: #{tags}
redirect_from: #{old_url}
author: #{author}
---
            HEADER
            # f.puts
            # )
            # f.puts "---\n#{content}"
            f.puts content
          end
          posts += 1
        end
        puts "Created #{posts} posts!"
    end
  end
end
