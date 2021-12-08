package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

type Board = [][]string

func hasRowBingo(b Board) bool {
	for r := range b {
		rowBingo := true
		for c := range b[r] {
			if b[r][c] != "X" {
				rowBingo = false
			}
		}
		if rowBingo {
			return rowBingo
		}
	}
	return false
}

func hasColBingo(b Board) bool {
	for c := 0; c < 5; c++ {
		colBingo := true
		for r := 0; r < 5; r++ {
			if b[r][c] != "X" {
				colBingo = false
			}
		}
		if colBingo {
			return colBingo
		}
	}
	return false
}

func hasBingo(b Board) bool {
	return hasRowBingo(b) || hasColBingo(b)
}

func getNumbersAndBoards(path string) ([]string, []Board) {
	bytes, _ := os.ReadFile(path)
	content := string(bytes)
	splits := strings.Split(content, "\n\n")
	numbers := strings.Split(splits[0], ",")
	boardStrs := splits[1:]
	boards := []Board{}
	for _, bs := range boardStrs {
		rowStrs := strings.Split(bs, "\n")
		board := Board{}
		for _, rs := range rowStrs {
			rs = strings.ReplaceAll(rs, "  ", " ")
			row := strings.Split(rs, " ")
			for i := range row {
				row[i] = strings.TrimSpace(row[i])
			}
			board = append(board, row)
		}
		boards = append(boards, board)
	}
	return numbers, boards
}

func anyBoardHasBingo(bs []Board) bool {
	for _, b := range bs {
		if hasBingo(b) {
			return true
		}
	}
	return false
}

func getBoardWithBingo(bs []Board) Board {
	for _, b := range bs {
		if hasBingo(b) {
			return b
		}
	}
	return nil
}

func sumOfBoard(b Board) int {
	sum := 0
	for r := range b {
		for c := range b[r] {
			if b[r][c] == "X" {
				continue
			}
			value, _ := strconv.Atoi(b[r][c])
			sum += value
		}
	}
	return sum
}

func mark(boards []Board, number string) {
	for _, b := range boards {
		for r := range b {
			for c := range b[r] {
				if b[r][c] == number {
					b[r][c] = "X"
				}
			}
		}
	}
}

func printBoards(bs []Board) {
	for _, b := range bs {
		boardStr := ""
		for _, row := range b {
			rowStr := strings.Join(row, " ")
			boardStr = boardStr + rowStr + "\n"
		}
		fmt.Printf("%s\n", boardStr)
	}
}

func part1(path string) int {
	numbers, boards := getNumbersAndBoards(path)
	var winningNumber int
	for _, n := range numbers {
		mark(boards, n)
		if n == "24" {
			printBoards(boards)
		}
		if anyBoardHasBingo(boards) {
			winningNumber, _ = strconv.Atoi(n)
			break
		}
	}
	boardWithbingo := getBoardWithBingo(boards)
	sum := sumOfBoard(boardWithbingo)
	return winningNumber * sum
}

func main() {
	fmt.Printf("part1: %d\n", part1("../input.txt"))
	fmt.Printf("part2: %d\n", part1("../input.txt"))
}
