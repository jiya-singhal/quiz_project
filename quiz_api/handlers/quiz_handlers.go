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
			
ID: 1,
Situation: "The trade war between the U.S. and China is escalating.",
Question: "Will AUD/USD go up or down?",
Options:  []string{"Up", "Down"},
Correct:  1,
		},
		{
			
			ID: 1,
			Situation: "Saudi Arabia reports an oil output that is higher than what they agreed with OPEC",
			Question: "What will happen to the price of oil?",
			Options:  []string{"Up", "Down"},
			Correct:  2,
					},
					{
			
						ID: 1,
						Situation: "The trade war between the U.S. and China is escalating.",
						Question: "Will AUD/USD go up or down?",
						Options:  []string{"Up", "Down"},
						Correct:  1,
								},
	}

	json.NewEncoder(w).Encode(questions)
}
