package handlers

import (
	"encoding/json"
	"net/http"
	"quiz_api/models"
	"strconv"
)

func GetQuestions(w http.ResponseWriter, r *http.Request) {
	
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Content-Type", "application/json")

	
	levelStr := r.URL.Query().Get("level")
	level, err := strconv.Atoi(levelStr)
	if err != nil || level < 1 {
		level = 1 
	}


	questions := []models.Question{
		{
			ID:        1,
			Situation: "The trade war between the U.S. and China is escalating.",
			Question:  "Will AUD/USD go up or down?",
			Options:   []string{"Up", "Down"},
			Correct:   1,
			Level:     1,  
			ImageURL: "https://i.imgur.com/JJBWAnt.jpeg",
		},
		{
			ID:        2,
			Situation: "Saudi Arabia reports an oil output that is higher than what they agreed with OPEC.",
			Question:  "What will happen to the price of oil?",
			Options:   []string{"Up", "Down"},
			Correct:   1,
			Level:     1,  
			ImageURL: "https://i.imgur.com/q4Rv5LL.jpeg",
		},
		{
			ID:        3,
			Situation: "The Federal Reserve raises interest rates.",
			Question:  "What will likely happen to the stock market?",
			Options:   []string{"Up", "Down"},
			Correct:   2,
			Level:     2,  
			ImageURL: "https://i.imgur.com/CgGwyUp.jpeg",
		},
		{
			ID:        4,
			Situation: "US bond yeilds go down?",
			Question:  "Will gold go up or down?",
			Options:   []string{"Up", "Down"},
			Correct:   1,
			Level:     1,  
			ImageURL: "https://i.imgur.com/iCMWEBG.jpeg",
		},
		{
			ID:        5,
			Situation: "UK inflation rate increases more than forecasted.",
			Question:  "What will happen to GBP/USD?",
			Options:   []string{"Up", "Down"},
			Correct:   2,
			Level:     1,  
			ImageURL: "https://i.imgur.com/1kQwKP5.jpeg",
		},
		{
			ID:        6,
			Situation: "Albert Einstein is famous for which scientific theory?",
			Question:  "What is the name of this theory?",
			Options:   []string{"Theory of Relativity", "Quantum Mechanics", "String Theory", "Theory of Evolution"},
			Correct:   1,
			Level:     2,  // General knowledge question at level 2
			ImageURL: "https://i.imgur.com/JJBWAnt.jpeg",
		},
		{
			ID:        7,
			Situation: "British pound jumps 2.1% against the euro.",
			Question:  "Will the UK's property development companies' revenues go up or down?",
			Options:   []string{"Up", "Down"},
			Correct:   2,
			Level:     1,  
			ImageURL: "https://i.imgur.com/iCMWEBG.jpeg",
		},
		{
			ID:        8,
			Situation: "China's education ministry urges students going overseas to think carefully before choosing Australia.",
			Question:  "Will AUD/USD go up or down?",
			Options:   []string{"Up", "Down"},
			Correct:   1,
			Level:     3,  
			ImageURL: "https://i.imgur.com/iCMWEBG.jpeg",
		},
	}


	filteredQuestions := []models.Question{}
	for _, q := range questions {
		if q.Level == level {
			filteredQuestions = append(filteredQuestions, q)
		}
	}


	json.NewEncoder(w).Encode(filteredQuestions)
}
