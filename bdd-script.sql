create table SRP_BODEGA (
   BOD_ID               SERIAL not null,
   BOD_NOMBRE           VARCHAR(100)         not null,
   constraint PK_SRP_BODEGA primary key (BOD_ID)
);

create table SRP_SUCURSAL (
   SUC_ID               SERIAL not null,
   BOD_ID               INT4                 null,
   SUC_NOMBRE           VARCHAR(100)         not null,
   constraint PK_SRP_SUCURSAL primary key (SUC_ID)
);

create table SRP_MATERIAL (
   MAT_ID               SERIAL not null,
   MAT_NOMBRE           VARCHAR(100)         not null,
   constraint PK_SRP_MATERIAL primary key (MAT_ID)
);


create table SRP_MONEDA (
   MON_ID               SERIAL not null,
   MON_NOMBRE           VARCHAR(100)         not null,
   constraint PK_SRP_MONEDA primary key (MON_ID)
);


create table SRP_PRODUCTO (
   PRO_ID               SERIAL not null,
   SUC_ID               INT4                 null,
   MON_ID               INT4                 null,
   BOD_ID               INT4                 null,
   PRO_NOMBRE           VARCHAR(100)         not null,
   PRO_PRECIO           DECIMAL(10,2)        not null,
   PRO_CODIGO           VARCHAR(15)          unique not null,
   PRO_DESCRIPCION      TEXT                 not null,
   constraint PK_SRP_PRODUCTO primary key (PRO_ID)
);

create table SRP_MAT_PRO (
   MAT_ID               INT4                 not null,
   PRO_ID               INT4                 not null,
   constraint PK_SRP_MAT_PRO primary key (MAT_ID, PRO_ID)
);

alter table SRP_MAT_PRO
   add constraint FK_SRP_MAT__REFERENCE_SRP_MATE foreign key (MAT_ID)
      references SRP_MATERIAL (MAT_ID)
      on delete restrict on update restrict;

alter table SRP_MAT_PRO
   add constraint FK_SRP_MAT__REFERENCE_SRP_PROD foreign key (PRO_ID)
      references SRP_PRODUCTO (PRO_ID)
      on delete restrict on update restrict;

alter table SRP_PRODUCTO
   add constraint FK_SRP_PROD_REFERENCE_SRP_MONE foreign key (MON_ID)
      references SRP_MONEDA (MON_ID)
      on delete restrict on update restrict;

alter table SRP_PRODUCTO
   add constraint FK_SRP_PROD_REFERENCE_SRP_SUCU foreign key (SUC_ID)
      references SRP_SUCURSAL (SUC_ID)
      on delete restrict on update restrict;

alter table SRP_PRODUCTO
   add constraint FK_SRP_PROD_REFERENCE_SRP_BODE foreign key (BOD_ID)
      references SRP_BODEGA (BOD_ID)
      on delete restrict on update restrict;

alter table SRP_SUCURSAL
   add constraint FK_SRP_SUCU_REFERENCE_SRP_BODE foreign key (BOD_ID)
      references SRP_BODEGA (BOD_ID)
      on delete restrict on update restrict;




-- Inserts

INSERT INTO public.srp_bodega(
	bod_id, bod_nombre)
	VALUES (1, 'Bodega 1');
	
INSERT INTO public.srp_bodega(
	bod_id, bod_nombre)
	VALUES (2, 'Bodega 2');
	
INSERT INTO public.srp_bodega(
	bod_id, bod_nombre)
	VALUES (3, 'Bodega 3');



INSERT INTO public.srp_sucursal(
	suc_id, bod_id, suc_nombre)
	VALUES (1, 1, 'Sucursal 1');
	
INSERT INTO public.srp_sucursal(
	suc_id, bod_id, suc_nombre)
	VALUES (2, 1, 'Sucursal 2');

INSERT INTO public.srp_sucursal(
	suc_id, bod_id, suc_nombre)
	VALUES (3, 1, 'Sucursal 3');

INSERT INTO public.srp_sucursal(
	suc_id, bod_id, suc_nombre)
	VALUES (4, 2, 'Sucursal 4');
	
INSERT INTO public.srp_sucursal(
	suc_id, bod_id, suc_nombre)
	VALUES (5, 2, 'Sucursal 5');
	
INSERT INTO public.srp_sucursal(
	suc_id, bod_id, suc_nombre)
	VALUES (6, 2, 'Sucursal 6');
	
INSERT INTO public.srp_sucursal(
	suc_id, bod_id, suc_nombre)
	VALUES (7, 3, 'Sucursal 7');
	
INSERT INTO public.srp_sucursal(
	suc_id, bod_id, suc_nombre)
	VALUES (8, 3, 'Sucursal 8');
	
INSERT INTO public.srp_sucursal(
	suc_id, bod_id, suc_nombre)
	VALUES (9, 3, 'Sucursal 9');




INSERT INTO public.srp_moneda(
	mon_id, mon_nombre)
	VALUES (1, 'PESOS CHILENOS');

INSERT INTO public.srp_moneda(
	mon_id, mon_nombre)
	VALUES (2, 'DÓLAR');

INSERT INTO public.srp_moneda(
	mon_id, mon_nombre)
	VALUES (3, 'EURO');



INSERT INTO public.srp_material(
	mat_id, mat_nombre)
	VALUES (1, 'Plástico');
	
INSERT INTO public.srp_material(
	mat_id, mat_nombre)
	VALUES (2, 'Metal');
	
INSERT INTO public.srp_material(
	mat_id, mat_nombre)
	VALUES (3, 'Madera');
	
INSERT INTO public.srp_material(
	mat_id, mat_nombre)
	VALUES (4, 'Vidrio');
	
INSERT INTO public.srp_material(
	mat_id, mat_nombre)
	VALUES (5, 'Textil');
	
