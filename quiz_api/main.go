package main

import (
	"net/http"
	"github.com/gorilla/mux"
	"quiz_api/routes"
)

// CORS middleware function
func corsMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "*") // Allow all origins for testing
		w.Header().Set("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")
		
		// For preflight requests
		if r.Method == "OPTIONS" {
			return
		}

		next.ServeHTTP(w, r)
	})
}

func main() {
	router := mux.NewRouter()
	routes.RegisterRoutes(router)

	// Apply the CORS middleware
	http.Handle("/", corsMiddleware(router))

	// Start the server
	http.ListenAndServe(":8080", nil)
}
