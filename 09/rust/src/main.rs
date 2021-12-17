use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;

fn main() {
    println!("part 1: {:?}", part1());
}

fn read_lines<P>(filename: P) -> io::Lines<io::BufReader<File>>
where
    P: AsRef<Path>,
{
    match File::open(filename) {
        Ok(file) => io::BufReader::new(file).lines(),
        Err(_) => panic!("Could not find file!"),
    }
}

fn part1() -> u32 {
    let mut local_mins: Vec<u32> = vec![];
    let nss: Vec<Vec<u32>> = read_lines("../input.txt")
        .filter_map(|line| line.ok())
        .map(|line| line.chars().filter_map(|c| c.to_digit(10)).collect())
        .collect();
    println!("{:?}", nss);
    for (i, ns) in nss.iter().enumerate() {
        for (j, &n) in ns.iter().enumerate() {
            let mut adjacent_numbers: Vec<Option<&u32>> = vec![];
            if i > 0 {
                adjacent_numbers.push(nss.get(i - 1).map(|numbers| numbers.get(j)).flatten());
            }
            if j > 0 {
                adjacent_numbers.push(nss.get(i).map(|numbers| numbers.get(j - 1)).flatten());
            }
            adjacent_numbers.push(nss.get(i).map(|numbers| numbers.get(j + 1)).flatten());
            adjacent_numbers.push(nss.get(i + 1).map(|numbers| numbers.get(j)).flatten());
            if adjacent_numbers.len() == 0 {
                println!("oh no!")
            }
            println!("{:?}", adjacent_numbers.iter().filter_map(|&x| x).collect::<Vec<&u32>>());
            let min = adjacent_numbers
                .iter()
                .filter_map(|&n| n)
                .fold(u32::MAX, |acc, &number| u32::min(acc, number));

            if n < min {
                local_mins.push(n);
            }
        }
    }
    println!("{:?}", local_mins);
    local_mins.iter().map(|n| n + 1).sum()
}

