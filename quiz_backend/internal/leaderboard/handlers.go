package leaderboard

import (
    "github.com/gin-gonic/gin"
    "net/http"
    "sort"
    "sync"
)

var leaderboard []User
var mu sync.Mutex

var virtualCharacters = []User{
    {Name: "AI Trader", Score: 90, Health: 2},
    {Name: "Robo Analyst", Score: 80, Health: 2},
    {Name: "Crypto Bot", Score: 70, Health: 1},
}

func SaveScore(c *gin.Context) {
    var user User
    if err := c.ShouldBindJSON(&user); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
        return
    }

    mu.Lock()
    leaderboard = append(leaderboard, user)
    mu.Unlock()

    c.JSON(http.StatusOK, gin.H{"status": "score saved"})
}

func GetLeaderboard(c *gin.Context) {
    mu.Lock()
    defer mu.Unlock()

    allUsers := append(leaderboard, virtualCharacters...)

    sort.Slice(allUsers, func(i, j int) bool {
        if allUsers[i].Score == allUsers[j].Score {
            return allUsers[i].Health > allUsers[j].Health
        }
        return allUsers[i].Score > allUsers[j].Score
    })

    var result []LeaderboardEntry
    for i, user := range allUsers {
        result = append(result, LeaderboardEntry{
            Rank:      i + 1,
            Name:      user.Name,
            Score:     user.Score,
            IsVirtual: user.Name == "AI Trader" || user.Name == "Robo Analyst" || user.Name == "Crypto Bot",
            HasWon:    user.Score == 100 && user.Health == 2,
        })
    }

    c.JSON(http.StatusOK, result)
}