class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
    

  def index
    @schedules = Schedule.all    
  end

  def new
    @schedule = Schedule.new
  end
  
  #GET /schedules/1
  #GET /schedules/1.json
  def show    
  end

  # GET /schedules/1/edit
  def edit
    #render :text=>'edit'
  end
  
  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)
    
    respond_to do |format|
      if @schedule.save
        sign_in @schedule
        #redirect_to schedules_path, notice: "#{@schedule.start_time}を登録しました。"
        format.html {redirect_to @schedule, notice: 'Schedule was successfully created.'}
        format.json {render :show, status: :created, location: @schedule}
      else
        #render :new
        format.html {render :new}
        format.json {render json: @schedule.errors, status: :unprocessable_entity}
      end
    end
  end
  
  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule.destroy
    respond_to do |format|      
      format.html { redirect_to schedules_url, notice: 'Schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  
  private
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def schedule_params
      params.require(:event_start, :event_end, :venue).permit(:member_id, :event_start, :event_end, :venue)
    end
  
end
