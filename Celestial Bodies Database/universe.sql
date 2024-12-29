--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy_enum; Type: TYPE; Schema: public; Owner: freecodecamp
--

CREATE TYPE public.galaxy_enum AS ENUM (
    'spiral',
    'elliptical',
    'irregular'
);


ALTER TYPE public.galaxy_enum OWNER TO freecodecamp;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(50),
    galaxy_type public.galaxy_enum NOT NULL,
    age_in_million_of_years integer,
    description text
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(250),
    has_life boolean,
    description text,
    planet_id integer NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(250) NOT NULL,
    has_life boolean NOT NULL,
    description text,
    star_id integer NOT NULL
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    distance numeric(5,2) NOT NULL,
    measure character varying(10) NOT NULL,
    galaxy_id integer NOT NULL,
    name character varying(250) NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public."user" (
    user_id integer NOT NULL,
    name character varying(255),
    email character varying(255) NOT NULL,
    birthday date NOT NULL,
    age integer,
    unit integer NOT NULL
);


ALTER TABLE public."user" OWNER TO freecodecamp;

--
-- Name: user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.user_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_user_id_seq OWNER TO freecodecamp;

--
-- Name: user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.user_user_id_seq OWNED BY public."user".user_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Name: user user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public."user" ALTER COLUMN user_id SET DEFAULT nextval('public.user_user_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Andromeda', 'spiral', NULL, NULL);
INSERT INTO public.galaxy VALUES (2, 'Traingulum', 'spiral', NULL, NULL);
INSERT INTO public.galaxy VALUES (3, 'Milky Way', 'spiral', NULL, NULL);
INSERT INTO public.galaxy VALUES (4, 'Whirlpool', 'spiral', 11000, 'A well-known spiral galaxy in the constellation Canes Venatici.');
INSERT INTO public.galaxy VALUES (5, 'Sombrero', 'spiral', 13000, 'A spiral galaxy located in the Virgo Cluster, resembling a wide-brimmed hat.');
INSERT INTO public.galaxy VALUES (6, 'Messier 87', 'elliptical', 13000, 'An elliptical galaxy in the Virgo Cluster, known for its supermassive black hole.');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (3, 'Moon', false, 'Earth''s only natural satellite. It influences tides and has been explored by humans.', 12);
INSERT INTO public.moon VALUES (4, 'Phobos', false, 'A small, irregularly shaped moon of Mars. It orbits closer to its planet than any other moon in the Solar System.', 13);
INSERT INTO public.moon VALUES (5, 'Deimos', false, 'The smaller and more distant of Mars'' two moons. It has a smoother surface compared to Phobos.', 13);
INSERT INTO public.moon VALUES (6, 'Io', false, 'The most volcanically active body in the Solar System, due to gravitational interactions with Jupiter.', 14);
INSERT INTO public.moon VALUES (7, 'Europa', false, 'A moon with a subsurface ocean beneath an icy crust, making it a candidate for hosting microbial life.', 14);
INSERT INTO public.moon VALUES (8, 'Ganymede', false, 'The largest moon in the Solar System and the only moon known to have its own magnetic field.', 14);
INSERT INTO public.moon VALUES (9, 'Callisto', false, 'A heavily cratered moon, one of the oldest surfaces in the Solar System.', 14);
INSERT INTO public.moon VALUES (10, 'Titan', false, 'Saturn''s largest moon, with a thick atmosphere and lakes of liquid methane and ethane.', 15);
INSERT INTO public.moon VALUES (11, 'Enceladus', false, 'A moon with geysers that eject water vapor and organic compounds, suggesting a subsurface ocean.', 15);
INSERT INTO public.moon VALUES (12, 'Mimas', false, 'Known for its large impact crater, giving it a resemblance to the Death Star.', 15);
INSERT INTO public.moon VALUES (13, 'Tethys', false, 'A moon with a large valley called Ithaca Chasma and many craters.', 15);
INSERT INTO public.moon VALUES (14, 'Rhea', false, 'Saturn''s second-largest moon, with a surface composed mostly of ice.', 15);
INSERT INTO public.moon VALUES (15, 'Iapetus', false, 'Known for its two-tone coloration, with one side much darker than the other.', 15);
INSERT INTO public.moon VALUES (16, 'Miranda', false, 'An ice-rich moon with dramatic surface features, including giant canyons.', 16);
INSERT INTO public.moon VALUES (17, 'Ariel', false, 'A moon with a mix of young and old terrains, possibly indicating geological activity.', 16);
INSERT INTO public.moon VALUES (18, 'Umbriel', false, 'A dark, heavily cratered moon of Uranus.', 16);
INSERT INTO public.moon VALUES (19, 'Titania', false, 'The largest moon of Uranus, with a mix of craters and valleys.', 16);
INSERT INTO public.moon VALUES (20, 'Oberon', false, 'The outermost of Uranus'' major moons, with a heavily cratered icy surface.', 16);
INSERT INTO public.moon VALUES (21, 'Triton', false, 'Neptune''s largest moon, with a retrograde orbit and geysers of nitrogen gas.', 17);
INSERT INTO public.moon VALUES (22, 'Nereid', false, 'A small, irregularly shaped moon with an eccentric orbit.', 17);
INSERT INTO public.moon VALUES (23, 'Proteus', false, 'An irregularly shaped moon of Neptune, one of the largest irregular bodies in the Solar System.', 17);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Tau Ceti B', false, 'A super Earth planet, located close to the star, possibly too hot to support life as we know it', 2);
INSERT INTO public.planet VALUES (12, 'Earth', true, 'The only knwon planet to support life. It has a diverse ecosystem, a stable atmosphere, and liquid water on its surface.', 1);
INSERT INTO public.planet VALUES (13, 'Mars', false, 'Known as the Red Planet due to iron oxide on its surface. It has the potential to support microbial life, but no definitive evidence of life has been found yet', 1);
INSERT INTO public.planet VALUES (14, 'Jupiter', false, 'The largest planet in the Solar Syste. It is a gas giant with no solid surface and is known for its great Red Spot, a massive strom', 1);
INSERT INTO public.planet VALUES (15, 'Saturn', false, 'A gas giant known for its stunning ring system composed of ice and rock particles. It has many moons, some of which may harbor conditions for life', 1);
INSERT INTO public.planet VALUES (16, 'Uranus', false, 'An ice giant with a pale blue colordue to methan in its atmosphere. It has a unique sideways rotation compared to otherplanets', 1);
INSERT INTO public.planet VALUES (17, 'Neptune', false, 'An ice giant the fathest planet from the Sun. It is known for its deep blue color and strong winds', 1);
INSERT INTO public.planet VALUES (2, 'Tau Ceti C', false, 'A super earth with conditions likely too extreme for liquid water or life.', 2);
INSERT INTO public.planet VALUES (3, 'Tau Ceti D', false, 'Potentially in the habitable zone, but its surface conditions are still uncertain', 2);
INSERT INTO public.planet VALUES (4, 'Tau Ceti E', false, 'Located in the inner edge of the habitable zone; could theoretically have conditions suitable for liquid water, but high radition levels may prevent life', 2);
INSERT INTO public.planet VALUES (5, 'Tau Ceti F', false, 'Located in the outer edge of the habitable zone; its environment is likely cold potetially with frozen water', 2);
INSERT INTO public.planet VALUES (6, 'Proxima Centauri b', false, 'A rocky planet in the habitable zone of Proxima Centauri; it could potentially support liquid water, but its environment is likely affected by stellar flares', 3);
INSERT INTO public.planet VALUES (7, 'Proxima Centauri c', false, 'A super-Earth located further from Proxiuma Centauri: likey too cold to support life', 3);
INSERT INTO public.planet VALUES (8, 'Proxima Centauri d', false, 'A candidate planet much closer to the star than Proxima b: conditions are likely harsh for life', 3);
INSERT INTO public.planet VALUES (9, 'Mercury', false, 'The smallest planet in the Solar System and closest to the Sun, It has a thin atmosphere and extreme temperatures', 1);
INSERT INTO public.planet VALUES (10, 'Venus', false, 'A rocky planet with a thick, toxic atmosphere composed mostly of carbon dioxide. Its surface is extremely hoy due to a runaway greenouse effect', 1);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 1.00, 'AU', 3, 'Sun');
INSERT INTO public.star VALUES (2, 11.75, 'LY', 3, 'Tau Ceit');
INSERT INTO public.star VALUES (3, 4.36, 'LY', 3, 'Alpha Centauri');
INSERT INTO public.star VALUES (4, 127.00, 'LY', 2, 'Beta Trianguli Triangulum');
INSERT INTO public.star VALUES (5, 63.30, 'LY', 2, 'Alpa Trianguli Triangulumn Alpheratz');
INSERT INTO public.star VALUES (6, 97.00, 'LY', 1, 'Alpheratz Andromeda');
INSERT INTO public.star VALUES (7, 197.00, 'LY', 1, 'Mirach Anromeda');
INSERT INTO public.star VALUES (8, 390.00, 'LY', 1, 'Gamma Andromedae');


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public."user" VALUES (1, 'John Doe', 'john.doe@example.com', '1990-05-15', 34, 101);
INSERT INTO public."user" VALUES (2, 'Jane Smith', 'jane.smith@example.com', '1985-11-22', 39, 102);
INSERT INTO public."user" VALUES (3, 'Alice Johnson', 'alice.johnson@example.com', '1992-08-30', 32, 103);
INSERT INTO public."user" VALUES (5, 'John Doe', 'john.do3e@example.com', '1990-05-15', 34, 101);
INSERT INTO public."user" VALUES (6, 'Jane Smith', 'jane.smit2h@example.com', '1985-11-22', 39, 102);
INSERT INTO public."user" VALUES (7, 'Alice Johnson', 'alice1.johnson@example.com', '1992-08-30', 32, 103);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 23, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 18, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 8, true);


--
-- Name: user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.user_user_id_seq', 7, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: user user_email_unique; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_unique UNIQUE (email);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (user_id);


--
-- Name: star fk_galaxy_id; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fk_galaxy_id FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- PostgreSQL database dump complete
--

