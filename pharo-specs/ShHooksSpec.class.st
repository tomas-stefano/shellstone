"Specs for hooks (before/after)"
Class {
	#name : #ShHooksSpec,
	#superclass : #ShSpecRunner,
	#classVars : [
		'HookCounter'
	],
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
ShHooksSpec class >> loadSpecs [
	ShWorld reset.
	HookCounter := 0.

	Sh describe: 'Hooks' do: [ :spec |
		spec before: #each do: [
			HookCounter := HookCounter + 1
		].

		spec it: 'runs before each example' do: [
			(Sh expect: HookCounter) to beGreaterThan: 0
		].

		spec it: 'runs before each example again' do: [
			(Sh expect: HookCounter) to beGreaterThan: 1
		].

		spec context: 'nested context' do: [ :ctx |
			ctx before: #each do: [
				"Child before hook"
			].

			ctx it: 'inherits parent before hooks' do: [
				(Sh expect: HookCounter) to beGreaterThan: 2
			]
		]
	].

	self collectExamples
]
