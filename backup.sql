--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: QuestionType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."QuestionType" AS ENUM (
    'text',
    'choice',
    'checkbox',
    'signature',
    'date',
    'terms',
    'number',
    'email'
);


ALTER TYPE public."QuestionType" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Answer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Answer" (
    id integer NOT NULL,
    user_id integer NOT NULL,
    question_id integer NOT NULL,
    answer_text text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "formSubmissionId" integer
);


ALTER TABLE public."Answer" OWNER TO postgres;

--
-- Name: Answer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Answer_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Answer_id_seq" OWNER TO postgres;

--
-- Name: Answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Answer_id_seq" OWNED BY public."Answer".id;


--
-- Name: Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Category" (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."Category" OWNER TO postgres;

--
-- Name: Category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Category_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Category_id_seq" OWNER TO postgres;

--
-- Name: Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Category_id_seq" OWNED BY public."Category".id;


--
-- Name: FormSubmission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FormSubmission" (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."FormSubmission" OWNER TO postgres;

--
-- Name: FormSubmission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."FormSubmission_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."FormSubmission_id_seq" OWNER TO postgres;

--
-- Name: FormSubmission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."FormSubmission_id_seq" OWNED BY public."FormSubmission".id;


--
-- Name: Question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Question" (
    id integer NOT NULL,
    is_required boolean NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    question_type public."QuestionType" NOT NULL,
    "categoryId" integer,
    "order" integer DEFAULT 0,
    description text,
    key text,
    placeholder text,
    "questionTextEn" text NOT NULL,
    "questionTextId" text NOT NULL
);


ALTER TABLE public."Question" OWNER TO postgres;

--
-- Name: QuestionOption; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuestionOption" (
    id integer NOT NULL,
    question_id integer NOT NULL,
    value text NOT NULL,
    label text NOT NULL
);


ALTER TABLE public."QuestionOption" OWNER TO postgres;

--
-- Name: QuestionOption_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."QuestionOption_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."QuestionOption_id_seq" OWNER TO postgres;

--
-- Name: QuestionOption_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."QuestionOption_id_seq" OWNED BY public."QuestionOption".id;


--
-- Name: Question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Question_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Question_id_seq" OWNER TO postgres;

--
-- Name: Question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Question_id_seq" OWNED BY public."Question".id;


--
-- Name: Signature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Signature" (
    id integer NOT NULL,
    "imageUrl" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "userId" integer NOT NULL
);


ALTER TABLE public."Signature" OWNER TO postgres;

--
-- Name: Signature_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Signature_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Signature_id_seq" OWNER TO postgres;

--
-- Name: Signature_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Signature_id_seq" OWNED BY public."Signature".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    phone text,
    age integer,
    gender text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: Answer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Answer" ALTER COLUMN id SET DEFAULT nextval('public."Answer_id_seq"'::regclass);


--
-- Name: Category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category" ALTER COLUMN id SET DEFAULT nextval('public."Category_id_seq"'::regclass);


--
-- Name: FormSubmission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FormSubmission" ALTER COLUMN id SET DEFAULT nextval('public."FormSubmission_id_seq"'::regclass);


--
-- Name: Question id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Question" ALTER COLUMN id SET DEFAULT nextval('public."Question_id_seq"'::regclass);


--
-- Name: QuestionOption id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionOption" ALTER COLUMN id SET DEFAULT nextval('public."QuestionOption_id_seq"'::regclass);


--
-- Name: Signature id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Signature" ALTER COLUMN id SET DEFAULT nextval('public."Signature_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Data for Name: Answer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Answer" (id, user_id, question_id, answer_text, created_at, "formSubmissionId") FROM stdin;
\.


--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Category" (id, name) FROM stdin;
1	Biodata anak
5	Informasi tambahan
\.


--
-- Data for Name: FormSubmission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."FormSubmission" (id, "userId", "createdAt") FROM stdin;
\.


