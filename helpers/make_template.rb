require 'erb'

templater = <<~HTML 
<form action="" method="post" class="container">
  <% questions.each do | question |%>
    <fieldset class="row">
      <legend class="col-md-3">
        <%=question %>
      </legend>
      <div class="form-check col">
        <input class="form-check-input" type="radio" name="<%= question %>" id="not_at_all_<%=question%>" value="0">
        <label class="form-check-label" for="not_at_all_<%=question%>" >
          Not at All
        </label>
      </div>
      <div class=" form-check col">
          <input class="form-check-input" type="radio" name="<%= question %>" id="somewhat_<%=question%>" value="1">
          <label class="form-check-label" for="somewhat_<%=question%>">
            Somewhat
          </label>
      </div>
      <div class="form-check col">
        <input class="form-check-input" type="radio" name="<%= question %>" id="moderately_<%=question%>" value="2">
        <label class="form-check-label" for="moderately_<%=question%>">
          Moderately
        </label>
      </div>
      <div class="form-check col">
        <input class="form-check-input" type="radio" name="<%= question %>" id="a_lot_<%=question%>" value="3">
        <label class="form-check-label" for="a_lot_<%=question%>">
          A lot
        </label>
      </div>
  
    </fieldset>
    <% end %>
</form>
HTML

questions = ['are you pauline', 'are you kaz']
pauline = ERB.new(templater)


puts pauline.result