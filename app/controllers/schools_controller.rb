class SchoolsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  
  def index
    
  end
  
  def new
    if params[:step] == 'basic'
      @school = School.new
      @school.build_basic
      render :action => "basic"
      
    elsif params[:step] == 'traffic'
      @school = School.find(params[:sid])
      @school.build_traffic
      render :action => "traffic"
      
    elsif params[:step] == 'need'
      @school = School.find(params[:sid])
      @school.build_need
      render :action => "need"
      
    elsif params[:step] == 'other'
      @school = School.find(params[:sid])
      @school.build_contact
      @school.build_local
      @school.build_finder
      render :action => "other"
      
    else
      @school = School.new
      @school.build_basic
      render :action => "basic"
    end
  end
  
  def create
    if params[:step] == 'basic'
      @school = School.new(params[:school])
      @school.user = current_user
      @school.save!
      flash[:notice] = "学校基本信息已保存，请继续填写学校交通信息"
      redirect_to new_school_url(:step => 'traffic', :sid => @school.id)
      
    elsif params[:step] == 'traffic'
      @school = School.find(params[:school][:id])
      @school.traffic = SchoolTraffic.new
      @school.traffic.tag_list = params[:school][:school_traffic][:sight]
      @school.update_attributes!(params[:school])
      flash[:notice] = "学校交通信息已经保存，请继续填写学校的需求信息"      
      redirect_to new_school_url(:step => 'need', :sid => @school.id)
      
    elsif params[:step] == 'need'
      @school = School.find(params[:school][:id])
      @school.need = SchoolNeed.new

      new_tag_list = ""
      %w(urgency book stationary sport cloth accessory course teacher other).each do |need|
        new_tag_list += params[:school][:school_need][need.to_sym] unless params[:school][:school_need][need.to_sym].nil?
      end

      @school.need.tag_list = new_tag_list
      @school.update_attributes!(params[:school])
      flash[:notice] = "学校需求信息已经保存，请填写最后一项"
      redirect_to new_school_url(:step => 'other', :sid => @school.id)
      
    elsif params[:step] == 'other'
      @school = School.find(params[:school][:id])
      @school.update_attributes!(params[:school])
      flash[:notice] = "提交学校成功，谢谢你！"
      redirect_to school_url(@school)
    else
      # TODO add some catch exception
    end
  end
  
  def show
    @school = School.find(params[:id])
    @board = SchoolBoard.find(:first, :conditions => {:school_id => @school.id}).board
    @topics = @board.topics.find(:all, :order => "updated_at desc", :limit => 10)
  end
  
  
  def info
    @school = School.find(params[:id])
    
    if params[:type] == "traffic"
      @type = "traffic"
      @traffic = @school.traffic
    elsif params[:type] == "need"
      @type = "need"
      @need = @school.need
    elsif params[:type] == "local"
      @type = "local"
      @local   = @school.local
    elsif params[:type] == "contact"
      @type = "contact"
      @contact = @school.contact
      @finder  = @school.finder
    else
      # params[:type] == 'basic' or whatever
      @type = "basic"
      @basic = @school.basic
    end
  end
  
  
end