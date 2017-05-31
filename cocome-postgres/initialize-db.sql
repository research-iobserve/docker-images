CREATE DATABASE cocomedb ;
CREATE USER cocome WITH PASSWORD 'dbuser';
GRANT ALL ON DATABASE cocomedb TO cocome;

\connect cocomedb

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.5
-- Dumped by pg_dump version 9.5.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: abstractcredential; Type: TABLE; Schema: public; Owner: cocome
--

CREATE TABLE abstractcredential (
    id bigint NOT NULL,
    credential_type character varying(31),
    credentialstring character varying(255),
    type character varying(255)
);


ALTER TABLE abstractcredential OWNER TO cocome;

--
-- Name: customer; Type: TABLE; Schema: public; Owner: cocome
--

CREATE TABLE customer (
    id bigint NOT NULL,
    firstname character varying(255),
    lastname character varying(255),
    mailaddress character varying(255),
    preferredstore_id bigint,
    user_id bigint
);


ALTER TABLE customer OWNER TO cocome;

--
-- Name: customer_creditcardinfo; Type: TABLE; Schema: public; Owner: cocome
--

CREATE TABLE customer_creditcardinfo (
    customer_id bigint,
    creditcardinfo character varying(255)
);


ALTER TABLE customer_creditcardinfo OWNER TO cocome;

--
-- Name: loginuser; Type: TABLE; Schema: public; Owner: cocome
--

CREATE TABLE loginuser (
    id bigint NOT NULL,
    username character varying(255)
);


ALTER TABLE loginuser OWNER TO cocome;

--
-- Name: loginuser_abstractcredential; Type: TABLE; Schema: public; Owner: cocome
--

CREATE TABLE loginuser_abstractcredential (
    loginuser_id bigint NOT NULL,
    credentials_id bigint NOT NULL,
    credentials_key character varying(255)
);


ALTER TABLE loginuser_abstractcredential OWNER TO cocome;

--
-- Name: loginuser_roles; Type: TABLE; Schema: public; Owner: cocome
--

CREATE TABLE loginuser_roles (
    loginuser_id bigint,
    roles character varying(255)
);


ALTER TABLE loginuser_roles OWNER TO cocome;

--
-- Name: orderentry; Type: TABLE; Schema: public; Owner: cocome
--

CREATE TABLE orderentry (
    id bigint NOT NULL,
    amount bigint,
    order_id bigint,
    product_id bigint
);


ALTER TABLE orderentry OWNER TO cocome;

--
-- Name: product; Type: TABLE; Schema: public; Owner: cocome
--

CREATE TABLE product (
    id bigint NOT NULL,
    barcode bigint,
    name character varying(255),
    purchaseprice double precision,
    supplier_id bigint
);


ALTER TABLE product OWNER TO cocome;

--
-- Name: productorder; Type: TABLE; Schema: public; Owner: cocome
--

CREATE TABLE productorder (
    id bigint NOT NULL,
    deliverydate timestamp without time zone,
    orderingdate timestamp without time zone,
    store_id bigint
);


ALTER TABLE productorder OWNER TO cocome;

--
-- Name: productsupplier; Type: TABLE; Schema: public; Owner: cocome
--

CREATE TABLE productsupplier (
    id bigint NOT NULL,
    name character varying(255)
);


ALTER TABLE productsupplier OWNER TO cocome;

--
-- Name: sequence; Type: TABLE; Schema: public; Owner: cocome
--

CREATE TABLE sequence (
    seq_name character varying(50) NOT NULL,
    seq_count numeric(38,0)
);


ALTER TABLE sequence OWNER TO cocome;

--
-- Name: stockitem; Type: TABLE; Schema: public; Owner: cocome
--

CREATE TABLE stockitem (
    id bigint NOT NULL,
    amount bigint,
    incomingamount bigint,
    maxstock bigint,
    minstock bigint,
    salesprice double precision,
    product_id bigint,
    store_id bigint
);


ALTER TABLE stockitem OWNER TO cocome;

--
-- Name: store; Type: TABLE; Schema: public; Owner: cocome
--

CREATE TABLE store (
    id bigint NOT NULL,
    location character varying(255),
    name character varying(255),
    enterprise_id bigint
);


ALTER TABLE store OWNER TO cocome;

--
-- Name: tradingenterprise; Type: TABLE; Schema: public; Owner: cocome
--

CREATE TABLE tradingenterprise (
    id bigint NOT NULL,
    name character varying(255)
);


ALTER TABLE tradingenterprise OWNER TO cocome;

