class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]
  before_action :signed_in_user

  # GET /groups
  def index
    @groups = Group.alphabet_order.all.includes(:projects)
  end

  # GET /groups/1
  def show
    @projects = @group.projects.all
  end

  # GET /groups/new
  def new
    @group = current_user.author_groups.build
  end

  # GET /groups/1/edit
  def edit; end

  # POST /groups
  def create
    @group = current_user.author_groups.build(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_path }
        flash[:success] = 'Group was successfully created.'
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /groups/1
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group }
        flash[:success] = 'Group was successfully updated.'
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url }
      flash[:success] = 'Group was successfully destroyed.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
