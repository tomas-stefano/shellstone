"Specs for be matcher using ShellStone DSL"
Class {
	#name : #SSBeMatcherSpec,
	#superclass : #SSSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
SSBeMatcherSpec class >> loadSpecs [
	SSWorld reset.

	SSDescribe the: 'be matcher' do: [ :spec |
		spec context: 'beTruthy' do: [ :ctx |
			ctx it: 'passes for true' do: [
				(SSExpectationTarget for: true) to beTruthy
			].

			ctx it: 'passes for non-nil values' do: [
				(SSExpectationTarget for: 1) to beTruthy.
				(SSExpectationTarget for: 'text') to beTruthy
			].

			ctx it: 'fails for false' do: [
				(SSExpectationTarget for: false) toNot beTruthy
			].

			ctx it: 'fails for nil' do: [
				(SSExpectationTarget for: nil) toNot beTruthy
			]
		].

		spec context: 'beFalsy' do: [ :ctx |
			ctx it: 'passes for false' do: [
				(SSExpectationTarget for: false) to beFalsy
			].

			ctx it: 'passes for nil' do: [
				(SSExpectationTarget for: nil) to beFalsy
			].

			ctx it: 'fails for true' do: [
				(SSExpectationTarget for: true) toNot beFalsy
			]
		].

		spec context: 'beNil' do: [ :ctx |
			ctx it: 'passes for nil' do: [
				(SSExpectationTarget for: nil) to beNil
			].

			ctx it: 'fails for non-nil' do: [
				(SSExpectationTarget for: 1) toNot beNil
			]
		]
	].

	self collectExamples
]
