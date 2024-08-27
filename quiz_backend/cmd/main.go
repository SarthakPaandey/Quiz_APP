package main

import (
    "github.com/gin-contrib/cors"
    "github.com/gin-gonic/gin"
    "os"
    "quiz_backend/internal/quiz"
    "quiz_backend/internal/leaderboard"
)

func main() {
    router := gin.Default()

    // Enable CORS for all origins
    router.Use(cors.New(cors.Config{
        AllowOrigins:     []string{"*"},
        AllowMethods:     []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
        AllowHeaders:     []string{"Origin", "Content-Type", "Accept"},
        AllowCredentials: true,
    }))

    // Set up routes
    router.GET("/quizzes", quiz.GetQuizzes)
    router.GET("/quizzes/:id", quiz.GetQuiz)
    router.POST("/submit", quiz.SubmitQuiz)
    router.POST("/leaderboard", leaderboard.SaveScore)
    router.GET("/leaderboard", leaderboard.GetLeaderboard)

    // Get the port from the environment variable
    port := os.Getenv("PORT")
    if port == "" {
        port = "8080" // Default to port 8080 if not set
    }

    // Run the server
    router.Run(":" + port)
}
