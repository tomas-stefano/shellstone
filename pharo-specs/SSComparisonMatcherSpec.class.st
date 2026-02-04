"Specs for comparison matchers using ShellStone DSL"
Class {
	#name : #SSComparisonMatcherSpec,
	#superclass : #SSSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
SSComparisonMatcherSpec class >> loadSpecs [
	SSWorld reset.

	SS describe: 'comparison matchers' do: [ :spec |
		spec context: 'beGreaterThan' do: [ :ctx |
			ctx it: 'passes when actual is greater' do: [
				(SS expect: 10) to beGreaterThan: 5
			].

			ctx it: 'fails when actual is less' do: [
				(SS expect: 3) toNot beGreaterThan: 5
			].

			ctx it: 'fails when equal' do: [
				(SS expect: 5) toNot beGreaterThan: 5
			]
		].

		spec context: 'beLessThan' do: [ :ctx |
			ctx it: 'passes when actual is less' do: [
				(SS expect: 3) to beLessThan: 10
			].

			ctx it: 'fails when actual is greater' do: [
				(SS expect: 15) toNot beLessThan: 10
			]
		].

		spec context: 'beGreaterThanOrEqualTo' do: [ :ctx |
			ctx it: 'passes when greater' do: [
				(SS expect: 10) to beGreaterThanOrEqualTo: 5
			].

			ctx it: 'passes when equal' do: [
				(SS expect: 5) to beGreaterThanOrEqualTo: 5
			].

			ctx it: 'fails when less' do: [
				(SS expect: 3) toNot beGreaterThanOrEqualTo: 5
			]
		].

		spec context: 'beLessThanOrEqualTo' do: [ :ctx |
			ctx it: 'passes when less' do: [
				(SS expect: 3) to beLessThanOrEqualTo: 5
			].

			ctx it: 'passes when equal' do: [
				(SS expect: 5) to beLessThanOrEqualTo: 5
			].

			ctx it: 'fails when greater' do: [
				(SS expect: 10) toNot beLessThanOrEqualTo: 5
			]
		]
	].

	self collectExamples
]
