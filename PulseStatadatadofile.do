****USE Checkpoints_pulse_sample
***creating a bar graph showing frequency of NA responses based on chapter numer
encode response, gen(response_numeric)
gen responseNA=response_numeric if response_numeric==7
graph bar (count), over(chapter_number) by(responseNA)
