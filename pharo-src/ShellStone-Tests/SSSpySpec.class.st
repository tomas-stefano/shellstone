"Specs for spies"
Class {
	#name : #SSSpySpec,
	#superclass : #SSSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
SSSpySpec class >> loadSpecs [
	SSWorld reset.

	SS describe: 'Spy' do: [ :spec |
		spec it: 'forwards messages to target' do: [
			| spy |
			spy := SS spyOn: 'hello'.
			(SS expect: spy asUppercase) to equal: 'HELLO'
		].

		spec it: 'records received messages' do: [
			| spy |
			spy := SS spyOn: 'hello'.
			spy asUppercase.
			spy asLowercase.
			(SS expect: (spy received: #asUppercase)) to beTrue.
			(SS expect: (spy received: #asLowercase)) to beTrue
		].

		spec it: 'tracks call count' do: [
			| arr spy |
			arr := OrderedCollection new.
			spy := SS spyOn: arr.
			spy add: 1.
			spy add: 2.
			(SS expect: (spy received: #add: times: 2)) to beTrue
		]
	].

	self collectExamples
]
