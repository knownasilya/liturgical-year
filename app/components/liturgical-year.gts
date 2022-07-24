import Component from '@glimmer/component';
import {previousSunday, subWeeks, subDays, addDays} from 'date-fns';
import dateToDegrees from 'liturgical-year/utils/date-to-degrees';
import getEaster from 'liturgical-year/utils/get-easter';
import Slice from './slice';
import styles from './liturgical-year.css';

const WIDTH = 30;
const INNER_RRADIUS = 20;
const RADIUS = 50;
const DONUT_WIDTH = 100;
const OFFSET = 90;
const VIEWBOX = 100;

export interface Signature {
  Element: SVGElement;
  Args: {}
}
export type Range = [Date, Date];

export default class LiturgicalYear extends Component<Signature> {
  today = new Date();
  year = this.today.getFullYear();
  previousYear = this.year - 1;
  easter = getEaster(this.year);
  ashWednesday = subDays(this.easter, 46);
  // Slices
  advent: Range = [this.previousAdvent, new Date(`dec 24 ${this.previousYear}`)];
  christmastide: Range = [new Date(`dec 25 ${this.previousYear}`), new Date(`jan 5 ${this.year}`)];
  ordinary1: Range = [new Date(`jan 6 ${this.year}`), this.ashWednesday];
  lent: Range = [this.ashWednesday, this.easter];
  eastertide: Range = [this.easter, addDays(this.easter, 50)];
  ordinary2: Range = [addDays(this.easter, 50), this.nextAdvent];

  get offsetDeg() {
    const degrees = dateToDegrees(this.previousAdvent);
    
    return Math.round(degrees - OFFSET);
  }

  get previousAdvent() {
    const sundayBefore = previousSunday(new Date(`dec 25 ${this.previousYear}`));
    const startOfAdvent = subWeeks(sundayBefore, 3);

    return startOfAdvent;
  }

  get nextAdvent() {
    const sundayBefore = previousSunday(new Date(`dec 25 ${this.year}`));
    const startOfAdvent = subWeeks(sundayBefore, 3);

    return startOfAdvent;
  }

  <template>
    <svg class={{styles.donut}} viewBox="0 0 {{VIEWBOX}} {{VIEWBOX}}" width="400" ...attributes>
      <g 
        transform='scale(-1, 1) rotate({{this.offsetDeg}})'
      >
        <Slice 
          @width={{WIDTH}} 
          @radius={{RADIUS}} 
          @innerRadius={{INNER_RRADIUS}}
          @donutWidth={{DONUT_WIDTH}} 
          @range={{this.advent}} 
          @color='#374e94'
          @name="Advent"
        />

        <Slice 
          @width={{WIDTH}} 
          @radius={{RADIUS}} 
          @innerRadius={{INNER_RRADIUS}}
          @donutWidth={{DONUT_WIDTH}} 
          @range={{this.christmastide}} 
          @color='#ba9f4e'
        />

        <Slice 
          @width={{WIDTH}} 
          @radius={{RADIUS}} 
          @innerRadius={{INNER_RRADIUS}}
          @donutWidth={{DONUT_WIDTH}} 
          @range={{this.ordinary1}} 
          @color='#c2e8d8'
        />

        <Slice 
          @width={{WIDTH}} 
          @radius={{RADIUS}} 
          @innerRadius={{INNER_RRADIUS}}
          @donutWidth={{DONUT_WIDTH}} 
          @range={{this.lent}} 
          @color='#a8768b'
        />

        <Slice 
          @width={{WIDTH}} 
          @radius={{RADIUS}} 
          @innerRadius={{INNER_RRADIUS}}
          @donutWidth={{DONUT_WIDTH}} 
          @range={{this.eastertide}} 
          @color='#fad35f'
        />

        <Slice 
          @width={{WIDTH}} 
          @radius={{RADIUS}} 
          @innerRadius={{INNER_RRADIUS}}
          @donutWidth={{DONUT_WIDTH}} 
          @range={{this.ordinary2}} 
          @color='#c2e8d8'
        />
        
        <circle cx={{RADIUS}} cy={{RADIUS}} r="35" fill='transparent' stroke='#f8f7f4'/>
        <circle cx={{RADIUS}} cy={{RADIUS}} r="20" fill='transparent' stroke='#f8f7f4'/>
      </g>
    </svg>
  </template>
}