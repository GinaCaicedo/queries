----combined_model_output

create table combined_model_output
select lm.observation_id, lm.link_pvid, lm.end_of_link,rm.valid_probability,rm.valid_prediction
from  link_mataching observation_id, link_pvid as lm
join full_data _prediction_results_model1 as rm
on lm.observation_id=prediction.Id
