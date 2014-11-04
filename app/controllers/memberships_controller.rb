class MembershipsController < ApplicationController
  load_and_authorize_resource

  # GET /memberships/1
  def show
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  def create
    @membership = Membership.new(membership_params)

    if @membership.save
      redirect_to @membership, notice: 'Membership was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /memberships/1
  def update
    if @membership.update(membership_params)
      redirect_to @membership, notice: 'Membership was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /memberships/1
  def destroy
    @membership.destroy
    redirect_to memberships_url, notice: 'Membership was successfully destroyed.'
  end

  private
    # Only allow a trusted parameter "white list" through.
    def membership_params
      params.require(:membership).permit(:user_id, :group_id)
    end
end
