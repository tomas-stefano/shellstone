"Specs for hooks (before/after)"
Class {
	#name : #SSHooksSpec,
	#superclass : #SSSpecRunner,
	#classVars : [
		'HookCounter'
	],
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
SSHooksSpec class >> loadSpecs [
	SSWorld reset.
	HookCounter := 0.

	SS describe: 'Hooks' do: [ :spec |
		spec before: #each do: [
			HookCounter := HookCounter + 1
		].

		spec it: 'runs before each example' do: [
			(SS expect: HookCounter) to beGreaterThan: 0
		].

		spec it: 'runs before each example again' do: [
			(SS expect: HookCounter) to beGreaterThan: 1
		].

		spec context: 'nested context' do: [ :ctx |
			ctx before: #each do: [
				"Child before hook"
			].

			ctx it: 'inherits parent before hooks' do: [
				(SS expect: HookCounter) to beGreaterThan: 2
			]
		]
	].

	self collectExamples
]
