package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
)

type Data struct {
	Owner  string `json:"Owner"`
	Amount int    `json:"Amount"`
}

func sendJSONData(owner string, amount int, url string) error {
	// Create a new Data object
	data := Data{
		Owner:  owner,
		Amount: amount,
	}

	// Marshal the data into JSON
	jsonData, err := json.Marshal(data)
	if err != nil {
		return err
	}

	// Send the JSON data to the server
	resp, err := http.Post(url, "application/json", bytes.NewBuffer(jsonData))
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	// Check the response status
	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("unexpected status: %s", resp.Status)
	}

	fmt.Println("Data sent successfully")
	return nil
}

func main() {
	// Sample data
	data := Data{
		Owner:  "Furqan",
		Amount: 100,
	}

	// Server URL
	url := "http://localhost:8080/json" // Change to your server's URL

	// Send data to server
	err := sendJSONData(data.Owner, data.Amount, url)
	if err != nil {
		fmt.Println("Error:", err)
	}
}
