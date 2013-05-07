ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :user_name            => "cmu.is.272",  
  :password             => "272.is.cmu",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}