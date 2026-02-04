"Specs for pending examples"
Class {
	#name : #SSPendingSpec,
	#superclass : #SSSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
SSPendingSpec class >> loadSpecs [
	SSWorld reset.

	SS describe: 'Pending' do: [ :spec |
		spec it: 'this is a pending example'.  "No block = pending"

		spec it: 'can use pending with message' do: [
			SSPendingExample signal: 'Not implemented yet'
		]
	].

	self collectExamples
]
