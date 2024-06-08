-- Создание базы данных
CREATE DATABASE ElectricBankDB;
USE ElectricBankDB;

-- Создание таблицы физические лица
CREATE TABLE Individuals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    middle_name VARCHAR(50),
    passport VARCHAR(20),
    inn VARCHAR(12),
    snils VARCHAR(11),
    drivers_license VARCHAR(20),
    additional_documents TEXT,
    notes TEXT
);

-- Создание таблицы заёмные средства
CREATE TABLE Loans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    individual_id INT,
    amount DECIMAL(10, 2),
    interest_rate DECIMAL(5, 2),
    term INT,
    conditions TEXT,
    notes TEXT,
    FOREIGN KEY (individual_id) REFERENCES Individuals(id)
);

-- Создание таблицы кредиты для организаций
CREATE TABLE OrgLoans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    organization_id INT,
    individual_id INT,
    amount DECIMAL(10, 2),
    term INT,
    interest_rate DECIMAL(5, 2),
    conditions TEXT,
    notes TEXT,
    FOREIGN KEY (individual_id) REFERENCES Individuals(id)
);

-- Создание таблицы заёмщики
CREATE TABLE Borrowers (
    borrower_id INT AUTO_INCREMENT PRIMARY KEY,
    inn VARCHAR(12),
    entity_type TINYINT, -- 0 for individual, 1 for organization
    address VARCHAR(255),
    total_amount DECIMAL(10, 2),
    conditions TEXT,
    legal_notes TEXT,
    contract_list TEXT
);

-- Добавление столбца для связи с таблицей заёмщики в таблицу кредиты для организаций
ALTER TABLE OrgLoans
ADD COLUMN borrower_id INT,
ADD FOREIGN KEY (borrower_id) REFERENCES Borrowers(borrower_id);

-- Добавление столбца для связи с таблицей заёмщики в таблицу заёмные средства
ALTER TABLE Loans
ADD COLUMN borrower_id INT,
ADD FOREIGN KEY (borrower_id) REFERENCES Borrowers(borrower_id);