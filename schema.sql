CREATE TABLE IF NOT EXISTS users (
  id TEXT PRIMARY KEY,
  username TEXT NOT NULL UNIQUE COLLATE NOCASE,
  pass_hash TEXT NOT NULL,
  created_at INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS sessions (
  token_hash TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  expires_at INTEGER NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_sessions_user ON sessions(user_id);
CREATE INDEX IF NOT EXISTS idx_sessions_exp ON sessions(expires_at);
CREATE TABLE IF NOT EXISTS states (
  user_id TEXT PRIMARY KEY,
  data_json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS tireur_results (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  client_id TEXT NOT NULL,
  player_name TEXT NOT NULL,
  hits INTEGER NOT NULL CHECK(hits BETWEEN 0 AND 72),
  result_date TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  UNIQUE(user_id, client_id),
  FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE INDEX IF NOT EXISTS idx_tireur_hits ON tireur_results(hits DESC);
CREATE INDEX IF NOT EXISTS idx_tireur_user ON tireur_results(user_id);

CREATE TABLE IF NOT EXISTS training_records (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  client_id TEXT NOT NULL,
  training_date TEXT NOT NULL,
  minutes INTEGER NOT NULL CHECK(minutes > 0),
  created_at INTEGER NOT NULL,
  UNIQUE(user_id, client_id),
  FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE INDEX IF NOT EXISTS idx_training_date ON training_records(training_date);
CREATE INDEX IF NOT EXISTS idx_training_user ON training_records(user_id);

CREATE TABLE IF NOT EXISTS teams (
  id TEXT PRIMARY KEY,
  owner_id TEXT NOT NULL,
  name TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  FOREIGN KEY(owner_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE INDEX IF NOT EXISTS idx_teams_owner ON teams(owner_id);

CREATE TABLE IF NOT EXISTS team_memberships (
  team_id TEXT NOT NULL,
  user_id TEXT NOT NULL,
  joined_at INTEGER NOT NULL,
  PRIMARY KEY(team_id, user_id),
  FOREIGN KEY(team_id) REFERENCES teams(id) ON DELETE CASCADE,
  FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE INDEX IF NOT EXISTS idx_team_memberships_user ON team_memberships(user_id);
