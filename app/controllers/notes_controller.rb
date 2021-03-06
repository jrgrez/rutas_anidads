class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    @person = Person.find(params[:person_id])
    @notes = @person.notes
    @group = Group.find(params[:group_id])
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note = Note.find(params[:id])
    @group = Group.find(params[:group_id])
    @person = Person.find(params[:person_id])
  end

  # GET /notes/new
  def new
    @note = Note.new
    @group = Group.find(params[:group_id])
    @person = Person.find(params[:person_id])
  end

  # GET /notes/1/edit
  def edit
    @notes = Note.all
    @group = Group.find(params[:group_id])
    @person = Person.find(params[:person_id])
  end

  # POST /notes
  # POST /notes.json
  def create
    @group = Group.find(params[:group_id])
    @person = Person.find(params[:person_id])
    @note = @person.notes.build(note_params)
    respond_to do |format|
      if @note.save
        format.html { redirect_to group_person_notes_path(@group, @person), notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:content, :person_id)
    end
end
