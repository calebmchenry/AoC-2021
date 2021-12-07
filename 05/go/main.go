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

func getLinesFromFile(path string) []Line {
	bytes, _ := os.ReadFile(path)
	content := string(bytes)
	splits := strings.Split(content, "\n")
	lines := []Line{}
	for _, l := range splits {
		lines = append(lines, line(l))
	}
	return lines
}

func organizeLines(lines []Line) ([]Line, []Line) {
	ss := []Line{}
	ds := []Line{}
	for _, l := range lines {
		if l.start.row == l.end.row || l.start.col == l.end.col {
			ss = append(ss, l)
		} else {
			ds = append(ds, l)
		}
	}
	return ss, ds
}

func incrementStraightLines(grid Grid, lines []Line) Grid {
	for _, l := range lines {
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
	return grid
}

func slope(line Line) int {
	y := line.start.row - line.end.row
	x := line.start.col - line.end.col
	return y / x
}

func incrementDiagonalLines(grid Grid, lines []Line) Grid {
	for _, l := range lines {
		firstRow := int(math.Min(float64(l.start.row), float64(l.end.row)))
		lastRow := int(math.Max(float64(l.start.row), float64(l.end.row)))
		var firstCol int
		if l.start.row < l.end.row {
			firstCol = l.start.col
		} else {
			firstCol = l.end.col
		}
		s := slope(l)
		for r, c := firstRow, firstCol; r <= lastRow; r, c = r+1, c+s {
			grid[r][c]++
		}
	}
	return grid
}

func countIntersections(grid Grid) int {
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

func part1(path string) int {
	lines := getLinesFromFile(path)
	grid := makeGrid(lines)
	straightLines, _ := organizeLines(lines)
	grid = incrementStraightLines(grid, straightLines)
	return countIntersections(grid)
}

func part2(path string) int {
	lines := getLinesFromFile(path)
	grid := makeGrid(lines)
	straightLines, diagonalLines := organizeLines(lines)
	grid = incrementStraightLines(grid, straightLines)
	grid = incrementDiagonalLines(grid, diagonalLines)
	return countIntersections(grid)
}

func main() {
	fmt.Printf("part1: %d\n", part1("../input.txt"))
	fmt.Printf("part2: %d\n", part2("../input.txt"))
}
