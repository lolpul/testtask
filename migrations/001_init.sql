CREATE TABLE IF NOT EXISTS teams (
    team_name VARCHAR(255) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS users (
    user_id VARCHAR(255) PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    team_name VARCHAR(255) REFERENCES teams(team_name) ON DELETE CASCADE,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS pull_requests (
    pull_request_id VARCHAR(255) PRIMARY KEY,
    pull_request_name VARCHAR(255) NOT NULL,
    author_id VARCHAR(255) NOT NULL REFERENCES users(user_id),
    status VARCHAR(50) DEFAULT 'OPEN',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    merged_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS pr_reviewers (
    pull_request_id VARCHAR(255) REFERENCES pull_requests(pull_request_id) ON DELETE CASCADE,
    user_id VARCHAR(255) REFERENCES users(user_id) ON DELETE CASCADE,
    PRIMARY KEY (pull_request_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_users_team_active ON users(team_name, is_active);
CREATE INDEX IF NOT EXISTS idx_pull_requests_status ON pull_requests(status);