package routes

import (
    "github.com/gorilla/mux"
    "quiz_api/handlers"
)

func RegisterRoutes(router *mux.Router) {
    router.HandleFunc("/questions", handlers.GetQuestions).Methods("GET")
}
