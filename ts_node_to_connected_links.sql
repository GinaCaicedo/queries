--Inner join of traffic signal usa/can table and mcw link table on the end of link pvid and either the link ref node pvid or the link nref node pvid.

SELECT  l.link_pvid,
l.link_rmob_id,
l.link_length_meters,
l.ref_node_pvid,
l.nref_node_pvid,
l.shape_vector,
l.is_navigable,
l.intersection_category,
l.functional_class,
tsucn.condition_pvid,
tsucn.end_of_link,
tsucn.end_of_link_node_pvid,
tsucn.end_of_link_node_lon_lat,
tsucn.country,
tsucn.admin2,
tsucn.admin3,
tsucn.admin4
FROM link_active_ws_na_bw_2201 l
INNER JOIN chcunnin.traffic_signal_usa_can_nodes tsucn
ON l.ref_node_pvid = tsucn.end_of_link_node_pvid
--ON l.nref_node_pvid = tsucn.end_of_link_node_pvid
--Choose from the bottom two lines to make active either the reference node join or the non reference node join. 
