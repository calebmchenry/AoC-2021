package main

import "testing"

func TestPart1Sample(t *testing.T) {
	result := part1("../sample.txt")
	expected := 5
	if result != expected {
		t.Fatalf("expected %d but received %d", expected, result)
	}
}

func TestPart1Input(t *testing.T) {
	result := part1("../input.txt")
	expected := 4655
	if result != expected {
		t.Fatalf("expected %d but received %d", expected, result)
	}
}

func TestPart2Sample(t *testing.T) {
	result := part2("../sample.txt")
	expected := 12
	if result != expected {
		t.Fatalf("expected %d but received %d", expected, result)
	}
}
