--Pulls Traffic Signals from MCW for USA and CAN
--Assigns new column with end of link node link pvid
--Assigns new columns with reference and nonreference node latitude and longitude
--
CREATE TABLE chcunnin.traffic_signal_usa_can_nodes
AS
SELECT  l.link_pvid,
l.link_rmob_id,
l.link_length_meters,
l.functional_class,
l.ref_node_pvid,
l.nref_node_pvid,
admin_l1_display_name as Country,
admin_l2_display_name as Admin2,
admin_l3_display_name as Admin3,
admin_l4_display_name as Admin4,
admin_l4_rmob_id,
admin_l4_pvid,
admin_l3_rmob_id,
admin_l3_pvid,
c.condition_type,
c.condition_pvid,
c.end_of_link,
CASE WHEN c.end_of_link = 'N' THEN l.nref_node_pvid
ELSE l.ref_node_pvid
END as end_of_link_node_pvid,
SPLIT_PART(SPLIT_PART(SPLIT_PART(l.shape_vector,',',1),'(',2),' ',2) as ref_lat,-- division WKT
SPLIT_PART(SPLIT_PART(SPLIT_PART(l.shape_vector,',',1),'(',2),' ',1) as ref_lon,
SPLIT_PART(REVERSE(SPLIT_PART(REVERSE(l.shape_vector),',',1)),' ',2) as nref_lon,
SPLIT_PART(SPLIT_PART(REVERSE(SPLIT_PART(REVERSE(l.shape_vector),',',1)),' ',3),')',1) as nref_lat,
CASE WHEN c.end_of_link = 'N' then SPLIT_PART(REVERSE(SPLIT_PART(REVERSE(l.shape_vector),',',1)),' ',2) || ', ' ||SPLIT_PART(SPLIT_PART(REVERSE(SPLIT_PART(REVERSE(l.shape_vector),',',1)),' ',3),')',1)
else SPLIT_PART(SPLIT_PART(SPLIT_PART(l.shape_vector,',',1),'(',2),' ',1) || ', ' || SPLIT_PART(SPLIT_PART(SPLIT_PART(l.shape_vector,',',1),'(',2),' ',2)
end as end_of_link_node_lon_lat,
l.shape_vector
FROM condition_active_ws_na_bw_2201 c
JOIN link_active_ws_na_bw_2201 l ON l.link_rmob_id = json_extract_array_element_text(c.link_strand, 0)--reference node
JOIN admin_active_ws_na_bw_2201 AS a ON a.admin_rmob_id = c.first_link_left_admin_rmob_id
WHERE condition_type = 16--16=traffic_signal
AND a.admin_l1_rmob_id IN (104806456,588329784)--rmob_id(USA,CAN)
ORDER BY 1
LIMIT 10
