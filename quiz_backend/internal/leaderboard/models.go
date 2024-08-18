package leaderboard

type User struct {
    ID     string `json:"id"`
    Name   string `json:"name"`
    Score  int    `json:"score"`
    Health int    `json:"health"`
}

type LeaderboardEntry struct {
    Rank      int    `json:"rank"`
    Name      string `json:"name"`
    Score     int    `json:"score"`
    IsVirtual bool   `json:"isVirtual"`
    HasWon    bool   `json:"hasWon"`
}