package main

import "testing"

func TestHasRowBingo(t *testing.T) {
	board := [][]string{
		{"X", "X", "X", "X", "X"},
		{"10", "16", "15", "X", "19"},
		{"18", "8", "X", "26", "20"},
		{"22", "X", "13", "6", "X"},
		{"X", "X", "12", "3", "X"},
	}
	result := hasRowBingo(board)
	expected := true
	if result != expected {
		t.Fatalf("expected %t but received %t", expected, result)
	}
}

func TestHasColBingo(t *testing.T) {
	board := [][]string{
		{"X", "0", "0", "0", "0"},
		{"X", "0", "0", "0", "0"},
		{"X", "0", "0", "0", "0"},
		{"X", "0", "0", "0", "0"},
		{"X", "0", "0", "0", "0"},
	}
	result := hasColBingo(board)
	expected := true
	if result != expected {
		t.Fatalf("expected %t but received %t", expected, result)
	}
}

func TestAnyRowHasBingo(t *testing.T) {
	bs := [][][]string{{
		{"X", "X", "X", "X", "X"},
		{"0", "0", "0", "0", "0"},
		{"0", "0", "0", "0", "0"},
		{"0", "0", "0", "0", "0"},
		{"0", "0", "0", "0", "0"},
	}}
	result := anyBoardHasBingo(bs)
	expected := true
	if result != expected {
		t.Fatalf("expected %t but received %t", expected, result)
	}
}
