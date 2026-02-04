"Specs for respondTo matcher using ShellStone DSL"
Class {
	#name : #SSRespondToMatcherSpec,
	#superclass : #SSSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
SSRespondToMatcherSpec class >> loadSpecs [
	SSWorld reset.

	SS describe: 'respondTo matcher' do: [ :spec |
		spec it: 'passes when object responds to selector' do: [
			(SS expect: 'hello') to respondTo: #size
		].

		spec it: 'passes for collection methods' do: [
			(SS expect: #(1 2 3)) to respondTo: #first.
			(SS expect: #(1 2 3)) to respondTo: #do:
		].

		spec it: 'fails when object does not respond' do: [
			(SS expect: 42) toNot respondTo: #asUppercase
		].

		spec it: 'works with symbols' do: [
			(SS expect: Object new) to respondTo: #class.
			(SS expect: Object new) to respondTo: #yourself
		]
	].

	self collectExamples
]
