"Specs for equal matcher using ShellStone DSL"
Class {
	#name : #SSEqualMatcherSpec,
	#superclass : #SSSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
SSEqualMatcherSpec class >> loadSpecs [
	SSWorld reset.

	SSDescribe the: 'equal matcher' do: [ :spec |
		spec context: 'with identical values' do: [ :ctx |
			ctx it: 'passes for equal integers' do: [
				(SS expect: 1) to equal: 1
			].

			ctx it: 'passes for equal strings' do: [
				(SS expect: 'hello') to equal: 'hello'
			].

			ctx it: 'passes for equal arrays' do: [
				(SS expect: #(1 2 3)) to equal: #(1 2 3)
			]
		].

		spec context: 'with different values' do: [ :ctx |
			ctx it: 'passes with toNot for unequal values' do: [
				(SS expect: 1) toNot equal: 2
			].

			ctx it: 'passes with toNot for different strings' do: [
				(SS expect: 'hello') toNot equal: 'world'
			]
		]
	].

	self collectExamples
]
