package models

type Question struct {
	QuestionText string   `json:"questionText"`
	Options      []string `json:"options"`
	CorrectOption int      `json:"correctOption"`
}
