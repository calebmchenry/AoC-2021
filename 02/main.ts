function main() {
  const instructions = (await Deno.readTextFile("./input.txt"))
    .split("\n")
    .map(toInstruction);
  part1(instructions);
  part2(instructions);
}

type Accumulation = {
  horizontal: number;
  depth: number;
  aim: number;
};

type Instruction = {
  direction: "down" | "forward" | "up";
  value: number;
};

async function part1(instructions: Instruction[]) {
  const initial: Accumulation = { horizontal: 0, depth: 0, aim: 0 };
  const result = instructions.reduce((acc, instruction) => {
    switch (instruction.direction) {
      case "down":
        return { ...acc, depth: acc.depth + instruction.value };
      case "up":
        return { ...acc, depth: acc.depth - instruction.value };
      case "forward":
        return { ...acc, horizontal: acc.horizontal + instruction.value };
      default:
        return acc;
    }
  }, initial);
  console.log("part1: ", result.depth * result.horizontal);
}

async function part2(instructions: Instruction[]) {
  const initial: Accumulation = { horizontal: 0, depth: 0, aim: 0 };
  const result = instructions.reduce((acc, instruction) => {
    switch (instruction.direction) {
      case "down":
        return { ...acc, aim: acc.aim + instruction.value };
      case "up":
        return { ...acc, aim: acc.aim - instruction.value };
      case "forward":
        return {
          ...acc,
          horizontal: acc.horizontal + instruction.value,
          depth: acc.depth + acc.aim * instruction.value,
        };
      default:
        return acc;
    }
  }, initial);
  console.log("part2: ", result.depth * result.horizontal);
}

function toInstruction(str: string): Instruction {
  const split = str.split(" ");
  return {
    // @ts-expect-error
    direction: split[0],
    value: parseInt(split[1]),
  };
}
main();
