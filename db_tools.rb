require 'pg'

# allows a connection with the posgresql database
class PgInterface
  def initialize
    @connection = PG::Connection.new(dbname: 'burns')
  end

  # returns a hash with the key as the date, and the value as the score (in string form)
  def depression_scores(user_id)
    sql = <<~SQL
      SELECT date, score FROM users
      INNER JOIN depressions on users.id = depressions.user_id
      WHERE $1 = users.id
      ORDER BY date DESC;
    SQL
    scores = {}
    @connection.exec_params(sql, [user_id]) do |result|
      result.each { |tuple| scores[tuple['date']] = tuple['score'] }
    end
    scores
  end

  def anxieties_scores(user_id)
    sql = <<~SQL
      SELECT date, score FROM users
      INNER JOIN anxieties on users.id = anxieties.user_id
      WHERE $1 = users.id
      ORDER BY date DESC;
    SQL
    scores = {}
    @connection.exec_params(sql, [user_id]) do |result|
      result.each { |tuple| scores[tuple['date']] = tuple['score'] }
    end
    scores
  end

  def add_depression_score(user_id, score)
    sql = <<~SQL
      INSERT INTO depressions  (user_id, score) VALUES ($1, $2);
    SQL
    @connection.exec_params(sql, [user_id, score])
  end

  def add_anxiety_score(user_id, score)
    sql = <<~SQL
      INSERT INTO anxieties  (user_id, score) VALUES ($1, $2);
    SQL
    @connection.exec_params(sql, [user_id, score])
  end

  def close
    @connection.close
  end
end
