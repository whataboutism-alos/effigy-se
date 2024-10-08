
/datum/admins/proc/create_mob(mob/user)
	var/static/create_mob_html
	if (!create_mob_html)
		var/mobjs = null
		mobjs = jointext(typesof(/mob), ";")
		create_mob_html = file2text('html/create_object.html')
		create_mob_html = replacetext(create_mob_html, "Create Object", "Create Mob")
		create_mob_html = replacetext(create_mob_html, "null /* object types */", "\"[mobjs]\"")

	user << browse(create_panel_helper(create_mob_html), "window=create_mob;size=425x475")

/**
 * Fully randomizes everything about a human, including DNA and name.
 */
/proc/randomize_human(mob/living/carbon/human/human, randomize_mutations = FALSE)
	human.gender = human.dna.species.sexes ? pick(MALE, FEMALE, PLURAL, NEUTER) : PLURAL
	human.physique = human.gender
	human.real_name = human.generate_random_mob_name()
	human.name = human.get_visible_name()
	human.set_hairstyle(random_hairstyle(human.gender), update = FALSE)
	human.set_facial_hairstyle(random_facial_hairstyle(human.gender), update = FALSE)
	human.set_haircolor("#[random_color()]", update = FALSE)
	human.set_facial_haircolor(human.hair_color, update = FALSE)
	human.eye_color_left = random_eye_color()
	human.eye_color_right = human.eye_color_left
	human.skin_tone = pick(GLOB.skin_tones)
	human.dna.species.randomize_active_underwear_only(human)
	// Needs to be called towards the end to update all the UIs just set above
	human.dna.initialize_dna(newblood_type = random_blood_type(), create_mutation_blocks = randomize_mutations, randomize_features = TRUE)
	// EffigyEdit Add - Customization
	human.dna.species.mutant_bodyparts = human.dna.mutant_bodyparts.Copy()
	human.dna.species.body_markings = human.dna.body_markings.Copy()
	// EffigyEdit Add End
	// Snowflake stuff (ethereals)
	human.updatehealth()
	human.updateappearance(mutcolor_update = TRUE)

/**
 * Randomizes a human, but produces someone who looks exceedingly average (by most standards).
 *
 * (IE, no wacky hair styles / colors)
 */
/proc/randomize_human_normie(mob/living/carbon/human/human, randomize_mutations = FALSE)
	var/static/list/natural_hair_colors = list(
		"#111111", "#362925", "#3B3831", "#41250C", "#412922",
		"#544C49", "#583322", "#593029", "#703b30", "#714721",
		"#744729", "#74482a", "#7b746e", "#855832", "#863019",
		"#8c4734", "#9F550E", "#A29A96", "#A4381C", "#B17B41",
		"#C0BAB7", "#EFE5E4", "#F7F3F1", "#FFF2D6", "#a15537",
		"#a17e61", "#b38b67", "#ba673c", "#c89f73", "#d9b380",
		"#dbc9b8", "#e1621d", "#e17d17", "#e1af93", "#f1cc8f",
		"#fbe7a1",
	)
	// Sorry enbys but statistically you are not average enough
	human.gender = human.dna.species.sexes ? pick(MALE, FEMALE) : PLURAL
	human.physique = human.gender
	human.real_name = human.generate_random_mob_name()
	human.name = human.get_visible_name()
	human.eye_color_left = random_eye_color()
	human.eye_color_right = human.eye_color_left
	human.skin_tone = pick(GLOB.skin_tones)
	// No underwear generation handled here
	var/picked_color = pick(natural_hair_colors)
	human.set_haircolor(picked_color, update = FALSE)
	human.set_facial_haircolor(picked_color, update = FALSE)
	var/datum/sprite_accessory/hairstyle = GLOB.hairstyles_list[random_hairstyle(human.gender)] // EffigyEdit Change - Original: SSaccessories.hairstyles_list
	if(hairstyle?.natural_spawn)
		human.set_hairstyle(hairstyle.name, update = FALSE)
	var/datum/sprite_accessory/facial_hair = GLOB.facial_hairstyles_list[random_facial_hairstyle(human.gender)] // EffigyEdit Change - Original: SSaccessories.facial_hairstyles_list
	if(facial_hair?.natural_spawn)
		human.set_facial_hairstyle(facial_hair.name, update = FALSE)
	// Normal DNA init stuff, these can generally be wacky but we care less, they're aliens after all
	human.dna.initialize_dna(newblood_type = random_blood_type(), create_mutation_blocks = randomize_mutations, randomize_features = TRUE)
	human.updatehealth()
	human.updateappearance(mutcolor_update = TRUE)
