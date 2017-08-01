class ContactsController < ApplicationController
 
 # GET request to /contact-us
 # Show new contact form
  def new
    @contact = Contact.new
  end
  
  # POST requests /contacts
  # mass assignment of form fields into Contact object
def create
  @contact = Contact.new(contact_params)
  # Save the Contact object to the database
  if @contact.save
    # Store form fields via perameters, into variables
    name = params[:contact][:name]
    email = params[:contact][:email]
    body = params[:contact][:contacts]
    # Plug variables into Contact Mailer method and send email
    ContactMailer.contact_email(name, email, body).deliver
    # Store sucess message in flash hash and redirect to new method
     flash[:success] = "Message sent."
     redirect_to new_contact_path
  else
    # If Contact Object doesn't save, save errors in flash hash
    # and redirect to the new object
      flash[:danger] = @contact.errors.full_messages.join(", ")
     redirect_to new_contact_path 
  end
end

private
  # To collect data from form, we need to use
  # strong perameters and whitelist form fields
  def contact_params
     params.require(:contact).permit(:name, :email, :comments)
  end
end