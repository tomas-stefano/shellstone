"Specs for change matcher using ShellStone DSL"
Class {
	#name : #SSChangeMatcherSpec,
	#superclass : #SSSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
SSChangeMatcherSpec class >> loadSpecs [
	SSWorld reset.

	SS describe: 'change matcher' do: [ :spec |
		spec context: 'basic change detection' do: [ :ctx |
			ctx it: 'passes when value changes' do: [
				| counter |
				counter := 0.
				(SS expect: [ counter := counter + 1 ]) to change: [ counter ]
			].

			ctx it: 'fails when value does not change' do: [
				| counter |
				counter := 0.
				(SS expect: [ 1 + 1 ]) toNot change: [ counter ]
			]
		].

		spec context: 'with collection' do: [ :ctx |
			ctx it: 'detects size change' do: [
				| list |
				list := OrderedCollection new.
				(SS expect: [ list add: 1 ]) to change: [ list size ]
			]
		]
	].

	self collectExamples
]
