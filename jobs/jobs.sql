BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "address_address" (
	"id"	integer NOT NULL,
	"street_number"	varchar(20) NOT NULL,
	"route"	varchar(100) NOT NULL,
	"raw"	varchar(200) NOT NULL,
	"formatted"	varchar(200) NOT NULL,
	"latitude"	real,
	"longitude"	real,
	"locality_id"	integer,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("locality_id") REFERENCES "address_locality"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "address_country" (
	"id"	integer NOT NULL,
	"name"	varchar(40) NOT NULL UNIQUE,
	"code"	varchar(2) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "address_locality" (
	"id"	integer NOT NULL,
	"name"	varchar(165) NOT NULL,
	"postal_code"	varchar(10) NOT NULL,
	"state_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("state_id") REFERENCES "address_state"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "address_state" (
	"id"	integer NOT NULL,
	"name"	varchar(165) NOT NULL,
	"code"	varchar(8) NOT NULL,
	"country_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("country_id") REFERENCES "address_country"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "painel_empresa" (
	"id"	integer NOT NULL,
	"nome"	varchar(100) NOT NULL,
	"setor"	varchar(100) NOT NULL,
	"cnpj"	varchar(100) NOT NULL,
	"dt_criacao"	datetime NOT NULL,
	"endereco_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("endereco_id") REFERENCES "address_address"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "painel_participante" (
	"id"	integer NOT NULL,
	"nome"	varchar(100) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"cpf"	varchar(13) NOT NULL,
	"telefone"	varchar(11) NOT NULL,
	"curriculo"	varchar(100),
	"dt_criacao"	datetime NOT NULL,
	"endereco_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("endereco_id") REFERENCES "address_address"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "painel_participantevaga" (
	"id"	integer NOT NULL,
	"dt_aplicacao"	datetime NOT NULL,
	"status"	varchar(100) NOT NULL,
	"participante_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("participante_id") REFERENCES "painel_participante"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "painel_participantevaga_vaga" (
	"id"	integer NOT NULL,
	"participantevaga_id"	bigint NOT NULL,
	"vaga_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("participantevaga_id") REFERENCES "painel_participantevaga"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("vaga_id") REFERENCES "painel_vaga"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "painel_vaga" (
	"id"	integer NOT NULL,
	"nome"	varchar(100) NOT NULL,
	"dt_abertura"	datetime NOT NULL,
	"dt_fechamento"	datetime NOT NULL,
	"texto"	text,
	"dt_criacao"	datetime NOT NULL,
	"empresa_id"	bigint NOT NULL,
	"endereco_id"	bigint NOT NULL,
	"modalidade"	varchar(100),
	"status"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("empresa_id") REFERENCES "painel_empresa"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("endereco_id") REFERENCES "address_address"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "painel_empresavaga" (
	"id"	integer NOT NULL,
	"qtd_vagas"	integer,
	"empresa_id"	bigint NOT NULL,
	"vaga_id"	bigint NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("vaga_id") REFERENCES "painel_vaga"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("empresa_id") REFERENCES "painel_empresa"("id") DEFERRABLE INITIALLY DEFERRED
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2021-04-29 20:48:25.035400');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2021-04-29 20:48:25.092870');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2021-04-29 20:48:25.149317');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2021-04-29 20:48:25.174303');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2021-04-29 20:48:25.203483');
INSERT INTO "django_migrations" VALUES (6,'contenttypes','0002_remove_content_type_name','2021-04-29 20:48:25.260515');
INSERT INTO "django_migrations" VALUES (7,'auth','0002_alter_permission_name_max_length','2021-04-29 20:48:25.302719');
INSERT INTO "django_migrations" VALUES (8,'auth','0003_alter_user_email_max_length','2021-04-29 20:48:25.343780');
INSERT INTO "django_migrations" VALUES (9,'auth','0004_alter_user_username_opts','2021-04-29 20:48:25.356048');
INSERT INTO "django_migrations" VALUES (10,'auth','0005_alter_user_last_login_null','2021-04-29 20:48:25.416027');
INSERT INTO "django_migrations" VALUES (11,'auth','0006_require_contenttypes_0002','2021-04-29 20:48:25.427024');
INSERT INTO "django_migrations" VALUES (12,'auth','0007_alter_validators_add_error_messages','2021-04-29 20:48:25.455023');
INSERT INTO "django_migrations" VALUES (13,'auth','0008_alter_user_username_max_length','2021-04-29 20:48:25.476831');
INSERT INTO "django_migrations" VALUES (14,'auth','0009_alter_user_last_name_max_length','2021-04-29 20:48:25.502071');
INSERT INTO "django_migrations" VALUES (15,'auth','0010_alter_group_name_max_length','2021-04-29 20:48:25.525091');
INSERT INTO "django_migrations" VALUES (16,'auth','0011_update_proxy_permissions','2021-04-29 20:48:25.551912');
INSERT INTO "django_migrations" VALUES (17,'auth','0012_alter_user_first_name_max_length','2021-04-29 20:48:25.573686');
INSERT INTO "django_migrations" VALUES (18,'sessions','0001_initial','2021-04-29 20:48:25.619271');
INSERT INTO "django_migrations" VALUES (19,'address','0001_initial','2021-05-01 00:16:07.115950');
INSERT INTO "django_migrations" VALUES (20,'address','0002_auto_20160213_1726','2021-05-01 00:16:07.151747');
INSERT INTO "django_migrations" VALUES (21,'address','0003_auto_20200830_1851','2021-05-01 00:16:07.169907');
INSERT INTO "django_migrations" VALUES (22,'address','0004_auto_20210430_1915','2021-05-01 00:16:07.200731');
INSERT INTO "django_migrations" VALUES (23,'painel','0001_initial','2021-05-01 00:16:07.262336');
INSERT INTO "django_migrations" VALUES (24,'painel','0002_auto_20210430_2031','2021-05-01 01:32:01.797825');
INSERT INTO "django_migrations" VALUES (25,'painel','0003_empresavaga','2021-05-11 00:35:37.977316');
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'painel','empresa');
INSERT INTO "django_content_type" VALUES (8,'painel','participante');
INSERT INTO "django_content_type" VALUES (9,'painel','vaga');
INSERT INTO "django_content_type" VALUES (10,'painel','participantevaga');
INSERT INTO "django_content_type" VALUES (11,'address','address');
INSERT INTO "django_content_type" VALUES (12,'address','country');
INSERT INTO "django_content_type" VALUES (13,'address','locality');
INSERT INTO "django_content_type" VALUES (14,'address','state');
INSERT INTO "django_content_type" VALUES (15,'painel','empresavaga');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_empresa','Can add empresa');
INSERT INTO "auth_permission" VALUES (26,7,'change_empresa','Can change empresa');
INSERT INTO "auth_permission" VALUES (27,7,'delete_empresa','Can delete empresa');
INSERT INTO "auth_permission" VALUES (28,7,'view_empresa','Can view empresa');
INSERT INTO "auth_permission" VALUES (29,8,'add_participante','Can add participante');
INSERT INTO "auth_permission" VALUES (30,8,'change_participante','Can change participante');
INSERT INTO "auth_permission" VALUES (31,8,'delete_participante','Can delete participante');
INSERT INTO "auth_permission" VALUES (32,8,'view_participante','Can view participante');
INSERT INTO "auth_permission" VALUES (33,9,'add_vaga','Can add vaga');
INSERT INTO "auth_permission" VALUES (34,9,'change_vaga','Can change vaga');
INSERT INTO "auth_permission" VALUES (35,9,'delete_vaga','Can delete vaga');
INSERT INTO "auth_permission" VALUES (36,9,'view_vaga','Can view vaga');
INSERT INTO "auth_permission" VALUES (37,10,'add_participantevaga','Can add participante vaga');
INSERT INTO "auth_permission" VALUES (38,10,'change_participantevaga','Can change participante vaga');
INSERT INTO "auth_permission" VALUES (39,10,'delete_participantevaga','Can delete participante vaga');
INSERT INTO "auth_permission" VALUES (40,10,'view_participantevaga','Can view participante vaga');
INSERT INTO "auth_permission" VALUES (41,11,'add_address','Can add address');
INSERT INTO "auth_permission" VALUES (42,11,'change_address','Can change address');
INSERT INTO "auth_permission" VALUES (43,11,'delete_address','Can delete address');
INSERT INTO "auth_permission" VALUES (44,11,'view_address','Can view address');
INSERT INTO "auth_permission" VALUES (45,12,'add_country','Can add country');
INSERT INTO "auth_permission" VALUES (46,12,'change_country','Can change country');
INSERT INTO "auth_permission" VALUES (47,12,'delete_country','Can delete country');
INSERT INTO "auth_permission" VALUES (48,12,'view_country','Can view country');
INSERT INTO "auth_permission" VALUES (49,13,'add_locality','Can add locality');
INSERT INTO "auth_permission" VALUES (50,13,'change_locality','Can change locality');
INSERT INTO "auth_permission" VALUES (51,13,'delete_locality','Can delete locality');
INSERT INTO "auth_permission" VALUES (52,13,'view_locality','Can view locality');
INSERT INTO "auth_permission" VALUES (53,14,'add_state','Can add state');
INSERT INTO "auth_permission" VALUES (54,14,'change_state','Can change state');
INSERT INTO "auth_permission" VALUES (55,14,'delete_state','Can delete state');
INSERT INTO "auth_permission" VALUES (56,14,'view_state','Can view state');
INSERT INTO "auth_permission" VALUES (57,15,'add_empresavaga','Can add empresa vaga');
INSERT INTO "auth_permission" VALUES (58,15,'change_empresavaga','Can change empresa vaga');
INSERT INTO "auth_permission" VALUES (59,15,'delete_empresavaga','Can delete empresa vaga');
INSERT INTO "auth_permission" VALUES (60,15,'view_empresavaga','Can view empresa vaga');
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$260000$ktIzWtabBUZCdXFokNHgzb$SUxhpKWjoO/PUajNFNIbXLmNgdI1TvOZY/vHq7BX+FU=','2021-05-11 00:28:28.534255',1,'bia','','',1,1,'2021-05-01 00:53:21.735007','');
INSERT INTO "django_session" VALUES ('mm3uwy39z21ji6byyhicctrpi0bci4q9','.eJxVjEEOwiAQRe_C2pDCADIu3fcMZGBQqgaS0q6Md7dNutDte-__twi0LiWsPc9hYnERSpx-WaT0zHUX_KB6bzK1usxTlHsiD9vl2Di_rkf7d1Col21NxvvBKB_hptAaBu20R2eYcgRIvBEVMyGwxwETA2ibEZPT5GxUZ_H5AsfGN0w:1lcdt2:xFNWF16d__ntRaFp5QOvhs29fY_qlAnJ-vIqTi97VyA','2021-05-15 00:53:36.738346');
INSERT INTO "django_session" VALUES ('xd22wuqni7b4s0t74v6w88xhzmn9ndee','.eJxVjEEOwiAQRe_C2pDCADIu3fcMZGBQqgaS0q6Md7dNutDte-__twi0LiWsPc9hYnERSpx-WaT0zHUX_KB6bzK1usxTlHsiD9vl2Di_rkf7d1Col21NxvvBKB_hptAaBu20R2eYcgRIvBEVMyGwxwETA2ibEZPT5GxUZ_H5AsfGN0w:1lgGGC:7po82s0GuwWBoAFe5uVZ4WEcYGix_KwRHI9SiT1jO4w','2021-05-25 00:28:28.557243');
INSERT INTO "address_address" VALUES (1,'','','Rua Saldanha. Conj. Universitário I','',NULL,NULL,NULL);
INSERT INTO "address_address" VALUES (2,'','','Rua Saldanha. Conj. Universitário I','',NULL,NULL,NULL);
INSERT INTO "address_address" VALUES (3,'','','Rua Saldanha, 134.','',NULL,NULL,NULL);
INSERT INTO "address_address" VALUES (4,'','','Rua Saldanha, 134','',NULL,NULL,NULL);
INSERT INTO "address_address" VALUES (5,'','','Rua Saldanha, 134','',NULL,NULL,NULL);
INSERT INTO "address_address" VALUES (6,'','','Rua Saldanha, 134','',NULL,NULL,NULL);
INSERT INTO "address_address" VALUES (7,'','','Rua Saldanha, 134','',NULL,NULL,NULL);
INSERT INTO "address_address" VALUES (8,'','','Rua Saldanha, 134','',NULL,NULL,NULL);
INSERT INTO "address_address" VALUES (9,'','','Rua Saldanha, 134','',NULL,NULL,NULL);
INSERT INTO "painel_empresa" VALUES (1,'Softplan','Tecnologia','54723789000138','2021-05-06 22:30:27.362612',8);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "address_address_locality_id_5dd79609" ON "address_address" (
	"locality_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "address_locality_name_postal_code_state_id_d1e927c2_uniq" ON "address_locality" (
	"name",
	"postal_code",
	"state_id"
);
CREATE INDEX IF NOT EXISTS "address_locality_state_id_8dc32b8e" ON "address_locality" (
	"state_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "address_state_name_country_id_a46a5987_uniq" ON "address_state" (
	"name",
	"country_id"
);
CREATE INDEX IF NOT EXISTS "address_state_country_id_0a4efd43" ON "address_state" (
	"country_id"
);
CREATE INDEX IF NOT EXISTS "painel_empresa_endereco_id_ef73532b" ON "painel_empresa" (
	"endereco_id"
);
CREATE INDEX IF NOT EXISTS "painel_participante_endereco_id_4c043a2f" ON "painel_participante" (
	"endereco_id"
);
CREATE INDEX IF NOT EXISTS "painel_participantevaga_participante_id_6b5c1620" ON "painel_participantevaga" (
	"participante_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "painel_participantevaga_vaga_participantevaga_id_vaga_id_dc14e5a8_uniq" ON "painel_participantevaga_vaga" (
	"participantevaga_id",
	"vaga_id"
);
CREATE INDEX IF NOT EXISTS "painel_participantevaga_vaga_participantevaga_id_4e6fbfc2" ON "painel_participantevaga_vaga" (
	"participantevaga_id"
);
CREATE INDEX IF NOT EXISTS "painel_participantevaga_vaga_vaga_id_d7003473" ON "painel_participantevaga_vaga" (
	"vaga_id"
);
CREATE INDEX IF NOT EXISTS "painel_vaga_empresa_id_4385f0a3" ON "painel_vaga" (
	"empresa_id"
);
CREATE INDEX IF NOT EXISTS "painel_vaga_endereco_id_70a4e91e" ON "painel_vaga" (
	"endereco_id"
);
CREATE INDEX IF NOT EXISTS "painel_empresavaga_empresa_id_c6414fad" ON "painel_empresavaga" (
	"empresa_id"
);
COMMIT;
