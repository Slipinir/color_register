-- Database: color_register

-- DROP DATABASE color_register;

CREATE DATABASE color_register
  WITH OWNER = color_register_user
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Portuguese_Brazil.1252'
       LC_CTYPE = 'Portuguese_Brazil.1252'
       CONNECTION LIMIT = -1;

-- Table: public.color

-- DROP TABLE public.color;

CREATE TABLE public.color
(
  id integer NOT NULL DEFAULT nextval('color_id_seq'::regclass),
  name character varying(50) NOT NULL,
  CONSTRAINT color_pk_key PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.color
  OWNER TO postgres;