--
-- Name: tradingenterprise_productsupplier; Type: TABLE; Schema: public; Owner: cocome
--

CREATE TABLE tradingenterprise_productsupplier (
    tradingenterprise_id bigint NOT NULL,
    suppliers_id bigint NOT NULL
);


ALTER TABLE tradingenterprise_productsupplier OWNER TO cocome;

--
-- Data for Name: abstractcredential; Type: TABLE DATA; Schema: public; Owner: cocome
--

COPY abstractcredential (id, credential_type, credentialstring, type) FROM stdin;
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: cocome
--

COPY customer (id, firstname, lastname, mailaddress, preferredstore_id, user_id) FROM stdin;
\.


--
-- Data for Name: customer_creditcardinfo; Type: TABLE DATA; Schema: public; Owner: cocome
--

COPY customer_creditcardinfo (customer_id, creditcardinfo) FROM stdin;
\.


--
-- Data for Name: loginuser; Type: TABLE DATA; Schema: public; Owner: cocome
--

COPY loginuser (id, username) FROM stdin;
\.


--
-- Data for Name: loginuser_abstractcredential; Type: TABLE DATA; Schema: public; Owner: cocome
--

COPY loginuser_abstractcredential (loginuser_id, credentials_id, credentials_key) FROM stdin;
\.


--
-- Data for Name: loginuser_roles; Type: TABLE DATA; Schema: public; Owner: cocome
--

COPY loginuser_roles (loginuser_id, roles) FROM stdin;
\.


--
-- Data for Name: orderentry; Type: TABLE DATA; Schema: public; Owner: cocome
--

COPY orderentry (id, amount, order_id, product_id) FROM stdin;
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: cocome
--

COPY product (id, barcode, name, purchaseprice, supplier_id) FROM stdin;
3	12345678	Waldi	2	\N
\.


--
-- Data for Name: productorder; Type: TABLE DATA; Schema: public; Owner: cocome
--

COPY productorder (id, deliverydate, orderingdate, store_id) FROM stdin;
\.


--
-- Data for Name: productsupplier; Type: TABLE DATA; Schema: public; Owner: cocome
--

COPY productsupplier (id, name) FROM stdin;
\.


--
-- Data for Name: sequence; Type: TABLE DATA; Schema: public; Owner: cocome
--

COPY sequence (seq_name, seq_count) FROM stdin;
SEQ_GEN	50
\.


--
-- Data for Name: stockitem; Type: TABLE DATA; Schema: public; Owner: cocome
--

COPY stockitem (id, amount, incomingamount, maxstock, minstock, salesprice, product_id, store_id) FROM stdin;
4	300	0	500	100	2	3	2
\.


--
-- Data for Name: store; Type: TABLE DATA; Schema: public; Owner: cocome
--

COPY store (id, location, name, enterprise_id) FROM stdin;
2	Kiel	Preusserstrasse	1
\.


--
-- Data for Name: tradingenterprise; Type: TABLE DATA; Schema: public; Owner: cocome
--

COPY tradingenterprise (id, name) FROM stdin;
1	Aldi
\.


--
-- Data for Name: tradingenterprise_productsupplier; Type: TABLE DATA; Schema: public; Owner: cocome
--

COPY tradingenterprise_productsupplier (tradingenterprise_id, suppliers_id) FROM stdin;
\.


--
-- Name: abstractcredential_pkey; Type: CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY abstractcredential
    ADD CONSTRAINT abstractcredential_pkey PRIMARY KEY (id);


--
-- Name: customer_pkey; Type: CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id);


--
-- Name: loginuser_abstractcredential_pkey; Type: CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY loginuser_abstractcredential
    ADD CONSTRAINT loginuser_abstractcredential_pkey PRIMARY KEY (loginuser_id, credentials_id);


--
-- Name: loginuser_pkey; Type: CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY loginuser
    ADD CONSTRAINT loginuser_pkey PRIMARY KEY (id);


--
-- Name: orderentry_pkey; Type: CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY orderentry
    ADD CONSTRAINT orderentry_pkey PRIMARY KEY (id);


--
-- Name: product_pkey; Type: CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: productorder_pkey; Type: CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY productorder
    ADD CONSTRAINT productorder_pkey PRIMARY KEY (id);


--
-- Name: productsupplier_pkey; Type: CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY productsupplier
    ADD CONSTRAINT productsupplier_pkey PRIMARY KEY (id);


