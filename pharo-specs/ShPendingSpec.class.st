"Specs for pending examples"
Class {
	#name : #ShPendingSpec,
	#superclass : #ShSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
ShPendingSpec class >> loadSpecs [
	ShWorld reset.

	Sh describe: 'Pending' do: [ :spec |
		spec it: 'this is a pending example'.  "No block = pending"

		spec it: 'can use pending with message' do: [
			ShPendingExample signal: 'Not implemented yet'
		]
	].

	self collectExamples
]