--
-- Data for Name: Question; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Question" (id, is_required, created_at, question_type, "categoryId", "order", description, key, placeholder, "questionTextEn", "questionTextId") FROM stdin;
1	t	2025-08-01 09:25:38.25	text	1	1	Mohon isi nama lengkap sesuai KTP atau kartu identitas.	full_name	Masukkan nama lengkap Anda...	Child’s FULL Name	Nama Lengkap Anak
2	t	2025-08-01 09:26:42.971	text	1	2	Mohon isi nama panggilan anak sesuai yang biasa digunakan.	child_nickname	Masukkan nama panggilan anak...	Child’s Nickname	Nama Panggilan Anak
3	t	2025-08-01 09:27:31.913	date	1	3	Mohon isi tanggal lahir anak sesuai KTP atau akta kelahiran.	child_dob	Masukkan tanggal lahir anak...	Child’s DOB	Tanggal Lahir Anak
4	t	2025-08-01 09:28:38.268	text	1	4	Mohon isi nama sekolah anak dengan lengkap.	school_name	Masukkan nama sekolah anak...	School's Name	Nama Sekolah
5	t	2025-08-01 09:29:22.083	text	1	5	Mohon isi tingkat atau kelas anak saat ini.	grade	Masukkan tingkat/kelas anak...	Grade	Tingkat
6	t	2025-08-01 09:35:21.121	choice	1	6	Mohon pilih jenis kelamin anak.	gender	\N	Gender	Jenis Kelamin
7	t	2025-08-01 09:40:06.763	text	1	7	Tuliskan agama sesuai keyakinan anak.	religion	Masukkan agama anak...	Religion	Agama
9	t	2025-08-01 09:57:48.646	text	1	9	Tolong isi alamat tempat tinggal anak secara lengkap (termasuk jalan, nomor, RT/RW, kelurahan, kecamatan, kota/kabupaten, provinsi, dan kode pos).	home_address	Masukkan alamat lengkap tempat tinggal anak...	Home Address	Alamat Tinggal
10	t	2025-08-01 10:06:27.08	text	1	10	Tulis nama lengkap ayah kandung anak.	father_name	Masukkan nama lengkap ayah	Father's Name	Nama Ayah
11	t	2025-08-04 02:01:56.343	text	1	11	Silakan isi nomor WhatsApp ayah yang masih aktif.	father_whatsapp	Contoh: 081234567890	Father's Whatsapp Number	No Whatsapp Ayah
14	t	2025-08-04 02:16:07.89	text	1	12	Masukkan alamat email Ayah yang masih aktif (Enter an active email address for the father).	father_email	Contoh: ayah@email.com	Father's Email	Email Ayah
15	t	2025-08-04 02:18:28.556	text	1	13	Tuliskan nama lengkap Ibu kandung.	mother_name	Masukkan nama lengkap Ibu	Mother's Name	Nama Ibu
16	t	2025-08-04 02:21:57.597	text	1	14	Silakan isi nomor WhatsApp ibu yang masih aktif.	mother_whatsapp	Contoh: 081234567890	Mother's Whatsapp Number	No Whatsapp Ibu
17	t	2025-08-04 02:22:53.798	text	1	15	Silakan isi alamat email ibu yang aktif digunakan.	mother_email	Contoh: ibu@email.com	Mother's Email	Email Ibu
18	t	2025-08-04 03:03:52.779	choice	1	16	Tingkat kemampuan anak dalam berbahasa Inggris.	english_proficiency	Pilih salah satu	English Proficiency	Kemampuan Anak Berbahasa Inggris
19	t	2025-08-04 03:09:43.893	text	1	17	Tuliskan ukuran kaos yang sesuai untuk anak.	tshirt_size	Contoh: M, L, XL	IAG T - Shirt Size	IAG Ukuran Kaos Anak
21	t	2025-08-04 03:23:15.767	text	1	19	Nama lengkap orang yang dapat dihubungi dalam kondisi darurat selain orang tua.	emergency_contact_full_name	Contoh: Budi Santoso	Full Name of Emergency Contact (Except Parents) in Emergency Situation	Nama Lengkap Emergency Contact (Selain Orang Tua) dalam Kondisi Darurat
23	t	2025-08-04 03:24:54.542	text	1	21	Hubungan antara kontak darurat dengan peserta.	emergency_contact_relation	Contoh: Kakak, Tante, Kakek, dll.	Relation with Participant	Hubungan dengan Peserta
25	t	2025-08-04 03:27:22.832	text	1	23	Mohon jelaskan tiga perubahan penting yang Anda harapkan terjadi pada anak Anda.	three_major_changes	Tuliskan 3 perubahan yang ingin Anda lihat pada anak Anda...	What are the 3 major changes that you think are achievable, and would like to see happen in your child?	Apakah 3 perubahan yang dapat dicapai yang anda ingin lihat dari anak anda?
27	t	2025-08-04 03:30:29.298	text	1	25	Sebutkan berbagai kelebihan dan bakat yang dimiliki anak Anda.	child_strengths	Tuliskan kelebihan-kelebihan anak Anda.	What are the strengths that your child possess?	Apakah kelebihan-kelebihan yang dimiliki anak anda?
28	t	2025-08-04 03:31:09.317	text	1	26	Sebutkan kekurangan atau hal yang perlu diperbaiki pada anak Anda.	child_weaknesses	Tuliskan kekurangan anak Anda.	What are the weaknesses that your child possess?	Apakah kekurangan yang dimiliki anak anda?
30	t	2025-08-04 03:35:19.866	text	1	29	Sebutkan tiga hobi favorit anak Anda.	child_favorite_hobbies	Contoh: bermain bola, membaca, menggambar	List the 3 favorite hobbies of your child:	Tuliskan 3 hobi favorit anak anda:
31	t	2025-08-04 03:35:44.959	text	1	30	Sebutkan jumlah dan nama sahabat dekat anak Anda jika Anda tahu.	child_close_friends	Contoh: 3 orang, nama: Ani, Budi, Caca	As far as you know, how many close friends does your child have? List their names if you know.	Menurut anda, berapa banyak sahabat baik yang anak anda miliki? Sebutkan jika anda tahu.
8	f	2025-08-01 09:49:59.359	text	1	8	Tulis nama kakak/adik jika ada yang pernah atau sedang mengikuti camp I Am Gifted.	sibling_name	Masukkan nama kakak/adik yang mengikuti camp...	Sibling's name who join I Am Gifted camp	Nama kakak/adik yang join I Am Gifted Camp
22	t	2025-08-04 03:24:09.209	text	1	20	Nomor WhatsApp dari kontak darurat selain orang tua.	emergency_contact_whatsapp	Contoh: 081234567890	Emergency Contact Whatsapp Number	No Whatsapp Kontak Darurat
26	t	2025-08-04 03:28:58.754	text	1	24	Dengan Ayah/Wali: Dengan Ibu/Wali: Dengan Kakek/Nenek : Dengan saudara kandung (jika ada)	family_relationships	Tuliskan hubungan anak dengan anggota keluarga, misalnya Ayah, Ibu, Kakek, Nenek, dan saudara kandung.	Please describe the relationships between the child and members of the family (Father/Guardian, Mother/Guardian, Grandparents, Siblings).	Silahkan ceritakan hubungan anak anda dengan anggota keluarga(Ayah/Wali, Ibu/Wali, Kakek/Nenek, Saudara Kandung)
32	t	2025-08-04 03:37:24.96	checkbox	1	31	Pilih 5 nilai terpenting bagi anak Anda.	child_important_values	Pilih nilai-nilai yang penting	As a parent, what are the 5 most important values for your child at this time? (Please choose 5)	Menurut anda sebagai orangtua, apa 5 nilai terpenting bagi anak anda pada saat ini? (Dari sisi anda sebagai orangtua, Silahkan pilih 5)
34	t	2025-08-04 03:44:54.231	text	1	32	Pertanyaan ini untuk mengetahui pelajaran favorit anak di sekolah.	favorite_subject	Tuliskan pelajaran favorit anak Anda	What is your child’s favorite subject at school?	Apakah pelajaran favorit anak anda di sekolah?
35	t	2025-08-04 03:45:41.562	text	1	33	Pertanyaan ini untuk mengetahui profesi yang mungkin diminati anak.	possible_profession	Tuliskan profesi yang mungkin diminati anak Anda	According to you, what is the profession that your child is possibly interested in?	Menurut anda, profesi apakah yang mungkin diminati oleh anak anda?
36	t	2025-08-04 03:48:07.39	text	5	34	Informasi tentang alergi makanan anak.	food_allergy	Tuliskan alergi makanan jika ada	Does your child have allergies to certain food?	Apakah anak anda memiliki alergi terhadap makanan?
37	t	2025-08-04 03:48:21.889	text	5	35	Informasi tentang alergi obat anak.	medicine_allergy	Tuliskan alergi obat jika ada	Does your child have allergies to certain medicine?	Apakah anak anda memiliki alergi terhadap obat-obatan?
38	f	2025-08-04 03:48:40.203	text	5	36	Informasi kondisi kesehatan khusus anak.	special_condition	Tuliskan kondisi khusus jika ada	Does your child have any sickness/injury that needs special concern?	Apakah Anak Anda memiliki kondisi sakit/cedera yang memerlukan perhatian khusus? (misalnya asma/kelainan jantung/patah tulang)
39	t	2025-08-04 03:48:56.008	text	5	37	Informasi tentang kejadian traumatik anak 2 tahun terakhir.	traumatic_events	Tuliskan 3 peristiwa penting tersebut	Please list down 3 major events that has happen to your child in the last 2 years	Silahkan tulis 3 hal yang pernah terjadi kepada anak anda selama 2 tahun terakhir ? (Yang bersifat traumatic/mempengaruhi psikis anak)
40	t	2025-08-04 03:51:51.841	terms	1	38	Centang untuk menyetujui syarat dan ketentuan program.	terms_agreement		I agree to all the applicable terms and conditions.	Saya menyetujui semua syarat dan ketentuan yang berlaku.
42	t	2025-08-04 07:07:47.784	signature	1	41	Silakan tanda tangani sebagai persetujuan.	parent_signature	\N	Parent's signature	Tanda tangan orang tua
43	t	2025-08-04 08:24:18.437	text	1	27	Orangtua/Wali diharapkan tidak melihat atau bertanya langsung kepada anak untuk menjawab pertanyaan berikut. Orangtua dimohon untuk menjawab pertanyaan-pertanyaan di bawah ini hanya menggunakan pendapat pribadi. (Dari sisi Anda sebagai orangtua)	how_well_do_you_know_your_child	Tuliskan pendapat Anda secara pribadi.	How well do you know your child	Seberapa baik anda mengenal anak anda
\.


