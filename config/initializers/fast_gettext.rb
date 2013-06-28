FastGettext.add_text_domain 'app', :path => 'config/locales', :type => :po
FastGettext.default_available_locales = ['fa'] #all you want to allow
FastGettext.default_text_domain = 'app'

module FastGettext


  module Storage
    def find(key)
      current_repository[key] || false
    end

    @@dynamic_cache = {}
    def dynamic_cache
      @@dynamic_cache
    end

    def find_dynamic(key)

      if @@dynamic_cache[text_domain].nil?

        @@dynamic_cache[text_domain] = {locale => {}}
        translation = nil

      else

        translation = @@dynamic_cache[text_domain][locale][key]

      end

      if translation.nil?
        translation = find(key) || false

        if translation
          @@dynamic_cache[text_domain][locale][key] = String.new(translation)
          return translation

        else

          return key
        end
      end

      translation
    end

  end

  module Translation
    extend self


    def p_(key, contexts = {})

      translation = FastGettext.find_dynamic(key)

      contexts.each do |k, v|
        translation.gsub!("\%{#{k}}", v.to_s)
      end

      translation
    end

    def pp_(key, contexts = {})
      FastGettext.expire_cache_for(key) unless contexts.empty?
      translation = String.new(FastGettext.find(key))

      contexts.each do |k, v|
        translation.gsub!("\%{#{k}}", v.to_s)
      end

      translation
    end

  end

end
