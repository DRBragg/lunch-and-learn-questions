class AshContactsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_ash_contact, only: [:show, :edit, :update, :destroy]

  # GET /ash_contacts
  def index
    @ash_contacts = AshContact.all
  end

  # GET /ash_contacts/1
  def show
  end

  # GET /ash_contacts/new
  def new
    @ash_contact = AshContact.new
  end

  # GET /ash_contacts/1/edit
  def edit
  end

  # POST /ash_contacts
  def create
    @ash_contact = AshContact.new(ash_contact_params)

    respond_to do |format|
      if @ash_contact.save
        format.html { redirect_to @ash_contact, notice: 'Contact was successfully created.'}
        format.json { render json: @ash_contact }
      else
        format.html { render :new }
        format.json { render json: @ash_contact.errors }
      end
    end
  end

  # PATCH/PUT /ash_contacts/1
  def update
    if @ash_contact.update(ash_contact_params)
      redirect_to @ash_contact, notice: 'Ash contact was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ash_contacts/1
  def destroy
    @ash_contact.destroy
    redirect_to ash_contacts_url, notice: 'Ash contact was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ash_contact
      @ash_contact = AshContact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ash_contact_params
      params.require(:ash_contact).permit(:email, :trial)
    end
end
