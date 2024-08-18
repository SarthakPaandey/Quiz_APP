package main

import (
    "github.com/gin-contrib/cors"
    "github.com/gin-gonic/gin"
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

    router.GET("/quizzes", quiz.GetQuizzes)
    router.GET("/quizzes/:id", quiz.GetQuiz)
    router.POST("/submit", quiz.SubmitQuiz)
    router.POST("/leaderboard", leaderboard.SaveScore)
    router.GET("/leaderboard", leaderboard.GetLeaderboard)

    router.Run(":8080")
}
