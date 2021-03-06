class Api::CharactersController < ApplicationController
  # skip_before_action :verify_authenticity_token
  # This was due to commenting-out the second line of application_controller o.O
  # include authenticate_user

  def index
    # render json: "message: Chaotic Evil is bad"
    # authenticate_user
    # user = current_user
    # p user
    # userid = user.adminid
    # p admin
    # This is where the man-through-many comes in
    if current_user
      # @characters = Character.all
      # @characters = Character.where(user_id: 1)
      # @characters = Character.where(user_id: current_user.id)
      @characters = current_user.characters
      render "index.json.jb"
    else
      @characters = []
      render json: { message: "Access Denied (Index)" }
    end
  end

  def create
    if current_user
      @character = Character.new(
        # userid: params[:userid],
        user_id: current_user.id,
        cfirstname: params[:cfirstname],
        cmiddlename: params[:cmiddlename],
        clastname: params[:clastname],
        raceid: params[:raceid],
        classid: params[:classid],
        alignmentid: params[:alignmentid],
        languageid: params[:languageid],
        inventoryid: params[:inventoryid],
        strength: params[:strength],
        dexterity: params[:dexterity],
        constitution: params[:constitution],
        intelligence: params[:intelligence],
        wisdom: params[:wisdom],
        charisma: params[:charisma],
        healthmax: params[:healthmax],
        healthcurrent: params[:healthcurrent],
        healthtemp: params[:healthtemp],
        speed: params[:speed],
        origin_story: params[:origin_story],
      )
      if @character.save
        render "show.json.jb"
      else
        render json: { errors: @character.errors.full_messages }, status: :unprocessable_entity
      end
    else
      @character = []
      render json: { message: "Access Denied (Create)" }
    end
  end

  def show
    if current_user
      @character = Character.find_by(id: params[:id])
      render "show.json.jb"
    else
      @character = []
      render json: { message: "Access Denied (Show)" }
    end
  end

  # MAKE SURE TO NOT PUT COMMAS FOR THE UPDATE ... IT'S NOT AN OBJECT n BECAUSE "REASONS" VARIABLES CREATED OUTSIDE OF OBJECTS DON'T NEED THIS SEPERATION ... IS THIS RUBY-SPECIFIC???
  def update
    if current_user
      @character = Character.find(params[:id])
      @character.userid = params[:userid] || @character.userid
      @character.cfirstname = params[:cfirstname] || @character.cfirstname
      @character.cmiddlename = params[:cmiddlename] || @character.cmiddlename
      @character.clastname = params[:clastname] || @character.clastname
      @character.raceid = params[:raceid] || @character.raceid
      @character.classid = params[:classid] || @character.classid
      @character.alignmentid = params[:alignmentid] || @character.alignmentid
      @character.languageid = params[:languageid] || @character.languageid
      @character.inventoryid = params[:inventoryid] || @character.inventoryid
      @character.strength = params[:strength] || @character.strength
      @character.dexterity = params[:dexterity] || @character.dexterity
      @character.constitution = params[:constitution] || @character.constitution
      @character.intelligence = params[:intelligence] || @character.intelligence
      @character.wisdom = params[:wisdom] || @character.wisdom
      @character.charisma = params[:charisma] || @character.charisma
      @character.healthmax = params[:healthmax] || @character.healthmax
      @character.healthcurrent = params[:healthcurrent] || @character.healthcurrent
      @character.healthtemp = params[:healthtemp] || @character.healthtemp
      @character.speed = params[:speed] || @character.speed
      @character.origin_story = params[:origin_story] || @character.origin_story

      # if @character.save && current_user
      if @character.save
        render "show.json.jb"
      else
        render json: { errors: @character.errors.full_messages }, status: :unprocessable_entity
      end
    else
      @character = []
      render json: { message: "Access Denied (Update" }
    end
  end

  def destroy
    if current_user
      character = Character.find(params[:id])
      character.destroy
      render json: { message: "Successfully Destroyed the Character" }
    else
      render json: { message: "Access Denied (Destroy)" }
    end
  end
end
