-- ============================================
-- CPSC 332 - Project
-- File: create_tables_group5.sql
-- Group: Group 5
-- Members: Alexia Arroyo Tellez, Andrew Davalos,
--          Nathan Smith, Nithin Rajesh
-- Date: March 30, 2026
-- ============================================

-- ============================================
-- SECTION 1: DATABASE SETUP
-- ============================================

DROP DATABASE IF EXISTS world_group5;
CREATE DATABASE world_group5;
USE world_group5;

-- ============================================
-- SECTION 2: WORLD DB TABLES (DO NOT MODIFY)
-- ============================================

-- Country table
CREATE TABLE Country (
  Code CHAR(3) NOT NULL DEFAULT '',
  Name CHAR(52) NOT NULL DEFAULT '',
  Continent ENUM('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') NOT NULL default 'Asia',
  Region CHAR(26) NOT NULL DEFAULT '',
  SurfaceArea FLOAT(10,2) NOT NULL DEFAULT '0.00',
  IndepYear SMALLINT(6) DEFAULT NULL,
  Population INT(11) DEFAULT NULL,
  LifeExpectancy FLOAT(3,1) DEFAULT NULL,
  GNP FLOAT(10,2) DEFAULT NULL,
  GNPOld FLOAT(10,2) DEFAULT NULL,
  LocalName CHAR(45) NOT NULL DEFAULT '',
  GovernmentForm CHAR(45) NOT NULL DEFAULT '',
  HeadOfState CHAR(60) DEFAULT NULL,
  Capital INT(11) DEFAULT NULL,
  Code2 CHAR(2) NOT NULL DEFAULT '',
  PRIMARY KEY (Code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- City table
CREATE TABLE City (
  ID INT(11) NOT NULL auto_increment,
  Name CHAR(35) NOT NULL DEFAULT '',
  CountryCode CHAR(3) NOT NULL DEFAULT '',
  District CHAR(20) NOT NULL DEFAULT '',
  Population INT(11) DEFAULT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- CountryLanguage table
CREATE TABLE CountryLanguage (
  CountryCode CHAR(3) NOT NULL DEFAULT '',
  Language CHAR(30) NOT NULL DEFAULT '',
  IsOfficial ENUM('T','F') NOT NULL DEFAULT 'F',
  Percentage FLOAT(4,1) NOT NULL DEFAULT '0.0',
  PRIMARY KEY (CountryCode, Language)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ============================================
-- SECTION 3: WORLD DB FOREIGN KEYS (DO NOT MODIFY)
-- ============================================

ALTER TABLE City
    ADD CONSTRAINT fk_city_country
    FOREIGN KEY (CountryCode) REFERENCES Country(Code);

ALTER TABLE CountryLanguage
    ADD CONSTRAINT fk_countryLanguage_country
    FOREIGN KEY (CountryCode) REFERENCES Country(Code);

-- ============================================
-- SECTION 4: YOUR NEW TABLES
-- ============================================

-- New Table 1: Economic_Indicators
-- Purpose: Stores yearly economic data for each country
CREATE TABLE Economic_Indicators (
    country_code    CHAR(3)         NOT NULL DEFAULT '',
    year            INT             NOT NULL,
    gdp_usd         DECIMAL(15,2)   DEFAULT NULL,
    gdp_per_capita  DECIMAL(10,2)   DEFAULT NULL,
    inflation_rate  DECIMAL(5,2)    DEFAULT NULL,
    PRIMARY KEY (country_code, year),
    CONSTRAINT fk_econ_country
        FOREIGN KEY (country_code) REFERENCES Country(Code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- New Table 2: Trade_Statistics
-- Purpose: Stores yearly import and export data for each country
CREATE TABLE Trade_Statistics (
    trade_id        INT             NOT NULL AUTO_INCREMENT,
    country_code    CHAR(3)         NOT NULL DEFAULT '',
    year            INT             NOT NULL,
    exports_usd     DECIMAL(15,2)   DEFAULT NULL,
    imports_usd     DECIMAL(15,2)   DEFAULT NULL,
    trade_balance   DECIMAL(15,2)   DEFAULT NULL,
    PRIMARY KEY (trade_id),
    CONSTRAINT fk_trade_country
        FOREIGN KEY (country_code) REFERENCES Country(Code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- New Table 3: Labor_Force
-- Purpose: Stores yearly workforce data for each country
CREATE TABLE Labor_Force (
    country_code        CHAR(3)         NOT NULL DEFAULT '',
    year                INT             NOT NULL,
    labor_rate          DECIMAL(5,2)    DEFAULT NULL,
    female_rate         DECIMAL(5,2)    DEFAULT NULL,
    youth_unemp         DECIMAL(5,2)    DEFAULT NULL,
    PRIMARY KEY (country_code, year),
    CONSTRAINT fk_labor_country
        FOREIGN KEY (country_code) REFERENCES Country(Code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;