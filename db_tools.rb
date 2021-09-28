require 'pg'

# allows a connection with the posgresql database
class PgInterface
  def initialize
    @connection = PG::Connection.new(dbname: 'burns')
  end

  def add_user(email, password)
    sql = <<~SQL
    INSERT INTO users (username, password)
    VALUES ($1,$2);
    SQL
    @connection.exec_params(sql, [email, password]) do |result|
      puts result.error_message
    end
  end

  # returns a hash with the key as the date, and the value as the score (in string form)
  def depression_scores(user_id)
    sql = <<~SQL
      SELECT date, score FROM users
      INNER JOIN depressions on users.id = depressions.user_id
      WHERE $1 = users.id
      ORDER BY date DESC;
    SQL
    @connection.exec_params(sql, [user_id]) do |result|
      result.each_with_object({}) { |tuple, scores| scores[tuple['date']] = tuple['score'] }
    end
  end

  def anxieties_scores(user_id)
    sql = <<~SQL
      SELECT date, score FROM users
      INNER JOIN anxieties on users.id = anxieties.user_id
      WHERE $1 = users.id
      ORDER BY date DESC;
    SQL
    @connection.exec_params(sql, [user_id]) do |result|
      result.each_with_object({}) { |tuple, scores| scores[tuple['date']] = tuple['score'] }
    end
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
