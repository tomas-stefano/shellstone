"Specs for be matcher using ShellStone DSL"
Class {
	#name : #SSBeMatcherSpec,
	#superclass : #SSSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
SSBeMatcherSpec class >> loadSpecs [
	SSWorld reset.

	SS describe: 'be matcher' do: [ :spec |
		spec context: 'beTruthy' do: [ :ctx |
			ctx it: 'passes for true' do: [
				(SS expect: true) to beTruthy
			].

			ctx it: 'passes for non-nil values' do: [
				(SS expect: 1) to beTruthy.
				(SS expect: 'text') to beTruthy
			].

			ctx it: 'fails for false' do: [
				(SS expect: false) toNot beTruthy
			].

			ctx it: 'fails for nil' do: [
				(SS expect: nil) toNot beTruthy
			]
		].

		spec context: 'beFalsy' do: [ :ctx |
			ctx it: 'passes for false' do: [
				(SS expect: false) to beFalsy
			].

			ctx it: 'passes for nil' do: [
				(SS expect: nil) to beFalsy
			].

			ctx it: 'fails for true' do: [
				(SS expect: true) toNot beFalsy
			]
		].

		spec context: 'beNil' do: [ :ctx |
			ctx it: 'passes for nil' do: [
				(SS expect: nil) to beNil
			].

			ctx it: 'fails for non-nil' do: [
				(SS expect: 1) toNot beNil
			]
		]
	].

	self collectExamples
]
