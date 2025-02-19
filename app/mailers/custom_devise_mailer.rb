class CustomDeviseMailer < Devise::Mailer
  default template_path: "devise/mailer" # Force it to use the project folder
end
