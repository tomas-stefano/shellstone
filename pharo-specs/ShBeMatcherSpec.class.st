"Specs for be matcher using ShellStone DSL"
Class {
	#name : #ShBeMatcherSpec,
	#superclass : #ShSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
ShBeMatcherSpec class >> loadSpecs [
	ShWorld reset.

	Sh describe: 'be matcher' do: [ :spec |
		spec context: 'beTruthy' do: [ :ctx |
			ctx it: 'passes for true' do: [
				(Sh expect: true) to beTruthy
			].

			ctx it: 'passes for non-nil values' do: [
				(Sh expect: 1) to beTruthy.
				(Sh expect: 'text') to beTruthy
			].

			ctx it: 'fails for false' do: [
				(Sh expect: false) toNot beTruthy
			].

			ctx it: 'fails for nil' do: [
				(Sh expect: nil) toNot beTruthy
			]
		].

		spec context: 'beFalsy' do: [ :ctx |
			ctx it: 'passes for false' do: [
				(Sh expect: false) to beFalsy
			].

			ctx it: 'passes for nil' do: [
				(Sh expect: nil) to beFalsy
			].

			ctx it: 'fails for true' do: [
				(Sh expect: true) toNot beFalsy
			]
		].

		spec context: 'beNil' do: [ :ctx |
			ctx it: 'passes for nil' do: [
				(Sh expect: nil) to beNil
			].

			ctx it: 'fails for non-nil' do: [
				(Sh expect: 1) toNot beNil
			]
		]
	].

	self collectExamples
]
