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
      WHERE $1 = users.id;
    SQL
    scores = {}
    @connection.exec_params(sql, [user_id]) do |result|
      result.each { |tuple| scores[tuple['date']] = tuple['score'] }
    end
    scores
  end

  def close
    @connection.close
  end
end
