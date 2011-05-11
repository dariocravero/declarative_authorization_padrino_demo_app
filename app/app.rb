class DeclarativeAuthorizationPadrinoDemoApp < Padrino::Application
  register Padrino::Mailer
  register Padrino::Helpers
  register Authorization::Padrino

  # Since we don't do auth here, include our CurrentUser helper so that things work for the controllers...
  helpers Authorization::Padrino::CurrentUser

  enable :sessions
end
