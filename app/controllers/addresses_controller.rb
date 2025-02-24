class AddressesController < ApplicationController
  before_action :set_addressable

  def new
    @address = @addressable.addresses.build
  end

  def create
    @address = @addressable.addresses.build(address_params)
    if @address.save
      redirect_to @addressable, notice: 'Address added successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @address = @addressable.addresses.find(params[:id])
  end

  def update
    @address = @addressable.addresses.find(params[:id])
    if @address.update(address_params)
      redirect_to @addressable, notice: 'Address updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @address = @addressable.addresses.find(params[:id])
    @address.destroy
    redirect_to @addressable, notice: 'Address deleted successfully.'
  end

  private

  def set_addressable
    @addressable = find_addressable
  end

  def find_addressable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def address_params
    params.require(:address).permit(:street, :city, :state, :zip_code, :country)
  end
end
