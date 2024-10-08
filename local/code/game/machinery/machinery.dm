/obj/machinery/power/emitter
	icon = 'local/icons/obj/engine/emitter.dmi'

/obj/machinery/field/containment
	icon = 'local/icons/obj/engine/emitter.dmi'

/obj/machinery/power/rad_collector
	icon = 'local/icons/obj/engine/emitter.dmi'

/*
#ifndef UNIT_TESTS
/obj/machinery/light_switch/post_machine_initialize()
	. = ..()
	if(prob(70) && area.lightswitch) //70% chance for area to start with lights off.
		turn_off()
#endif
*/

/obj/machinery/light_switch/proc/turn_off()
	if(!area.lightswitch)
		return
	area.lightswitch = FALSE
	area.update_icon()

	for(var/obj/machinery/light_switch/light_switch in area)
		light_switch.update_icon()

	area.power_change()

/obj/machinery/door/poddoor
	var/door_sound = 'local/icons/obj/doors/blast_door.ogg' //lolwut

/obj/machinery/door/poddoor/shutters
	var/door_open_sound = 'local/icons/obj/doors/shutters_open.ogg'
	var/door_close_sound = 'local/icons/obj/doors/shutters_close.ogg'

/obj/machinery/firealarm
	icon = 'local/icons/obj/firealarm.dmi'
