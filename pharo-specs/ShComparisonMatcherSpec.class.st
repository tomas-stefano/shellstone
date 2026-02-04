"Specs for comparison matchers using ShellStone DSL"
Class {
	#name : #ShComparisonMatcherSpec,
	#superclass : #ShSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
ShComparisonMatcherSpec class >> loadSpecs [
	ShWorld reset.

	Sh describe: 'comparison matchers' do: [ :spec |
		spec context: 'beGreaterThan' do: [ :ctx |
			ctx it: 'passes when actual is greater' do: [
				(Sh expect: 10) to beGreaterThan: 5
			].

			ctx it: 'fails when actual is less' do: [
				(Sh expect: 3) toNot beGreaterThan: 5
			].

			ctx it: 'fails when equal' do: [
				(Sh expect: 5) toNot beGreaterThan: 5
			]
		].

		spec context: 'beLessThan' do: [ :ctx |
			ctx it: 'passes when actual is less' do: [
				(Sh expect: 3) to beLessThan: 10
			].

			ctx it: 'fails when actual is greater' do: [
				(Sh expect: 15) toNot beLessThan: 10
			]
		].

		spec context: 'beGreaterThanOrEqualTo' do: [ :ctx |
			ctx it: 'passes when greater' do: [
				(Sh expect: 10) to beGreaterThanOrEqualTo: 5
			].

			ctx it: 'passes when equal' do: [
				(Sh expect: 5) to beGreaterThanOrEqualTo: 5
			].

			ctx it: 'fails when less' do: [
				(Sh expect: 3) toNot beGreaterThanOrEqualTo: 5
			]
		].

		spec context: 'beLessThanOrEqualTo' do: [ :ctx |
			ctx it: 'passes when less' do: [
				(Sh expect: 3) to beLessThanOrEqualTo: 5
			].

			ctx it: 'passes when equal' do: [
				(Sh expect: 5) to beLessThanOrEqualTo: 5
			].

			ctx it: 'fails when greater' do: [
				(Sh expect: 10) toNot beLessThanOrEqualTo: 5
			]
		]
	].

	self collectExamples
]
