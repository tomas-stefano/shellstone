"Specs for respondTo matcher using ShellStone DSL"
Class {
	#name : #ShRespondToMatcherSpec,
	#superclass : #ShSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
ShRespondToMatcherSpec class >> loadSpecs [
	ShWorld reset.

	Sh describe: 'respondTo matcher' do: [ :spec |
		spec it: 'passes when object responds to selector' do: [
			(Sh expect: 'hello') to respondTo: #size
		].

		spec it: 'passes for collection methods' do: [
			(Sh expect: #(1 2 3)) to respondTo: #first.
			(Sh expect: #(1 2 3)) to respondTo: #do:
		].

		spec it: 'fails when object does not respond' do: [
			(Sh expect: 42) toNot respondTo: #asUppercase
		].

		spec it: 'works with symbols' do: [
			(Sh expect: Object new) to respondTo: #class.
			(Sh expect: Object new) to respondTo: #yourself
		]
	].

	self collectExamples
]
