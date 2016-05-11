insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(BIOBJ_ID)+1 from SBI_OBJECTS),1),'SBI_OBJECTS');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(OBJ_NOTE_ID)+1 from SBI_OBJECT_NOTES),1) ,'SBI_OBJECT_NOTES');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(OBJ_PAR_ID)+1 from SBI_OBJ_PAR),1) ,'SBI_OBJ_PAR');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(OBJ_TEMP_ID)+1 from SBI_OBJECT_TEMPLATES),1) ,'SBI_OBJECT_TEMPLATES');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(SNAP_ID)+1 from SBI_SNAPSHOTS),1) ,'SBI_SNAPSHOTS');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(SUBOBJ_ID)+1 from SBI_SUBOBJECTS),1) ,'SBI_SUBOBJECTS');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(VP_ID)+1 from SBI_VIEWPOINTS),1) ,'SBI_VIEWPOINTS');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(FUNCT_ID)+1 from SBI_FUNCTIONS),1) ,'SBI_FUNCTIONS');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(PAR_ID)+1 from SBI_PARAMETERS),1) ,'SBI_PARAMETERS');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(USE_ID)+1 from SBI_PARUSE),1) ,'SBI_PARUSE');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(CHECK_ID)+1 from SBI_CHECKS),1) ,'SBI_CHECKS');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(LOV_ID)+1 from SBI_LOV),1) ,'SBI_LOV');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(ID)+1 from SBI_CONFIG),1) ,'SBI_CONFIG');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(BIN_ID)+1 from SBI_BINARY_CONTENTS),1) ,'SBI_BINARY_CONTENTS');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(VALUE_ID)+1 from SBI_DOMAINS),1) ,'SBI_DOMAINS');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(EXT_ROLE_ID)+1 from SBI_EXT_ROLES),1) ,'SBI_EXT_ROLES');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(USER_FUNCT_ID)+1 from SBI_USER_FUNC),1) ,'SBI_USER_FUNC');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(ENGINE_ID)+1 from SBI_ENGINES),1) ,'SBI_ENGINES');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(ID)+1 from SBI_EVENTS),1) ,'SBI_EVENTS');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(ID)+1 from SBI_EVENTS_LOG),1) ,'SBI_EVENTS_LOG');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(ID)+1 from SBI_REMEMBER_ME),1) ,'SBI_REMEMBER_ME');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(ALARM_ID)+1 from SBI_ALARM),1) ,'SBI_ALARM');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(ALARM_CONTACT_ID)+1 from SBI_ALARM_CONTACT),1) ,'SBI_ALARM_CONTACT');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(ALARM_EVENT_ID)+1 from SBI_ALARM_EVENT),1) ,'SBI_ALARM_EVENT');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(KPI_ID)+1 from SBI_KPI),1) ,'SBI_KPI');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(ID_KPI_DOC)+1 from SBI_KPI_DOCUMENTS),1),'SBI_KPI_DOCUMENTS');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(KPI_ERROR_ID)+1 from SBI_KPI_ERROR),1) ,'SBI_KPI_ERROR');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(id_kpi_instance)+1 from SBI_KPI_INSTANCE),1) ,'SBI_KPI_INSTANCE');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(id_kpi_instance_history)+1 from SBI_KPI_INSTANCE_HISTORY) ,1),'SBI_KPI_INSTANCE_HISTORY');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(KPI_INST_PERIOD_ID)+1 from SBI_KPI_INST_PERIOD),1) ,'SBI_KPI_INST_PERIOD');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(id_kpi_periodicity)+1 from SBI_KPI_PERIODICITY),1) ,'SBI_KPI_PERIODICITY');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(id_kpi_role)+1 from SBI_KPI_ROLE) ,1),'SBI_KPI_ROLE');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(id_kpi_instance_value)+1 from SBI_KPI_VALUE),1) ,'SBI_KPI_VALUE');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(id_measure_unit)+1 from SBI_MEASURE_UNIT),1) ,'SBI_MEASURE_UNIT');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(GOAL_ID)+1 from SBI_GOAL),1) ,'SBI_GOAL');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(GOAL_HIERARCHY_ID)+1 from SBI_GOAL_HIERARCHY),1) ,'SBI_GOAL_HIERARCHY');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(GOAL_KPI_ID)+1 from SBI_GOAL_KPI),1) ,'SBI_GOAL_KPI');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(KPI_MODEL_ID)+1 from SBI_KPI_MODEL) ,1),'SBI_KPI_MODEL');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(KPI_MODEL_INST)+1 from SBI_KPI_MODEL_INST),1) ,'SBI_KPI_MODEL_INST');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(KPI_MODEL_RESOURCES_ID)+1 from SBI_KPI_MODEL_RESOURCES),1) ,'SBI_KPI_MODEL_RESOURCES');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(RESOURCE_ID)+1 from SBI_RESOURCES),1) ,'SBI_RESOURCES');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(ID)+1 from SBI_ORG_UNIT),1) ,'SBI_ORG_UNIT');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(ID)+1 from SBI_ORG_UNIT_GRANT),1) ,'SBI_ORG_UNIT_GRANT');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(ID)+1 from SBI_ORG_UNIT_HIERARCHIES),1) ,'SBI_ORG_UNIT_HIERARCHIES');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(NODE_ID)+1 from SBI_ORG_UNIT_NODES),1) ,'SBI_ORG_UNIT_NODES');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(THRESHOLD_ID)+1 from SBI_THRESHOLD),1) ,'SBI_THRESHOLD');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(id_threshold_value)+1 from SBI_THRESHOLD_VALUE),1) ,'SBI_THRESHOLD_VALUE');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(FEATURE_ID)+1 from SBI_GEO_FEATURES),1) ,'SBI_GEO_FEATURES');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(MAP_ID)+1 from SBI_GEO_MAPS),1) ,'SBI_GEO_MAPS');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(ID)+1 from SBI_AUDIT),1) ,'SBI_AUDIT');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(ATTRIBUTE_ID)+1 from SBI_ATTRIBUTE),1) ,'SBI_ATTRIBUTE');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(ID)+1 from SBI_USER) ,1),'SBI_USER');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(DS_ID)+1 from SBI_DATA_SET),1) ,'SBI_DATA_SET');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(DS_H_ID)+1 from SBI_DATA_SET_HISTORY),1) ,'SBI_DATA_SET_HISTORY');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(DS_ID)+1 from SBI_DATA_SOURCE),1) ,'SBI_DATA_SOURCE');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(DL_ID)+1 from SBI_DIST_LIST),1) ,'SBI_DIST_LIST');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(REL_ID)+1 from SBI_DIST_LIST_OBJECTS),1) ,'SBI_DIST_LIST_OBJECTS');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(DLU_ID)+1 from SBI_DIST_LIST_USER) ,1),'SBI_DIST_LIST_USER');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(OBJ_METACONTENT_ID)+1 from SBI_OBJ_METACONTENTS),1) ,'SBI_OBJ_METACONTENTS');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(OBJ_META_ID)+1 from SBI_OBJ_METADATA),1) ,'SBI_OBJ_METADATA');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(MENU_ID)+1 from SBI_MENU) ,1),'SBI_MENU');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(PROGRESS_THREAD_ID)+1 from SBI_PROGRESS_THREAD) ,1),'SBI_PROGRESS_THREAD');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(SOURCE_ID)+1 from SBI_META_SOURCE) ,1),'SBI_META_SOURCE');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(TABLE_ID)+1 from SBI_META_TABLE) ,1),'SBI_META_TABLE');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(COLUMN_ID)+1 from SBI_META_TABLE_COLUMN) ,1),'SBI_META_TABLE_COLUMN');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(BC_ID)+1 from SBI_META_BC) ,1),'SBI_META_BC');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(ATTRIBUTE_ID)+1 from SBI_META_BC_ATTRIBUTE) ,1),'SBI_META_BC_ATTRIBUTE');
insert into hibernate_sequences(next_val,sequence_name) values (ifnull((select max(JOB_ID)+1 from SBI_META_JOB) ,1),'SBI_META_JOB');
