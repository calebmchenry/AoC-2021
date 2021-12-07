package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

type Point struct {
	row int
	col int
}

type Line struct {
	start Point
	end   Point
}

type Grid = [][]int

func point(str string) Point {
	splits := strings.Split(str, ",")
	row, _ := strconv.Atoi(splits[1])
	col, _ := strconv.Atoi(splits[0])
	return Point{row: row, col: col}
}

func line(str string) Line {
	splits := strings.Split(str, " ")
	return Line{start: point(splits[0]), end: point(splits[2])}
}

func maxRow(lines []Line) int {
	max := 0
	for _, l := range lines {
		localMax := int(math.Max(float64(l.start.row), float64(l.end.row)))
		if localMax > max {
			max = localMax
		}
	}
	return max + 1
}

func maxCol(lines []Line) int {
	max := 0
	for _, l := range lines {
		localMax := int(math.Max(float64(l.start.col), float64(l.end.col)))
		if localMax > max {
			max = localMax
		}
	}
	return max + 1
}

func makeGrid(lines []Line) Grid {
	maxC := maxCol(lines)
	maxR := maxRow(lines)
	grid := [][]int{}
	for i := 0; i < maxR; i++ {
		row := make([]int, maxC)
		grid = append(grid, row)
	}
	return grid
}

func part1(lines []Line) int {
	ls := []Line{}
	for _, l := range lines {
		if l.start.row == l.end.row || l.start.col == l.end.col {
			ls = append(ls, l)
		}
	}
	grid := makeGrid(ls)
	for _, l := range ls {
		firstRow := int(math.Min(float64(l.start.row), float64(l.end.row)))
		lastRow := int(math.Max(float64(l.start.row), float64(l.end.row)))
		for r := firstRow; r <= lastRow; r++ {
			firstCol := int(math.Min(float64(l.start.col), float64(l.end.col)))
			lastCol := int(math.Max(float64(l.start.col), float64(l.end.col)))
			for c := firstCol; c <= lastCol; c++ {
				grid[r][c]++
			}
		}
	}

	count := 0
	for r := 0; r < len(grid); r++ {
		for c := 0; c < len(grid[r]); c++ {
			if grid[r][c] >= 2 {
				count++
			}
		}
	}

	return count
}

func main() {
	bytes, _ := os.ReadFile("input.txt")
	content := string(bytes)
	ls := strings.Split(content, "\n")
	lines := []Line{}
	for _, l := range ls {
		lines = append(lines, line(l))
	}
	fmt.Printf("part1: %d", part1(lines))
}
