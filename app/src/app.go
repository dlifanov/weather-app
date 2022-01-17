package main

import (
    "fmt"
    "log"
	"net/http"
	"os"
	"io"
	"github.com/joho/godotenv"
)

func goDotEnvVariable(key string) string {

	// load .env file
	err := godotenv.Load("../.env")
  
	if err != nil {
	  log.Fatalf("Error loading .env file")
	}
  
	return os.Getenv(key)
  }

func handlerMain(w http.ResponseWriter, r *http.Request) {
	var client http.Client
	dotenv := goDotEnvVariable("API_KEY")
	URL := fmt.Sprintf("https://api.openweathermap.org/data/2.5/weather?q=Tel%%20Aviv&appid=%s&mode=html", dotenv)
	resp, err := client.Get(string(URL))
	if err != nil {
		log.Fatal(err)
	}
	defer resp.Body.Close()

	if resp.StatusCode == http.StatusOK {
		bodyBytes, err := io.ReadAll(resp.Body)
		if err != nil {
			log.Fatal(err)
		}
		w.Write([]byte(bodyBytes))
	}
}

func handlerPing(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "text/html")
	fmt.Fprintf(w, "PONG")
}

func handlerHealth(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")
}

func main() {
	fmt.Printf("Starting server at port 8080\n")

    http.HandleFunc("/", handlerMain)
	
	http.HandleFunc("/ping", handlerPing)
	
	http.HandleFunc("/health", handlerHealth)

    log.Fatal(http.ListenAndServe(":8080", nil))
}