--
-- Data for Name: QuestionOption; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."QuestionOption" (id, question_id, value, label) FROM stdin;
3	6	L	Laki-laki-Male
4	6	P	Perempuan-Female
5	18	A	Aktif - Active
7	32	integrity	Integrity
8	32	joy	Joy
9	32	feeling_loved	Feeling Loved
10	32	freedom	Freedom
11	32	security	Security
12	32	responsibility	Responsibility
13	32	truthfulness	Truthfulness
14	32	loyalty	Loyalty
15	32	recognition	Recognition
16	32	acceptance	Acceptance
17	32	respect	Respect
18	32	happiness	Happiness
19	32	power	Power
20	32	balance	Balance
21	32	justice	Justice
22	32	fear_of_failure	Fear of Failure
23	32	other	Other
6	18	B	Pasif-Passive
\.


--
-- Data for Name: Signature; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Signature" (id, "imageUrl", "createdAt", "userId") FROM stdin;
6	data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAfQAAADICAYAAAAeGRPoAAAAAXNSR0IArs4c6QAAEhlJREFUeF7t3QmsdElZBuAXiQsuKEQWIyqCS2Ci48qiQQFFYRRxQxGiCBMxooiyCAIRRQGJAyIIAXQQRDQgJBhAggq4oKCJStAhaNQZFMWICyQjiGz2l9SNTaf//57ue7u7TvVzkgnD/NXnVD3fSd7/bFXXiY0AAQIECBCYvcB1Zj8CAyBAgAABAgQi0J0EBAgQIEBgAAGBPkARDYEAAQIECAh05wABAgQIEBhAQKAPUERDIECAAAECAt05QIAAAQIEBhAQ6AMU0RAIECBAgIBAdw4QIECAAIEBBAT6AEU0BAIECBAgINCdAwQIECBAYAABgT5AEQ2BAAECBAgIdOcAAQIECBAYQECgD1BEQyBAgAABAgLdOUCAAAECBAYQEOgDFNEQCBAgQICAQHcOECBAgACBAQQE+gBFNAQCBAgQICDQnQMECBAgQGAAAYE+QBENgQABAgQICHTnAAECBAgQGEBAoA9QREMgQIAAAQIC3TlAgAABAgQGEBDoAxTREAgQIECAgEB3DhAgQIAAgQEEBPoARTQEAgQIECAg0J0DBAgQIEBgAAGBPkARDYEAAQIECAh05wABAgQIEBhAQKAPUERDIECAAAECAt05QIAAAQIEBhAQ6AMU0RAIECBAgIBAdw4QIECAAIEBBAT6AEU0BAIECBAgINCdAwQIECBAYAABgT5AEQ2BAAECBAgIdOcAAQIECBAYQECgD1BEQyBAgAABAgLdOUCAAAECBAYQEOgDFNEQCBAgQICAQHcOECBAgACBAQQE+gBFNAQCBAgQICDQnQMECBAgQGAAAYE+QBENgQABAgQICHTnAAECBAgQGEBAoA9QREMgQIAAAQIC3TlAgAABAgQGEBDoAxTREAgQIECAgEB3DhAgQIAAgQEEBPoARTQEAgQIECAg0J0DBAgQIEBgAAGBPkARDYEAAQIECAh05wABAgQIEBhAQKAPUERDIECAAAECAt05QIAAAQIEBhAQ6AMU0RAIECBAgIBAdw4QIECAAIEBBAT6AEU0BAIECBAgINCdAwQIECBAYAABgT5AEQ2BAAECBAgIdOcAAQIECBAYQECgD1BEQyBAgAABAgLdOUCAAAECBAYQEOgDFNEQCBAgQICAQHcOECBAgACBAQQE+gBFNAQCBAgQICDQnQMECBAgQGAAAYE+QBENgQABAgQICHTnAAECBAgQGEBAoA9QREMgQIAAAQIC3TlAgAABAgQGEBDoAxTREAgQIECAgEB3DhAgQIAAgQEEBPoARTQEAgQIECAg0J0DBPoSuFGSOya5bKlb/5bkVYv//vt9dVVvCBDoSUCg91QNfTlWgZu3EL9v+991Dr+T5OuPFci4CRA4XUCgn26kBYFdCdSV+Dcl+a4kNz3lIG9NcqtddcR+CRCYv4BAn38NjWB+Aj+Z5FuSfOFFuv6eJB/f/vwfklzulvv8Cq3HBPYpIND3qe1Yxy5QV+IPuMht9d9c3FZ/Q5K69X5pw3pkkicdO5zxEyBwuoBAP91ICwJnFfjmJA++SJDXy24/mOQtST68dLA7uSo/K73fEzgeAYF+PLU20sMI1O31x17g0H+Y5M1JHpTkS5M8Y/E2+21b2y9L8ueH6bKjEiAwRwGBPseq6fMcBOqFt29tYb3a3z9J8rB2e/3kz97YwrxCvML8PLbqQ30GV7fy6y8Mf53kfeexY/sgQKA/AYHeX030aP4CdYv9x5LcfmUob0/yA4vAfsXSf6/QfWCSe7bb63Wbfdvty5N8b5I7J/n0JJ+0sqO/SPJQt/G35fU7An0LCPS+66N38xOoYD75Z7n3T25X5euu1iv4fz7JQ7YYboX2V7egrr8cnLY9v4X+ae38OQECMxMQ6DMrmO52LVDBXLfTl7d64e2nLnBV/OIW/s9LUkG76UxwNSHNDyf50Q1UXpnkGzdorykBAjMREOgzKZRudi/wI+0qe7mjD09yxZqe37q9AFdX1N/RnnFvOsDlW/Xrflsv2/3X4vif2J6fV5t/bFfyL9n0YNoTINC/gEDvv0Z62LfALZLcI8lTlrr5e0mec4GgriB+Qnu+Xlfu9Rb8Nlvdoq+/RCxv17Y5369sn8jdK0ldxddW/fnpJPUc30aAwIACAn3AohrS3gQ+p4VzPTM/2V7eboNfs6YXJ5+wvTPJM88Q5rXrl7a36E8OU/t7TJLvTvILS8euRV3+7IzH2huoAxEgsL2AQN/ezi8JLE8CUxp3SVJX5+u2CvOvSlJvsd87yW+cka9mnavpY+uztL9st9cft7LPmqzmtxcvwa37y8UZD+/nBAj0JiDQe6uI/sxF4OSFtpP+XmxWt9e1W+D1jfndk7zjnAb5yW0q2ZqY5jPaPusvGfWC3f3O6Rh2Q4DATAQE+kwKpZvdCNQz879f6k1N2lLPs2sO9tXtkiS17On7F/OzX92uzs9jIBXedYW+PMd7HaP6Us/nrzqPg9gHAQLzEhDo86qX3h5WYPWZeQVovaW+bvvaJL+b5F+TPC3JE8+h6/UXhF9aM2FNTSFbn67VxDE2AgSOVECgH2nhDXsrgdU3y9fdZv+oJPUs+9Htqrxmhnv1VkdLPjrJ17QpYWsGuJM31mt3dUVet/J/tv3vlofwMwIERhEQ6KNU0jh2LVBvstdz85NtXZhXANe33jdN8pr2fLvWMt90q+CuZVbrLwOfsvLj/24vutUnb26tbyqrPYGBBQT6wMU1tHMTWA3zur391JW91xrmNeNbbbVqWs2ZPnUhlI9d3J7/yraE6t0Wz8avt7LvD7VPz2r62Jrp7b3nNjI7IkBgGAGBPkwpDWRHAnWr+1eW9l1TrT596f9/TFvrvL4BryB+xJoZ49Z1rV5q+4YW5Mu30pfb1idnr2/Pzf99R+OzWwIEBhEQ6IMU0jB2IlBXyy9cTNRyg7b3mrylXoQ7mXP9Mxe315+VpNq9Lcl3Lv79Ty/Qk/u0P6/fXHqR3v5vkl9sL9LVPm0ECBCYJCDQJzFpdKQCNcvaXdvY63l1LWpyMklLvcVeV+43awF///b8vF5i+9zF52N15V4TzdSCLavPwddxVng/N8mLFp+k/c2Rehs2AQJnEBDoZ8Dz0+EFlmeCqyCvz8/etHgp7TZtBbV6Ce61be3xuoqvl+E22d7V1kavT9FqlbYPbPJjbQkQILAsINCdDwQuLFAzu33JDoD+qs3FXtO//u0O9m+XBAgcoYBAP8KiG/JkgdOWKJ28o/aWei3cUs/g3VLfRE5bAgQmCQj0SUwaHbFAfVJWM7HVbfaLbe9J8k9J/m7x+Vmtplb/Xoum/FESb6gf8Qlk6AT2JSDQ9yXtOHMTqOfj9QnaDyW5Sbs1Xm+q18trFdi11Upn9c+Nl958n9s49ZcAgUEEBPoghTSMcxX41CQ1icv3tL3WgiePT1JX4TYCBAh0KSDQuyyLTh1IoOZhr1ngrmjHrxXUvj9JvcRmI0CAQNcCAr3r8ujcHgXqe/JnL15eu6xN2fqwJC9YBPy799gHhyJAgMDWAgJ9azo/HEig5mqvb8zrO/I3Lp6T3y/JWwcan6EQIHAEAgL9CIpsiBcU+LzFTG+/vFgZ7Q6txSPbtKu1opmNAAECsxIQ6LMql86ek8AntNXQagnSemO9npHXUqUmeTknYLshQGD/AgJ9/+aOeDiBOt+/LcnPJPn8JFe3T9NqshcbAQIEZi0g0GddPp3fQODrFt+L12ppt2y/eWmSh7QFVTbYjaYECBDoU0Cg91kXvTpfgfqG/FFtl29J8hNJXpbkg+d7GHsjQIDA4QQE+uHsHXm3Atdr35TXd+U1UUytZFZvsj82ybW7PbS9EyBAYP8CAn3/5o64W4HrJ/n2NtPbyTrkdTV+eZL/3O2h7Z0AAQKHExDoh7N35PMXqCCvW+tf3HZd35Q/tK01fv5Hs0cCBAh0JCDQOyqGrmwtcKf2/fitl4K8Znr746336IcECBCYmYBAn1nBdPcjBG6RpCaDuX+S6ya5ZvF8vIK83mC3ESBA4KgEBPpRlXuYwdbSpk9N8sA2on9O8nNJrvTC2zA1NhACBDYUEOgbgml+cIG7tkVT6s312l7U5l5/78F7pgMECBA4oIBAPyC+Q28sUFflD26/en37BO21G+/FDwgQIDCggEAfsKgDDumSJC9Mcmkb22PaLXeLqAxYbEMiQGA7AYG+nZtf7UegPj+r6Vpvt5hzvW6p1yIq97W06X7wHYUAgXkJCPR51euYevuAJD+e5OZt0L/awvyYDIyVAAECkwUE+mQqDfckcKv2tvrt2/He1yaHecaeju8wBAgQmKWAQJ9l2Ybs9A2TPDHJ9yU5OS//ZbFG+b2T/MGQIzYoAgQInKOAQD9HTLvaWuAGSV6R5CuW9vDOxYpoX5SkQt1GgAABAqcICHSnyKEF7p6kno+fLKRS/blqMf96rV8uzA9dHccnQGA2AgJ9NqUarqO3TPLrSW6zMrJnJ3l0kv8YbsQGRIAAgR0KCPQd4tr1BQUuS/LcJDdZaVEBfx9uBAgQILC5gEDf3Mwvzibw8CSPS/JxS7u5Nslz2sIqHz7b7v2aAAECxykg0I+z7ocY9fXbW+wnC6qc9OGDbWGV+ubcRoAAAQJbCgj0LeH8bCOBz07yaytvsdcOava3B7XvzjfaocYECBAg8JECAt0ZsWuB+o78iiSftnKgdy2mcL1XklfvugP2T4AAgWMQEOjHUOXDjfFp7Qp8tQfXJLlHkjcfrmuOTIAAgbEEBPpY9exlNLWoSk3VejJ963K/XpXk8iTv6KWz+kGAAIERBAT6CFXsZwx1PtUt9scn+aw13XqKN9n7KZaeECAwloBAH6uehxzNjZM8oV19r/ajnpfX52r17fmHDtlJxyZAgMCoAgJ91Mrud1x3TlLPyy9Zc9haw7ymd33bfrvkaAQIEDguAYF+XPXexWjflOTSNTuuq/KXtdXTPrCLA9snAQIECPy/gEB3NmwjcKPFN+SPaOuUr/v9u9ufXbnNzv2GAAECBDYXEOibmx3rL+6Y5C5trvWbJbnuBSBe067Krz5WKOMmQIDAIQQE+iHU53fM+l78C07p9vtbkD9/fsPTYwIECMxfQKDPv4a7HsE9k7z4lIP8VpKXtOldd90f+ydAgACBNQIC3WlxmsDFAv2qNq3r807biT8nQIAAgd0KCPTd+o6y9zckud3SYJ6c5HVJXjnKAI2DAAECcxcQ6HOv4P76Xy/F1dvtL0/yP/s7rCMRIECAwBQBgT5FSRsCBAgQINC5gEDvvEC6R4AAAQIEpggI9ClK2hAgQIAAgc4FBHrnBdI9AgQIECAwRUCgT1HShgABAgQIdC4g0DsvkO4RIECAAIEpAgJ9ipI2BAgQIECgcwGB3nmBdI8AAQIECEwREOhTlLQhQIAAAQKdCwj0zgukewQIECBAYIqAQJ+ipA0BAgQIEOhcQKB3XiDdI0CAAAECUwQE+hQlbQgQIECAQOcCAr3zAukeAQIECBCYIiDQpyhpQ4AAAQIEOhcQ6J0XSPcIECBAgMAUAYE+RUkbAgQIECDQuYBA77xAukeAAAECBKYICPQpStoQIECAAIHOBQR65wXSPQIECBAgMEVAoE9R0oYAAQIECHQuINA7L5DuESBAgACBKQICfYqSNgQIECBAoHMBgd55gXSPAAECBAhMERDoU5S0IUCAAAECnQsI9M4LpHsECBAgQGCKgECfoqQNAQIECBDoXECgd14g3SNAgAABAlMEBPoUJW0IECBAgEDnAgK98wLpHgECBAgQmCIg0KcoaUOAAAECBDoXEOidF0j3CBAgQIDAFAGBPkVJGwIECBAg0LmAQO+8QLpHgAABAgSmCAj0KUraECBAgACBzgUEeucF0j0CBAgQIDBFQKBPUdKGAAECBAh0LiDQOy+Q7hEgQIAAgSkCAn2KkjYECBAgQKBzAYHeeYF0jwABAgQITBEQ6FOUtCFAgAABAp0LCPTOC6R7BAgQIEBgioBAn6KkDQECBAgQ6FxAoHdeIN0jQIAAAQJTBAT6FCVtCBAgQIBA5wICvfMC6R4BAgQIEJgiINCnKGlDgAABAgQ6FxDonRdI9wgQIECAwBQBgT5FSRsCBAgQINC5gEDvvEC6R4AAAQIEpggI9ClK2hAgQIAAgc4FBHrnBdI9AgQIECAwRUCgT1HShgABAgQIdC4g0DsvkO4RIECAAIEpAv8H7n5W2P1mAOMAAAAASUVORK5CYII=	2025-08-04 06:37:01.016	1
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, name, email, phone, age, gender, created_at) FROM stdin;
1	John Doe	john@example.com	08123456789	17	male	2025-08-04 04:51:28.526
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
eed17e6e-a6b2-44e9-b982-206e2ba41844	0d4ef1d456a85ad7d6e1cac39bc90599be8f67c502b8e91274451fbb99d5d68b	2025-08-01 16:17:56.239569+07	20250728074930_init	\N	\N	2025-08-01 16:17:56.180352+07	1
9c2cfed9-f224-42f8-a865-926f820d401e	16a6cdd52eabd1094f2073a775cd225b9f3294d657c8a762ed345db3ea30eb0f	2025-08-01 16:17:56.243818+07	20250728075202_change_question_type_to_enum	\N	\N	2025-08-01 16:17:56.240562+07	1
cb8d544e-8dd3-47b3-85ea-742eb793c1d1	aea0a02db8209636ea7a113485a2074d1f5b2257d4d316f5a1733b3126f0e669	2025-08-01 16:17:56.245727+07	20250729030241_add_terms_to_question_type	\N	\N	2025-08-01 16:17:56.244375+07	1
43dc9dba-51da-43b9-ad6f-9e3b6186933e	762fc6df901c402efca5e563e38a78a1a6a2e1945960d551e252e95c8f58ac63	2025-08-01 16:17:56.264513+07	20250729034028_init	\N	\N	2025-08-01 16:17:56.246237+07	1
b684c822-5c4f-4852-b3d9-a6201fffa597	5a6f931465bc2c0cb3107634210640f7609c21d2f814db65cdcc70e4aee52380	2025-08-01 16:17:56.281037+07	20250731123533_pap	\N	\N	2025-08-01 16:17:56.264972+07	1
46b5647c-ddc5-4897-bbd2-0691012fd13a	2e9c56b92c9306ea6ba2916c2bb59e82c819536c6388345ea30a8c44c6f48819	2025-08-01 16:17:56.28466+07	20250801041148_add_fields_to_question	\N	\N	2025-08-01 16:17:56.281844+07	1
2a39e819-d8f0-453a-a72c-45a973cc9c8b	122d743a0403e77ad7e0ed9447f5b8826f2fbdbc55612d936eff004dd13c2eec	2025-08-01 16:17:56.286357+07	20250801041244_add_question_text_fields	\N	\N	2025-08-01 16:17:56.285089+07	1
6d356e57-0a7b-47bd-8a6f-6e59bd890b9c	122d743a0403e77ad7e0ed9447f5b8826f2fbdbc55612d936eff004dd13c2eec	2025-08-01 16:17:56.288252+07	20250801041344_make_question_text_fields_not_null	\N	\N	2025-08-01 16:17:56.286825+07	1
55ca099a-ca93-4586-a6be-a908c9534e40	122d743a0403e77ad7e0ed9447f5b8826f2fbdbc55612d936eff004dd13c2eec	2025-08-05 10:53:16.524169+07	20250805035220_init	\N	\N	2025-08-05 10:53:16.511813+07	1
\.


