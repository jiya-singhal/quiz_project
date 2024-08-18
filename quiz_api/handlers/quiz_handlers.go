package handlers

import (
	"encoding/json"
	"net/http"
	"quiz_api/models"
	"strconv"
)

func GetQuestions(w http.ResponseWriter, r *http.Request) {
	// Set CORS headers
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Content-Type", "application/json")

	// Retrieve the 'level' query parameter
	levelStr := r.URL.Query().Get("level")
	level, err := strconv.Atoi(levelStr)
	if err != nil || level < 1 {
		level = 1 // Default to level 1 if no valid level is provided
	}

	// Define questions with levels
	questions := []models.Question{
		{
			ID:        1,
			Situation: "The trade war between the U.S. and China is escalating.",
			Question:  "Will AUD/USD go up or down?",
			Options:   []string{"Up", "Down"},
			Correct:   1,
			Level:     1,  // Assigning level to the question
		},
		{
			ID:        2,
			Situation: "Saudi Arabia reports an oil output that is higher than what they agreed with OPEC.",
			Question:  "What will happen to the price of oil?",
			Options:   []string{"Up", "Down"},
			Correct:   1,
			Level:     1,  // Assigning level to the question
		},
		{
			ID:        3,
			Situation: "The Federal Reserve raises interest rates.",
			Question:  "What will likely happen to the stock market?",
			Options:   []string{"Up", "Down"},
			Correct:   2,
			Level:     2,  // Assigning level to the question
		},
		{
			ID:        4,
			Situation: "Which planet is known as the Red Planet?",
			Question:  "What is the name of this planet?",
			Options:   []string{"Earth", "Mars", "Venus", "Jupiter"},
			Correct:   2,
			Level:     1,  // General knowledge question at level 1
		},
		{
			ID:        5,
			Situation: "What is the largest mammal in the world?",
			Question:  "Which animal holds this title?",
			Options:   []string{"Elephant", "Blue Whale", "Giraffe", "Orca"},
			Correct:   2,
			Level:     1,  // General knowledge question at level 1
		},
		{
			ID:        6,
			Situation: "Albert Einstein is famous for which scientific theory?",
			Question:  "What is the name of this theory?",
			Options:   []string{"Theory of Relativity", "Quantum Mechanics", "String Theory", "Theory of Evolution"},
			Correct:   1,
			Level:     2,  // General knowledge question at level 2
		},
		{
			ID:        7,
			Situation: "What is the capital city of France?",
			Question:  "Which city is this?",
			Options:   []string{"Rome", "Madrid", "Berlin", "Paris"},
			Correct:   4,
			Level:     1,  // General knowledge question at level 1
		},
		{
			ID:        8,
			Situation: "In what year did the Titanic sink?",
			Question:  "Which year did this event occur?",
			Options:   []string{"1912", "1905", "1918", "1923"},
			Correct:   1,
			Level:     3,  // General knowledge question at level 3
		},
	}

	// Filter questions based on the requested level
	filteredQuestions := []models.Question{}
	for _, q := range questions {
		if q.Level == level {
			filteredQuestions = append(filteredQuestions, q)
		}
	}

	// Return filtered questions
	json.NewEncoder(w).Encode(filteredQuestions)
}
