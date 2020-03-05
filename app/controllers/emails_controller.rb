require 'faker'

class EmailsController < ApplicationController
  def index
    @emails = Email.all
  end

  def create
    @email = Email.new(object: Faker::Company.buzzword, body: Faker::Lorem.paragraph, read: false)
    if @email.save
      respond_to do |format|
        format.html {
           flash[:notice] = "Email created"
           redirect_to root_path}
        format.js { }
      end
    end
   else
    flash[:danger] = "Email can't be created"
    
  end

  def show
    @email=Email.find(params["id"])
    @email.update(read: true)
    respond_to do |format|
      format.html {}
      format.js { }
    end
  end

  def destroy
    @email = Email.find(params["id"])
    @email.destroy
    respond_to do |format|
      format.html {flash[:notice] = "Email deleted"
      redirect_to root_path}
      format.js { }
    end
  end

  def update
    @email = Email.find(params["id"])
    @email.update(read: !@email.read)
    respond_to do |format|
      format.html {}
      format.js { }
    end
  end
end
