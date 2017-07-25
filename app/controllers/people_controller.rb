class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @people = Person.all
    @group = Group.find(params[:group_id])
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])
    @group = Group.find(params[:group_id])
  end

  # GET /people/new
  def new
    @person = Person.new
    @group = Group.find(params[:group_id])
  end

  # GET /people/1/edit
  def edit
    @people = Person.all
    @group = Group.find(params[:group_id])
  end

  # POST /people
  # POST /people.json
  def create
    @group = Group.find(params[:group_id])
    @person = @group.people.build(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to group_people_path(@group), notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    @group = Group.find(params[:group_id])
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to group_people_path(@group), notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @group = Group.find(params[:group_id])
    @person.destroy
    respond_to do |format|
      format.html { redirect_to group_people_path(@group), notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :group_id)
    end
end
