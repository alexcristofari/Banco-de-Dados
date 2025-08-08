
-- ATIVIDADE 4: Criar o comando SQL para a criação do banco de dados BIBLIOTECA
CREATE DATABASE IF NOT EXISTS BIBLIOTECA;
USE BIBLIOTECA;

-- =================================================================

-- ATIVIDADE 5: Criar o comando SQL para a criação das tabelas solicitadas
CREATE TABLE autor (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50)
);

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);

CREATE TABLE editora (
    id_editora INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(50)
);

CREATE TABLE livro (
    ISBN VARCHAR(20) PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    ano_publicacao INT,
    id_autor INT,
    id_categoria INT,
    id_editora INT,
    FOREIGN KEY (id_autor) REFERENCES autor(id_autor),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
    FOREIGN KEY (id_editora) REFERENCES editora(id_editora)
);

-- =================================================================

-- ATIVIDADE 6: Criar o comando SQL para inserção dos referidos dados em todas as tabelas
-- Inserir Autores
INSERT INTO autor (nome, nacionalidade) VALUES
('J.K. Rowling', 'Britânica'),
('Machado de Assis', 'Brasileira'),
('George Orwell', 'Britânico'),
('J.R.R. Tolkien', 'Britânico'),
('Rick Riordan', 'Americano'),
('Suzanne Collins', 'Americana'),
('Paulo Coelho', 'Brasileiro');

-- Inserir Categorias
INSERT INTO categoria (descricao) VALUES
('Ficção Científica'),
('Romance'),
('Literatura Juvenil'),
('Fantasia'),
('Aventura'),
('Drama'),
('Autoajuda');

-- Inserir Editoras
INSERT INTO editora (nome, cidade) VALUES
('Rocco', 'Rio de Janeiro'),
('Record', 'São Paulo'),
('Penguin', 'Londres'),
('HarperCollins', 'Nova York'),
('Arqueiro', 'São Paulo'),
('Intrínseca', 'Rio de Janeiro'),
('Objetiva', 'Rio de Janeiro');

-- Inserir Livros
INSERT INTO livro (ISBN, titulo, ano_publicacao, id_autor, id_categoria, id_editora) VALUES
('978-3-16-148410-0', 'Harry Potter e a Pedra Filosofal', 2000, 1, 3, 1),
('978-85-01-12345-1', 'Dom Casmurro', 1899, 2, 2, 2),
('978-0-452-28423-4', '1984', 1949, 3, 1, 3),
('978-0-261-10267-4', 'O Senhor dos Anéis', 1954, 4, 4, 3),
('978-1-4231-5170-3', 'Percy Jackson e o Ladrão de Raios', 2005, 5, 3, 4),
('978-0-439-02348-1', 'Jogos Vorazes', 2008, 6, 3, 4),
('978-85-730-2446-8', 'O Alquimista', 1988, 7, 7, 5);

-- =================================================================

-- ATIVIDADE 7: Consulta para relacionar todos os dados dos livros em ordem alfabética de título
SELECT 
    l.ISBN,
    l.titulo AS 'Título',
    l.ano_publicacao AS 'Ano',
    a.nome AS 'Autor',
    a.nacionalidade AS 'Nacionalidade',
    c.descricao AS 'Categoria',
    e.nome AS 'Editora',
    e.cidade AS 'Cidade'
FROM livro l
JOIN autor a ON l.id_autor = a.id_autor
JOIN categoria c ON l.id_categoria = c.id_categoria
JOIN editora e ON l.id_editora = e.id_editora
ORDER BY l.titulo ASC;

-- =================================================================

-- ATIVIDADE 8: Consulta para relacionar todos os dados dos livros em ordem alfabética de Autor
SELECT 
    l.ISBN,
    l.titulo AS 'Título',
    l.ano_publicacao AS 'Ano',
    a.nome AS 'Autor',
    a.nacionalidade AS 'Nacionalidade',
    c.descricao AS 'Categoria',
    e.nome AS 'Editora',
    e.cidade AS 'Cidade'
FROM livro l
JOIN autor a ON l.id_autor = a.id_autor
JOIN categoria c ON l.id_categoria = c.id_categoria
JOIN editora e ON l.id_editora = e.id_editora
ORDER BY a.nome ASC;

-- =================================================================

-- ATIVIDADE 9: Consulta para relacionar todos os dados dos livros da categoria Literatura Juvenil em ordem decrescente
SELECT 
    l.ISBN,
    l.titulo AS 'Título',
    l.ano_publicacao AS 'Ano',
    a.nome AS 'Autor',
    a.nacionalidade AS 'Nacionalidade',
    c.descricao AS 'Categoria',
    e.nome AS 'Editora',
    e.cidade AS 'Cidade'
FROM livro l
JOIN autor a ON l.id_autor = a.id_autor
JOIN categoria c ON l.id_categoria = c.id_categoria
JOIN editora e ON l.id_editora = e.id_editora
WHERE c.descricao = 'Literatura Juvenil'
ORDER BY l.ano_publicacao DESC;

-- =================================================================

-- ATIVIDADE 10: Consulta para relacionar todos os dados dos Livros de Romance ou Ficção Científica com ano entre 2000 e 2010
SELECT 
    l.ISBN,
    l.titulo AS 'Título',
    l.ano_publicacao AS 'Ano',
    a.nome AS 'Autor',
    a.nacionalidade AS 'Nacionalidade',
    c.descricao AS 'Categoria',
    e.nome AS 'Editora',
    e.cidade AS 'Cidade'
FROM livro l
JOIN autor a ON l.id_autor = a.id_autor
JOIN categoria c ON l.id_categoria = c.id_categoria
JOIN editora e ON l.id_editora = e.id_editora
WHERE (c.descricao = 'Romance' OR c.descricao = 'Ficção Científica')
AND l.ano_publicacao BETWEEN 2000 AND 2010
ORDER BY l.ano_publicacao;
