/*detect map deltas
 * 10/10/2022
 *where there is no ntor condition present on the same link_pvid AND end of link
 * 
 * */
select model.observation_id,model.iso,model.n_detections,model.heading,model.latitude, model.longitude,model.height,model.width,model.altitude,model.traffic_light_distance,model.geom,model.probability,model.link_pvid,model.end_of_link 
from combined_model_output as model
left join view_rmob_ntor_conditions as conditions
on model.link_pvid=conditions.link_pvid
and model.end_of_link=conditions.end_of_link
where conditions.link_pvid is null 
and model.probability >=''