"Specs for spies"
Class {
	#name : #ShSpySpec,
	#superclass : #ShSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
ShSpySpec class >> loadSpecs [
	ShWorld reset.

	Sh describe: 'Spy' do: [ :spec |
		spec it: 'forwards messages to target' do: [
			| spy |
			spy := Sh spyOn: 'hello'.
			(Sh expect: spy asUppercase) to equal: 'HELLO'
		].

		spec it: 'records received messages' do: [
			| spy |
			spy := Sh spyOn: 'hello'.
			spy asUppercase.
			spy asLowercase.
			(Sh expect: (spy received: #asUppercase)) to beTrue.
			(Sh expect: (spy received: #asLowercase)) to beTrue
		].

		spec it: 'tracks call count' do: [
			| arr spy |
			arr := OrderedCollection new.
			spy := Sh spyOn: arr.
			spy add: 1.
			spy add: 2.
			(Sh expect: (spy received: #add: times: 2)) to beTrue
		]
	].

	self collectExamples
]