--
-- Name: Answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Answer_id_seq"', 1272, true);


--
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Category_id_seq"', 5, true);


--
-- Name: FormSubmission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."FormSubmission_id_seq"', 35, true);


--
-- Name: QuestionOption_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."QuestionOption_id_seq"', 23, true);


--
-- Name: Question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Question_id_seq"', 43, true);


--
-- Name: Signature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Signature_id_seq"', 9, true);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 1, true);


--
-- Name: Answer Answer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Answer"
    ADD CONSTRAINT "Answer_pkey" PRIMARY KEY (id);


--
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- Name: FormSubmission FormSubmission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FormSubmission"
    ADD CONSTRAINT "FormSubmission_pkey" PRIMARY KEY (id);


--
-- Name: QuestionOption QuestionOption_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionOption"
    ADD CONSTRAINT "QuestionOption_pkey" PRIMARY KEY (id);


--
-- Name: Question Question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Question"
    ADD CONSTRAINT "Question_pkey" PRIMARY KEY (id);


--
-- Name: Signature Signature_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Signature"
    ADD CONSTRAINT "Signature_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Category_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Category_name_key" ON public."Category" USING btree (name);


--
-- Name: Signature_userId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Signature_userId_key" ON public."Signature" USING btree ("userId");


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: Answer Answer_formSubmissionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Answer"
    ADD CONSTRAINT "Answer_formSubmissionId_fkey" FOREIGN KEY ("formSubmissionId") REFERENCES public."FormSubmission"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Answer Answer_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Answer"
    ADD CONSTRAINT "Answer_question_id_fkey" FOREIGN KEY (question_id) REFERENCES public."Question"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Answer Answer_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Answer"
    ADD CONSTRAINT "Answer_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: FormSubmission FormSubmission_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FormSubmission"
    ADD CONSTRAINT "FormSubmission_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: QuestionOption QuestionOption_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionOption"
    ADD CONSTRAINT "QuestionOption_question_id_fkey" FOREIGN KEY (question_id) REFERENCES public."Question"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Question Question_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Question"
    ADD CONSTRAINT "Question_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Signature Signature_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Signature"
    ADD CONSTRAINT "Signature_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

