SELECT l.link_pvid,
l.link_length_meters,
l.functional_class,
admin_l1_display_name as Country,
admin_l2_display_name as Admin2,
admin_l3_display_name as Admin3,
admin_l4_display_name as Admin4,
admin_l4_rmob_id,
admin_l4_pvid,
admin_l3_rmob_id,
admin_l3_pvid,
c.source_id,
c.data_source,
c.condition_type,
c.view_start_date,
c.condition_pvid,
c.end_of_link,
m.value_long_name as traffic_sign_type,
l.link_rmob_id,
SPLIT_PART(SPLIT_PART(SPLIT_PART(l.shape_vector,',',1),'(',2),' ',2) as lat,-- division WKT
SPLIT_PART(SPLIT_PART(SPLIT_PART(l.shape_vector,',',1),'(',2),' ',1) as lon,
l.shape_vector
FROM condition_active_ws_na_bw_2201 c
JOIN rmob_metadata.condition_metadata_traffic_sign_type m on m.value = traffic_sign_type
JOIN link_active_ws_na_bw_2201 l ON l.link_rmob_id = json_extract_array_element_text(c.link_strand, 0)--reference node
JOIN admin_active_ws_na_bw_2201 AS a ON a.admin_rmob_id = c.first_link_left_admin_rmob_id
WHERE traffic_sign_type = 64 – NO TURN ON RED
AND a.admin_l1_rmob_id IN (104806456,588329784)
ORDER BY 15 desc
limit 101
