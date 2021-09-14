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

questions = [
  "Feeling sad or down in the dumps",
"Feeling unhappy or blue",
"Crying spells or tearfulness",
"Feeling discouraged",
"Feeling hopeless",
"Low self-­‐esteem",
"Feeling worthless or inadequate",
"Guilt or shame",
"Criticizing yourself or blaming others",
"Difficulty making decisions",
"Loss of interest in family, friends or colleagues",
"Loneliness",
"Spending less time with family or friends",
"Loss of motivation",
"Loss of interest in work or other activities",
"Avoiding work or other activities",
"Loss of pleasure or satisfaction in life",
"Feeling tired",
"Difficulty sleeping or sleeping too much",
"Decreased or increased appetite",
"Loss of interest in sex",
"Worrying about your health",
"Do you have any suicidal thoughts?",
"Would you like to end your life?",
"Do you have a plan for harming yoursel"
]
pauline = ERB.new(templater)
File.write('questions.html', pauline.result)
