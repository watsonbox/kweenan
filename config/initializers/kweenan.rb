PRODUCTION_USER = 'frederic.pelouze@yahoo.fr'
PRODUCTION_PASSWORD = 'thecorner'

# Support cascading translations
I18n::Backend::Simple.send(:include, I18n::Backend::Cascade)
ActionView::Base.class_eval do
  def translate(key, options = {})
    super(key, options.merge(:cascade => true))
  end
  alias t translate
end