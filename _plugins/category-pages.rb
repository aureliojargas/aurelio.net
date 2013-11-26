module Jekyll

  class CategoryPage < Page
    def initialize(site, base, dir, category_data)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'category_index.html')
      self.data['category_slug'] = category_data[:slug]
      self.data['category_name'] = category_data[:name]
      self.data['category_desc'] = category_data[:desc]

      category_title_prefix = site.config['category_title_prefix'] || 'Category: '
      self.data['title'] = "#{category_title_prefix}#{category_data[:name]}"
    end
  end

  class CategoryPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'category_index'
        dir = site.config['category_dir'] || 'categories'
        categories_data = site.config['category_data'] || {}
        site.categories.keys.each do |category|
          cat_data = {
            :slug => category,
            :name => categories_data[category]['name'],
            :desc => categories_data[category]['desc'],
          }
          site.pages << CategoryPage.new(
            site,
            site.source,
            File.join(dir, cat_data[:slug]),
            cat_data
          )
        end
      end
    end
  end

end