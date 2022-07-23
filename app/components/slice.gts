import Component from '@glimmer/component';
import dateToDegrees from 'liturgical-year/utils/date-to-degrees';

interface Args {
  width: number;
	radius: number;
	innerRadius: number;
	donutWidth:number;
	range: [startDate: Date, endDate: Date];
	color: string;
	name: string;
}

interface Point {
	x: number;
	y:number;
}

export default class Slice extends Component<Args> {
	end: Point;
	start:Point;
	innerEnd: Point;
	innerStart: Point;
	offset: number;
	largeArc: 1 | 0;
	color: string;

	constructor(owner, args: Args) {
		super(owner, args);
		const {start, end} = calculateRadius(args.range);
		const diff = end - start;
		const largeArc = diff > 180 ? 1 : 0;

		this.end = getCoordFromDegrees(end, args.radius, args.donutWidth);
		this.innerEnd = getCoordFromDegrees(end, args.radius - args.width, args.donutWidth);
	
		this.start = getCoordFromDegrees(start, args.radius, args.donutWidth);
		this.innerStart = getCoordFromDegrees(start, args.radius - args.width, args.donutWidth);

		this.largeArc = largeArc;
		this.color = args.color ?? 'tomato';
	}

	<template>
		<path
			fill={{this.color}}
			d="
				M {{this.start.x}} {{this.start.y}}
				A {{@radius}} {{@radius}} 0 {{this.largeArc}} 0 {{this.end.x}} {{this.end.y}}
				L {{this.innerEnd.x}} {{this.innerEnd.y}}
				A {{@innerRadius}} {{@innerRadius}} 0 {{this.largeArc}} 1 {{this.innerStart.x}} {{this.innerStart.y}}
			"
			id={{@name}}
			...attributes
		/>
	
		{{#if @name}}
			<text width="80" height="80"   dominant-baseline="top" text-anchor="top" >
				<textpath alignment-baseline="top"  dominant-baseline="middle" text-anchor="middle" href="#{{@name}}">
					{{@name}}
				</textpath>
			</text>
		{{/if}}
	</template>
}

function calculateRadius(range: [startDate: Date, endDate: Date]) {
	const [start, end] = range;

	return {
		start: Math.floor(dateToDegrees(start)),
		end: Math.ceil(dateToDegrees(end))
	};
}

function getCoordFromDegrees(angle: number, radius: number, svgSize: number): Point {
  const x = Math.cos(angle * Math.PI / 180);
  const y = Math.sin(angle * Math.PI / 180);
  const coordX = x * radius + svgSize / 2;
  const coordY = y * -radius + svgSize / 2;
  return {x:coordX, y:coordY};
}
