"Specs for include matcher using ShellStone DSL"
Class {
	#name : #ShIncludeMatcherSpec,
	#superclass : #ShSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
ShIncludeMatcherSpec class >> loadSpecs [
	ShWorld reset.

	Sh describe: 'include matcher' do: [ :spec |
		spec context: 'with arrays' do: [ :ctx |
			ctx it: 'passes when array includes item' do: [
				(Sh expect: #(1 2 3)) to include: 2
			].

			ctx it: 'fails when array does not include item' do: [
				(Sh expect: #(1 2 3)) toNot include: 5
			]
		].

		spec context: 'with strings' do: [ :ctx |
			ctx it: 'passes when string includes substring' do: [
				(Sh expect: 'hello world') to include: 'world'
			].

			ctx it: 'fails when string does not include substring' do: [
				(Sh expect: 'hello world') toNot include: 'foo'
			]
		]
	].

	self collectExamples
]
