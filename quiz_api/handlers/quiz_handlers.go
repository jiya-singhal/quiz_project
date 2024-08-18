package handlers

import (
	"encoding/json"
	"net/http"
	"quiz_api/models"
)

func GetQuestions(w http.ResponseWriter, r *http.Request) {
	// Set CORS headers
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Content-Type", "application/json")

	questions := []models.Question{
		{
			QuestionText: "What is the capital of France?",
			Options:      []string{"Berlin", "Madrid", "Paris", "Lisbon"},
			CorrectOption: 2,
		},
		{
			QuestionText: "Who wrote 'Romeo and Juliet'?",
			Options:      []string{"Mark Twain", "Charles Dickens", "William Shakespeare", "Jane Austen"},
			CorrectOption: 2,
		},
		// Add more questions here
	}

	json.NewEncoder(w).Encode(questions)
}
