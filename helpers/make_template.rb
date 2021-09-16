require 'erb'

templater = <<~HTML 
<form action="" method="post" class="container">
  <% questions.each do | question |%>
    <fieldset class="row">
      <legend class="col-md-3">
        <%=question %>
      </legend>
      <% scale_items.each_pair do |item, points |%>
      <div class="form-check col">
        <input class="form-check-input" required="required" type="radio" name="<%= question.split.join('_') %>" id="<%= item.to_s.split.join('_') %>_<%=question.split.join('_')%>" value="<%= points %>">
        <label class="form-check-label" for="<%= item.to_s.split.join('_') %>_<%=question.split.join('_')%>" >
          <%= item %>
        </label>
      </div>
      <% end %>
  
    </fieldset>
    <% end %>
    <button type="submit" class="btn btn-primary">Submit</button>
    <button type="reset" class="btn btn-primary">Reset</button>
</form>
HTML

LIKERT_5 = {
  'Strongly disagree': 1,
  'Disagree': 2,
  'Neither agree nor disagree': 3,
  'Agree': 4,
  'Strongly agree': 5
}

scale_items = {
'Not at All': 0,
'Somewhat': 1,
'Moderately': 2,
'A Lot': 3
}

questions = [
  'Anxiety, nervousness, worry or fear',
  'Feeling that things around you are strange or unreal',
  'Feeling detached from all or part of your body',
  'Sudden unexpected panic spells',
  'Apprehension or a sense of impending doom',
  'Feeling tense, stressed, “uptight” or on edge',
  'Difficulty concentrating',
  'Racing thoughts',
  'Frightening thoughts',
  'Feeling that you’re on the verge of losing control',
  'Fears of cracking up or going crazy',
  'Fears of fainting or passing out',
  'Fears of physical illnesses or heart attacks or dying',
  'Concerns about looking foolish or inadequate',
  'Fears of being alone, isolated, or abandoned',
  'Fears of criticism or disapproval',
  'Fears that something terrible is about to happen',
  'Skipping, racing or pounding of the heart (palpitations)',
  'Pain, pressure, or tightness in chest',
  'Tingling or numbness of toes and fingers',
  'Butterflies or discomfort in the stomach',
  'Constipation or diarrhea',
  'Restlessness or jumpiness',
  'Tight, tense muscles',
  'Sweating not brought on by heat',
  'A lump in the throat',
  'Trembling or shaking',
  'Rubbery or \“jelly\” legs',
  'Feeling dizzy, lightheaded or off balance',
  'Choking or smothering sensations or difficulty breathing',
  'Headaches or pains in the neck or back',
  'Hot flashes or cold chills',
  'Feeling tired, weak, or easily exhausted'
]
pauline = ERB.new(templater)
File.write('questions.html', pauline.result)
