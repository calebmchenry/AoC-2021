
function main() {
  // part1();
  part2();
}

// function part1() {
//   const movements = Deno.readFileSync("input.txt")
//     .toString()
//     .split("\n")
//     .map((l) => l.split(" "))
//     .map(([d, n]) => [d, parseInt(n)]);
//   console.log(movements);
//   const horizontal = movements
//     .filter(([direction]) => direction === "forward")
//     .map(([, num]) => num)
//     .reduce((prev, current) => prev + current);
//   const depth = movements
//     .filter(([direction]) => direction !== "forward")
//     .map(([d, num]) => (d === "down" ? num : -1 * num))
//     .reduce((prev, current) => prev + current);
//   console.log(horizontal * depth);
// }

async function part2() {
  type Accumulation = {
    horizontal: number;
    depth: number;
    aim: number;
  }

  type Instruction = {
    direction: 'down' | 'forward' | 'up';
    value: number;
  }

  function toInstruction(str: string): Instruction {
    console.log(str);
    const split = str.split(' ');
    return {
      // @ts-expect-error
      direction: split[0],
      value: parseInt(split[1]),
    }
  }

  const instructions = (await Deno.readTextFile("./input.txt"))
    .split("\n")
    .map(toInstruction)

    const initial: Accumulation =  {horizontal: 0, depth: 0, aim: 0}
    console.log(instructions);
    const result = instructions.reduce((acc, instruction) => {
      console.log(acc);
      switch(instruction.direction) {
        case 'down':
          return {...acc, aim: acc.aim + instruction.value}
        case 'up':
          return {...acc, aim: acc.aim - instruction.value}
        case 'forward':
          return {...acc, horizontal: acc.horizontal + instruction.value, depth: acc.depth + acc.aim * instruction.value }
        default: 
          return acc
      }
    }, initial)
    console.log("part2: ", result.depth * result.horizontal)
}

main();
