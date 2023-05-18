/mob/living/silicon/robot/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(robot_resting)
		robot_resting = FALSE
		on_standing_up()
		update_icons()

/mob/living/silicon/robot/toggle_resting()
	robot_lay_down()

/mob/living/silicon/robot/on_lying_down(new_lying_angle)
	if(layer == initial(layer)) //to avoid things like hiding larvas.
		layer = LYING_MOB_LAYER //so mob lying always appear behind standing mobs
	density = FALSE // We lose density and stop bumping passable dense things.

/mob/living/silicon/robot/on_standing_up()
	if(layer == LYING_MOB_LAYER)
		layer = initial(layer)
	density = initial(density) // We were prone before, so we become dense and things can bump into us again.

/mob/living/silicon/robot/proc/rest_style()
	set name = "Switch Rest Style"
	set category = "AI Commands"
	set desc = "Select your resting pose."
	if(!can_rest())
		to_chat(src, span_warning("You can't do that!"))
		return
	var/choice = tgui_alert(src, "Select resting pose", "", list("Resting", "Sitting", "Belly up"))
	switch(choice)
		if("Resting")
			robot_rest_style = ROBOT_REST_NORMAL
		if("Sitting")
			robot_rest_style = ROBOT_REST_SITTING
		if("Belly up")
			robot_rest_style = ROBOT_REST_BELLY_UP
	robot_resting = robot_rest_style
	if (robot_resting)
		on_lying_down()
	update_icons()

/mob/living/silicon/robot/proc/robot_lay_down()
	set name = "Lay down"
	set category = "AI Commands"
	if(!can_rest())
		to_chat(src, span_warning("You can't do that!"))
		return
	if(stat != CONSCIOUS) //Make sure we don't enable movement when not concious
		return
	if(robot_resting)
		to_chat(src, span_notice("You are now getting up."))
		robot_resting = FALSE
		mobility_flags = MOBILITY_FLAGS_DEFAULT
		on_standing_up()
	else
		to_chat(src, span_notice("You are now laying down."))
		robot_resting = robot_rest_style
		on_lying_down()
	update_icons()

/mob/living/silicon/robot/update_resting()
	. = ..()
	if(can_rest())
		robot_resting = FALSE
		update_icons()

// EFFIGY TODO

/**
 * Safe check of the cyborg's model_features list.
 *
 * model_features is defined in packages\altborgs\code\modules\mob\living\silicon\robot\robot_model.dm.
 */
/mob/living/silicon/robot/proc/can_rest()
	if(model && model.model_features && (R_TRAIT_WIDE in model.model_features))
		if(TRAIT_IMMOBILIZED in status_traits)
			return FALSE
		return TRUE
	return FALSE
