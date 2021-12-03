use std::fs;

fn main() {
    let contents = fs::read_to_string("../input.txt").unwrap();
    let lines: Vec<&str> = contents.split('\n').collect();
    println!("part 1: {:?}", part1(&lines));
}

fn part1(binaries: &Vec<&str>) -> u128 {
    gamma(binaries) * epsilon(binaries)
}

fn gamma(binaries: &Vec<&str>) -> u128 {
    let length = binaries.len();
    let initial = vec![0; 12];
    let gamma_as_str = binaries
        .iter()
        .fold(initial, |acc, &current| {
            let s = String::from(current);
            acc.iter()
                .zip(s.chars().map(|c| c.to_digit(10).unwrap()))
                .map(|(&x, y)| x + y)
                .collect::<Vec<u32>>()
        })
        .iter()
        .map(|&sum| ((sum as f64) / (length as f64)).round().to_string())
        .collect::<Vec<String>>()
        .join("");
    print!("gamma: {:?}\n", gamma_as_str);
    let g = u128::from_str_radix(&gamma_as_str, 2).unwrap();
    print!("gamma: {:?}\n", g);
    g
}

fn epsilon(binaries: &Vec<&str>) -> u128 {
    let length = binaries.len();
    let initial = vec![0; 12];
    let gamma_as_str = binaries
        .iter()
        .fold(initial, |acc, &current| {
            let s = String::from(current);
            acc.iter()
                .zip(s.chars().map(|c| c.to_digit(10).unwrap()))
                .map(|(&x, y)| x + y)
                .collect::<Vec<u32>>()
        })
        .iter()
        .map(|&sum| ((sum as f64) / (length as f64)).round())
        .map(|n| {
            if n == 0.0 { 1 } else { 0 }
        })
        .map(|n| n.to_string())
        .collect::<Vec<String>>()
        .join("");
    print!("epsilon: {:?}\n", gamma_as_str);
    let g = u128::from_str_radix(&gamma_as_str, 2).unwrap();
    print!("epsilon: {:?}\n", g);
    g
}
