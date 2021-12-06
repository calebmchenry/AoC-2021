use std::fs;

fn main() {
    let contents = fs::read_to_string("../input.txt").unwrap();
    let lines: Vec<&str> = contents.split('\n').collect();
    println!("part 1: {:?}", part1(&lines));
}

fn part1(binaries: &Vec<&str>) -> u128 {
    gamma(binaries) * epsilon(binaries)
}

fn most_common_bits(binaries: &Vec<&str>) -> Vec<f64> {
    let length = binaries.len();
    let initial = vec![0; 12];
    binaries
        .iter()
        .fold(initial, |acc, &current| {
            let s = String::from(current);
            acc.iter()
                .zip(s.chars().map(|c| c.to_digit(10).unwrap()))
                .map(|(&x, y)| x + y)
                .collect::<Vec<u32>>()
        })
        .iter()
        .map(|&sum| {
            ((sum as f64) / (length as f64)).round()
        })
        .collect::<Vec<f64>>()
}

fn gamma_binary(binaries: &Vec<&str>) -> String {
    most_common_bits(binaries )
        .iter()
        .map(|b| b.to_string())
        .collect::<Vec<String>>()
        .join("")
}

fn gamma(binaries: &Vec<&str>) -> u128 {
    let gamma_as_str = gamma_binary(binaries);
    u128::from_str_radix(&gamma_as_str, 2).unwrap()
}

fn epsilon_binary(binaries: &Vec<&str>) -> String {
    most_common_bits(binaries)
        .iter()
        .map(|&n| if n == 0.0 { 1 } else { 0 })
        .map(|n| n.to_string())
        .collect::<Vec<String>>()
        .join("")
}

fn epsilon(binaries: &Vec<&str>) -> u128 {
    let epsilon_as_str = epsilon_binary(binaries);
    u128::from_str_radix(&epsilon_as_str, 2).unwrap()
}
