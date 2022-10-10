CREATE VIEW view_rmob_ntor_conditions AS
SELECT c.condition_pvid,
l.link_pvid,
CASE WHEN a.admin_l1_rmob_id = 104806456
THEN a.admin_l3_rmob_id
ELSE a.admin_l4_rmob_id
END 
AS city_rmob_id,
c.condition_type,
c.end_of_link,
c.view_start_date AS condition_date,
c.data_source  AS source_code
--CASE WHEN c.end_of_link = 'N' then SPLIT_PART(REVERSE(SPLIT_PART(REVERSE(l.shape_vector),',',1)),' ',2) || ', ' ||SPLIT_PART(SPLIT_PART(REVERSE(SPLIT_PART(REVERSE(l.shape_vector),',',1)),' ',3),')',1)
--ELSE SPLIT_PART(SPLIT_PART(SPLIT_PART(l.shape_vector,',',1),'(',2),' ',1) || ', ' || SPLIT_PART(SPLIT_PART(SPLIT_PART(l.shape_vector,',',1),'(',2),' ',2)
--END 
--AS geom
FROM condition_active_ws_na_bw_2201 c
--JOIN rmob_metadata.condition_metadata_traffic_sign_type m on m.value = traffic_sign_type
JOIN link_active_ws_na_bw_2201 l ON l.link_rmob_id = json_extract_array_element_text(c.link_strand, 0)--reference node
JOIN admin_active_ws_na_bw_2201 AS a ON a.admin_rmob_id = c.first_link_left_admin_rmob_id
WHERE traffic_sign_type = 64 -- NO TURN ON RED
AND a.admin_l1_rmob_id IN (104806456,588329784);
