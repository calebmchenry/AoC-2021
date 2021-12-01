package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

func solve(nums []int) int {
	prev := math.MaxInt32
	count := 0
	for _, num := range nums {
		if num > prev {
			count++
		}
		prev = num
	}
	return count
}

func main() {
	bytes, _ := os.ReadFile("input.txt")
	content := string(bytes)
	lines := strings.Split(content, "\n")
	numbers := []int{}
	for _, line := range lines {
		num, _ := strconv.Atoi(line)
		numbers = append(numbers, num)
	}
	fmt.Printf("%d", solve(numbers))
}
