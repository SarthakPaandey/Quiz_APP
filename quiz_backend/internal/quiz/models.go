package quiz

type Quiz struct {
    ID       string    `json:"id"`
    Title    string    `json:"title"`
    Questions []Question `json:"questions"`
}

type Question struct {
    ID          string   `json:"id"`
    QuestionText string   `json:"questionText"`
    ImageUrl    string   `json:"imageUrl"`
    Answers     []Answer `json:"answers"`
    CorrectAnswer string  `json:"correctAnswer"`
}

type Answer struct {
    Text     string `json:"text"`
    IsCorrect bool   `json:"isCorrect"`
}
