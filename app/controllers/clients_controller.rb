class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @clients = Client.includes(:addresses).order(:first_name)
  end

  def show; end

  def new
    @client = Client.new
    @client.addresses.build
    @client.emails.build
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @client.update(client_params)
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @client.destroy
    redirect_to clients_url, notice: 'Client was successfully destroyed.'
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(
      :first_name, :last_name, :telephone,
      addresses_attributes: [:id, :street, :city, :state, :zip_code, :country, :primary, :_destroy],
      emails_attributes: [:id, :address, :primary, :_destroy]
    )
  end
  
end
