package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
)

// Data received from the chaincode
type Data struct {
	Owner  string `json:"owner"`
	Amount int    `json:"amount"`
}

func jsonHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == "POST" {
		var data Data
		err := json.NewDecoder(r.Body).Decode(&data)
		if err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			return
		}

		fmt.Printf("Received data: %+v\n", data)
		fmt.Fprintf(w, "Data received: Owner=%s, Amount=%d", data.Owner, data.Amount)
	} else {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
	}
}

func main() {
	http.HandleFunc("/json", jsonHandler)

	fmt.Println("Server starting on port 8080...")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal(err)
	}
}
