ALTER TABLE SBI_CATALOG_FUNCTION ADD DESCRIPTION CLOB NOT NULL;

ALTER TABLE SBI_PARUSE ADD COLUMN OPTIONS VARCHAR(4000) NULL DEFAULT NULL

ALTER TABLE  SBI_GEO_MAPS ADD HIERARCHY_NAME VARCHAR2(100);
ALTER TABLE  SBI_GEO_MAPS ADD LEVEL INTEGER;
ALTER TABLE  SBI_GEO_MAPS ADD MEMBER_NAME VARCHAR2(100);
