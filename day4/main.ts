import {createReadStream} from 'fs';
import {createInterface} from 'readline';

class Range {
    start: number;
    end: number;

    constructor(s: string) {
        let [startRaw, endRaw] = s.split("-");
        this.start = parseInt(startRaw);
        this.end = parseInt(endRaw);
    }

    public contains(other: Range): boolean {
        return this.start <= other.start && this.end >= other.end;
    }

    public overlaps(other: Range): boolean {
        let [smaller, larger] = this.start < other.start ? [this, other] : [other, this];

        if (smaller.start <= larger.start && larger.start <= smaller.end) {
            return true;
        } else if (smaller.start <= larger.end && larger.end <= smaller.end) {
            return true;
        }

        return false;
    }
}


let partOneScore = 0;
let partTwoScore = 0;

for await (const line of createInterface(createReadStream('data'))) {
    let [firstRangeRaw, secondRangeRaw] = line.split(",");
    let firstRange = new Range(firstRangeRaw);
    let secondRange = new Range(secondRangeRaw);

    if (firstRange.contains(secondRange) || secondRange.contains(firstRange)) {
        partOneScore++;
    }

    if (firstRange.overlaps(secondRange)) {
        partTwoScore++;
    }
}

console.log("Part one:", partOneScore);
console.log("Part two:", partTwoScore);