class PokemonSave_Scene
  def pbStartScreen
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @sprites={}
	# colors
	bwbaseColor    = Color.new(80,80,88)
    bwshadowColor  = Color.new(160,160,168)
    bw2baseColor   = Color.new(231,231,231)
    bw2shadowColor = Color.new(140,140,140)
    totalsec = Graphics.frame_count / Graphics.frame_rate
    hour = totalsec / 60 / 60
    min = totalsec / 60 % 60
    mapname=$game_map.name
    time=_ISPRINTF("{1:02d}:{2:02d}",hour,min)
    datenow=_ISPRINTF("{2:d} {1:s} {3:d}",
    pbGetAbbrevMonthName($PokemonGlobal.pbGetTimeNow.mon),
    $PokemonGlobal.pbGetTimeNow.day,
    $PokemonGlobal.pbGetTimeNow.year)
    @sprites["bg"]=IconSprite.new(0,0,@viewport)
	
	case UI_Save::BGSTYLE
    when 0
      @sprites["bg"].setBitmap("Graphics/UI/Save/bw_background")
	  base = bwbaseColor
	  shadow = bwshadowColor
    when 1
      @sprites["bg"].setBitmap("Graphics/UI/Save/bw2_background")
	  base = bw2baseColor
	  shadow = bw2shadowColor
    end 
	
    # Creating Party Icons.
    if $player
      if $player.party.length>0
        for i in 0...$player.party.length
          @sprites["pokemon#{i}"]=PokemonIconSprite.new($player.party[i],@viewport)
          @sprites["pokemon#{i}"].x = 64+64*(i)
          @sprites["pokemon#{i}"].y = 122
        end
      end
    end
    @sprites["overlay"]=BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    overlay = @sprites["overlay"].bitmap
    overlay.clear
    
    pbSetSystemFont(@sprites["overlay"].bitmap)
    textos=[]

	textos.push([_ISPRINTF("{1:02d} : {2:02d}", Time.now.hour, Time.now.min),256,7,2,base,shadow]) if UI_Save::CLOCK
	textos.push([_INTL("Badges: {1}",$player.badge_count),48,205,false,base,shadow])
	textos.push([_INTL("Pokédex: {1}", $player.pokedex.seen_count),256,205,false,base,shadow])
	textos.push([_INTL("{1}",$game_map.name),48,90,false,base,shadow])
	textos.push([_INTL("Time: {1}", time),48,236,false,base,shadow])
	textos.push([_INTL("{1}", datenow),46,58,false,base,shadow])
	pbDrawTextPositions(overlay,textos) 		
  end
  
end

