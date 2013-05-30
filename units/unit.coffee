class Unit
	constructor: (@hp, @name, @pos) ->
		@target = null

	moveTo: (pos, y) ->
		# TODO: Process some lerp for this method
		if y
			@pos = 
				x: pos,
				y: y
		else
			@pos = pos

	setTarget: (@target) ->

	target: ->
		return @target

	# Default attack code
	attack: (target) ->
		# Default to attacking our target
		unless target
			target = @target

		# Generate a random damage amount
		damage = @randomAttackDamage()

		# Trigger our own callback
		this.onAttack target, damage
		# Trigger the target's callback
		target.onAttacked this, damage

	# Default attack damage
	randomAttackDamage: ->
		return 1

	# Attack Callbacks
	onAttacked: (attacker, damage, damageType = 'attacked') ->
		console.log "#{attacker} #{damageType} you for #{ damage } health."

		@hp -= damage

	onAttack: (target, damage, damageType = 'attacked') ->
		console.log "You #{damageType} #{attacker} for #{ damage } health."

module.exports = Unit