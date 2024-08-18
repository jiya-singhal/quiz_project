package main

import (
	"net/http"
	"github.com/gorilla/mux"
	"quiz_api/routes"
)

func main() {
	router := mux.NewRouter()
	routes.RegisterRoutes(router)
	http.Handle("/", router)
	http.ListenAndServe(":8080", nil)
}
