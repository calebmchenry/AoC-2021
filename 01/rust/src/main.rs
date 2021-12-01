use std::fs;

fn main() {
    let contents = fs::read_to_string("../input.txt").unwrap();
    let lines: Vec<&str> = contents.split('\n').collect();
    let numbers = lines.iter().map(|l| l.parse::<i32>().unwrap()).collect();
    println!("part 1: {:?}", part1(&numbers));
    println!("part 2: {:?}", part2(&numbers));
}

fn part1(numbers: &Vec<i32>) -> usize {
    let tail = &numbers[1..];
    let it = tail.iter().zip(numbers.iter());

    it.map(|(x, y)| x - y).filter(|&n| n > 0).count()
}

fn part2(numbers: &Vec<i32>) -> usize {
    let ns = numbers
        .windows(3)
        .map(|w| w.iter().sum())
        .collect::<Vec<i32>>();
    part1(&ns)
}
