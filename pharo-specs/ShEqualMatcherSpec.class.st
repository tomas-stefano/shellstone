"Specs for equal matcher using ShellStone DSL"
Class {
	#name : #ShEqualMatcherSpec,
	#superclass : #ShSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
ShEqualMatcherSpec class >> loadSpecs [
	ShWorld reset.

	Sh describe: 'equal matcher' do: [ :spec |
		spec context: 'with identical values' do: [ :ctx |
			ctx it: 'passes for equal integers' do: [
				(Sh expect: 1) to equal: 1
			].

			ctx it: 'passes for equal strings' do: [
				(Sh expect: 'hello') to equal: 'hello'
			].

			ctx it: 'passes for equal arrays' do: [
				(Sh expect: #(1 2 3)) to equal: #(1 2 3)
			]
		].

		spec context: 'with different values' do: [ :ctx |
			ctx it: 'passes with toNot for unequal values' do: [
				(Sh expect: 1) toNot equal: 2
			].

			ctx it: 'passes with toNot for different strings' do: [
				(Sh expect: 'hello') toNot equal: 'world'
			]
		]
	].

	self collectExamples
]