--
-- Name: sequence_pkey; Type: CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY sequence
    ADD CONSTRAINT sequence_pkey PRIMARY KEY (seq_name);


--
-- Name: stockitem_pkey; Type: CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY stockitem
    ADD CONSTRAINT stockitem_pkey PRIMARY KEY (id);


--
-- Name: store_pkey; Type: CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY store
    ADD CONSTRAINT store_pkey PRIMARY KEY (id);


--
-- Name: tradingenterprise_pkey; Type: CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY tradingenterprise
    ADD CONSTRAINT tradingenterprise_pkey PRIMARY KEY (id);


--
-- Name: tradingenterprise_productsupplier_pkey; Type: CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY tradingenterprise_productsupplier
    ADD CONSTRAINT tradingenterprise_productsupplier_pkey PRIMARY KEY (tradingenterprise_id, suppliers_id);


--
-- Name: unq_product_0; Type: CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY product
    ADD CONSTRAINT unq_product_0 UNIQUE (barcode);


--
-- Name: fk_customer_creditcardinfo_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY customer_creditcardinfo
    ADD CONSTRAINT fk_customer_creditcardinfo_customer_id FOREIGN KEY (customer_id) REFERENCES customer(id);


--
-- Name: fk_customer_preferredstore_id; Type: FK CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT fk_customer_preferredstore_id FOREIGN KEY (preferredstore_id) REFERENCES store(id);


--
-- Name: fk_customer_user_id; Type: FK CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT fk_customer_user_id FOREIGN KEY (user_id) REFERENCES loginuser(id);


--
-- Name: fk_loginuser_abstractcredential_credentials_id; Type: FK CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY loginuser_abstractcredential
    ADD CONSTRAINT fk_loginuser_abstractcredential_credentials_id FOREIGN KEY (credentials_id) REFERENCES abstractcredential(id);


--
-- Name: fk_loginuser_abstractcredential_loginuser_id; Type: FK CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY loginuser_abstractcredential
    ADD CONSTRAINT fk_loginuser_abstractcredential_loginuser_id FOREIGN KEY (loginuser_id) REFERENCES loginuser(id);


--
-- Name: fk_loginuser_roles_loginuser_id; Type: FK CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY loginuser_roles
    ADD CONSTRAINT fk_loginuser_roles_loginuser_id FOREIGN KEY (loginuser_id) REFERENCES loginuser(id);


--
-- Name: fk_orderentry_order_id; Type: FK CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY orderentry
    ADD CONSTRAINT fk_orderentry_order_id FOREIGN KEY (order_id) REFERENCES productorder(id);


--
-- Name: fk_orderentry_product_id; Type: FK CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY orderentry
    ADD CONSTRAINT fk_orderentry_product_id FOREIGN KEY (product_id) REFERENCES product(id);


--
-- Name: fk_product_supplier_id; Type: FK CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY product
    ADD CONSTRAINT fk_product_supplier_id FOREIGN KEY (supplier_id) REFERENCES productsupplier(id);


--
-- Name: fk_productorder_store_id; Type: FK CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY productorder
    ADD CONSTRAINT fk_productorder_store_id FOREIGN KEY (store_id) REFERENCES store(id);


--
-- Name: fk_stockitem_product_id; Type: FK CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY stockitem
    ADD CONSTRAINT fk_stockitem_product_id FOREIGN KEY (product_id) REFERENCES product(id);


--
-- Name: fk_stockitem_store_id; Type: FK CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY stockitem
    ADD CONSTRAINT fk_stockitem_store_id FOREIGN KEY (store_id) REFERENCES store(id);


--
-- Name: fk_store_enterprise_id; Type: FK CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY store
    ADD CONSTRAINT fk_store_enterprise_id FOREIGN KEY (enterprise_id) REFERENCES tradingenterprise(id);


--
-- Name: fk_tradingenterprise_productsupplier_suppliers_id; Type: FK CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY tradingenterprise_productsupplier
    ADD CONSTRAINT fk_tradingenterprise_productsupplier_suppliers_id FOREIGN KEY (suppliers_id) REFERENCES productsupplier(id);


--
-- Name: fk_tradingenterprise_productsupplier_tradingenterprise_id; Type: FK CONSTRAINT; Schema: public; Owner: cocome
--

ALTER TABLE ONLY tradingenterprise_productsupplier
    ADD CONSTRAINT fk_tradingenterprise_productsupplier_tradingenterprise_id FOREIGN KEY (tradingenterprise_id) REFERENCES tradingenterprise(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

