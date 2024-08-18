package models

type Question struct {
    ID       int      `json:"id"`
    Situation string   `json:"situation"`
    Question  string   `json:"question"`
    Options   []string `json:"options"`
    Correct   int      `json:"correct"`
}
