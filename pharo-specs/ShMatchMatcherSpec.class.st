"Specs for match matcher using ShellStone DSL"
Class {
	#name : #ShMatchMatcherSpec,
	#superclass : #ShSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
ShMatchMatcherSpec class >> loadSpecs [
	ShWorld reset.

	Sh describe: 'match matcher' do: [ :spec |
		spec it: 'passes when string contains pattern' do: [
			(Sh expect: 'hello world') to match: 'world'
		].

		spec it: 'passes for partial match' do: [
			(Sh expect: 'user@example.com') to match: '@example'
		].

		spec it: 'fails when pattern not found' do: [
			(Sh expect: 'hello world') toNot match: 'foo'
		].

		spec it: 'is case sensitive' do: [
			(Sh expect: 'Hello World') toNot match: 'hello'
		]
	].

	self collectExamples
]
