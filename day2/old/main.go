package main

import (
	"bufio"
	"fmt"
	"os"
)

func getScore(player byte, opponent byte) int {
	switch player {

	case 'X': // Player Rock
		switch opponent {
		case 'A': // Opponent Rock
			return 3 + 1
		case 'B': // Opponent Paper
			return 0 + 1
		case 'C': // Opponent Scissors
			return 6 + 1
		default:
			panic("Invalid input")
		}

	case 'Y': // Player Paper
		switch opponent {
		case 'A': // Opponent Rock
			return 6 + 2
		case 'B': // Opponent Paper
			return 3 + 2
		case 'C': // Opponent Scissors
			return 0 + 2
		default:
			panic("Invalid input")
		}

	case 'Z': // Player Scissors
		switch opponent {
		case 'A': // Opponent Rock
			return 0 + 3
		case 'B': // Opponent Paper
			return 6 + 3
		case 'C': // Opponent Scissors
			return 3 + 3
		default:
			panic("Invalid input")
		}

	default:
		panic("Invalid Input")
	}
}

func getAction(opponent byte, state byte) byte {
	switch state {

	case 'X': // Need to lose
		switch opponent {
		case 'A': // Opponent Rock
			return 'Z' // Player Scissors
		case 'B': // Opponent Paper
			return 'X' // Player Rock
		case 'C': // Opponent Scissors
			return 'Y' // Player Paper
		default:
			panic("Invalid input")
		}

	case 'Y': // Need to draw
		switch opponent {
		case 'A': // Opponent Rock
			return 'X' // Player Rock
		case 'B': // Opponent Paper
			return 'Y' // Player Paper
		case 'C': // Opponent Scissors
			return 'Z' // Player Scissors
		default:
			panic("Invalid input")
		}

	case 'Z': // Need to win
		switch opponent {
		case 'A': // Opponent Rock
			return 'Y' // Player Paper
		case 'B': // Opponent Paper
			return 'Z' // Player Scissors
		case 'C': // Opponent Scissors
			return 'X' // Player Rock
		default:
			panic("Invalid input")
		}

	default:
		panic("Invalid input")
	}
}

func main() {
	readFile, err := os.Open("data")
	if err != nil {
		panic(err)
	}
	fileScanner := bufio.NewScanner(readFile)
	score := 0
	for fileScanner.Scan() {
		row := fileScanner.Bytes()
		score += getScore(row[2], row[0])
	}
	fmt.Print("part one: ", score, "\n")

	readFile, err = os.Open("data")
	if err != nil {
		panic(err)
	}
	fileScanner = bufio.NewScanner(readFile)
	score = 0
	for fileScanner.Scan() {
		row := fileScanner.Bytes()
		myAction := getAction(row[0], row[2])
		score += getScore(myAction, row[0])
	}
	fmt.Print("part two: ", score, "\n")
}
