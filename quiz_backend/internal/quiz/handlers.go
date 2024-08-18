package quiz

import (
    "github.com/gin-gonic/gin"
    "net/http"
)

func GetQuizzes(c *gin.Context) {
    // Mock response
    quizzes := []Quiz{
        {ID: "1", Title: "Technical Analysis Quiz"},
    }
    c.JSON(http.StatusOK, quizzes)
}

func GetQuiz(c *gin.Context) {
    id := c.Param("id")
    // Mock response for the quiz with ID
    if id == "1" {
        quiz := Quiz{
            ID:    "1",
            Title: "Technical Analysis Quiz",
            Questions: []Question{
                {
                    ID:           "1",
                    QuestionText: "Buy or Sell?",
                    ImageUrl:     "https://link-to-image.png",
                    Answers: []Answer{
                        {Text: "Buy", IsCorrect: true},
                        {Text: "Sell", IsCorrect: false},
                    },
                    CorrectAnswer: "Buy",
                },
            },
        }
        c.JSON(http.StatusOK, quiz)
    } else {
        c.JSON(http.StatusNotFound, gin.H{"message": "Quiz not found"})
    }
}

func SubmitQuiz(c *gin.Context) {
    // Handle submission logic
    c.JSON(http.StatusOK, gin.H{"score": 80}) // Example response
}
