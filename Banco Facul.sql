#Nomes dos envolvidos: Luiz Fernando
#                      Brenda Gonçalves
#                      Peterson da Silva
#                      João Quinaglia
#                      Isabela Lima

CREATE DATABASE if not exists db_Faculdade;
USE db_Faculdade;

 CREATE TABLE tbl_Departamento(
 ID_Departamento INT PRIMARY KEY AUTO_INCREMENT,
 Nome_departamento VARCHAR(30) NOT NULL
 );

CREATE TABLE tb_Professor(
ID_Professor INT PRIMARY KEY AUTO_INCREMENT,
Nome_Professor VARCHAR(15) NOT NULL,
Sobrenome_Professor VARCHAR(50) NOT NULL,
ID_Departamento INT,
CONSTRAINT fk_id_departamento FOREIGN KEY(ID_Departamento) REFERENCES tbl_Departamento(ID_Departamento)	 
);

Describe tb_Professor;

CREATE TABLE tb_Curso(
ID_Curso INT PRIMARY KEY AUTO_INCREMENT,
Nome_Curso VARCHAR(30),
ID_Departamento INT NOT NULL,
CONSTRAINT fk_id_depart FOREIGN KEY(ID_Departamento) REFERENCES tbl_Departamento(ID_Departamento)
);

CREATE TABLE tb_Turma(
ID_Turma INT PRIMARY KEY AUTO_INCREMENT,
ID_Curso INT NOT NULL,
Periodo VARCHAR(10),
Num_Aluno INT,
Data_Inicio DATE,
Data_Fim DATE,
CONSTRAINT fk_id_curso FOREIGN KEY(ID_Curso) REFERENCES tb_Curso (ID_Curso)
);


CREATE TABLE tb_Disciplina(
ID_Disciplina INT PRIMARY KEY AUTO_INCREMENT,
Disciplina_Depende INT NULL,
Nome_Disciplina VARCHAR(30),
ID_Departamento INT NOT NULL,
Carga_Horaria INT NOT NULL,
Num_Aluno INT NOT NULL,
CONSTRAINT fk_departamento_ID FOREIGN KEY(ID_Departamento) REFERENCES tbl_Departamento(ID_Departamento),	
CONSTRAINT fk_ID_Disciplina FOREIGN KEY(Disciplina_Depende) REFERENCES tb_Disciplina(ID_Disciplina)
);

CREATE TABLE tb_Prof_Disc(
ID_Professor INT NOT NULL,
ID_Disciplina INT NOT NULL,
PRIMARY KEY(ID_Professor, ID_Disciplina),
CONSTRAINT fk_ID_Professor_Prof FOREIGN KEY (ID_Professor) REFERENCES tb_Professor (ID_Professor),
CONSTRAINT fk_ID_Disciplina_Prof FOREIGN KEY (ID_Disciplina) REFERENCES tb_Disciplina (ID_Disciplina)
);

CREATE TABLE tb_curso_disc(
ID_Curso INT NOT NULL,
ID_Disciplina INT NOT NULL,
PRIMARY KEY(ID_Curso,ID_Disciplina),
CONSTRAINT fk_ID_Curso_Disci FOREIGN KEY (ID_Curso) REFERENCES tb_Curso (ID_Curso),
CONSTRAINT fk_ID_Disciplina_Disci FOREIGN KEY (ID_Disciplina) REFERENCES tb_Disciplina (ID_Disciplina)
);

CREATE TABLE tb_Aluno(
RA INT PRIMARY KEY NOT NULL,
Nome_Aluno VARCHAR(20) NOT NULL,
Sobrenome_Aluno VARCHAR(50) NOT NULL,
CPF VARCHAR(12) NOT NULL,
ID_Turma INT NOT NULL,
ID_Curso INT NOT NULL,
Email VARCHAR(50),
Telefone VARCHAR(20),
CONSTRAINT fk_ID_Turma_Aluno FOREIGN KEY(ID_Turma) REFERENCES tb_Turma (ID_Turma),
CONSTRAINT fk_ID_Curso_Aluno FOREIGN KEY(ID_Curso) REFERENCES tb_Curso (ID_Curso)
);

CREATE TABLE tb_Aluno_Disc(
RA INT NOT NULL,
ID_Disciplina INT NOT NULL,
PRIMARY KEY(RA, ID_Disciplina),
 CONSTRAINT fk_RA FOREIGN KEY (RA) REFERENCES tb_Aluno (RA),
 CONSTRAINT fk_ID_Disciplina_Aluno FOREIGN KEY (ID_Disciplina) REFERENCES tb_Disciplina (ID_Disciplina)
);

CREATE TABLE tb_Historico(
ID_Historico INT PRIMARY KEY AUTO_INCREMENT,
RA INT NOT NULL,
Data_Inicio DATE NOT NULL,
Data_Fim DATE,
CONSTRAINT fk_RA_Aluno FOREIGN KEY (RA) REFERENCES tb_Aluno(RA)
);

CREATE TABLE tb_Disc_Hist(
ID_Historico INT NOT NULL,
ID_Disciplina INT NOT NULL,
Nota INT,
Frequencia INT,
PRIMARY KEY (ID_Historico, ID_Disciplina),
CONSTRAINT fk_ID_Historico FOREIGN KEY (ID_Historico) REFERENCES tb_Historico (ID_Historico),
CONSTRAINT fk_ID_Disciplina_Hist FOREIGN KEY (ID_Disciplina) REFERENCES tb_Disciplina (ID_Disciplina)
);

CREATE TABLE tb_Telefone(
ID_Telefone INT PRIMARY KEY AUTO_INCREMENT,
Tipo_Telefone VARCHAR(20)
);

CREATE TABLE tb_Telefones_Aluno (
ID_Telefones_Aluno INT PRIMARY KEY AUTO_INCREMENT,
RA INT NOT NULL,
ID_Telefone INT NOT NULL,
Num_Telefone VARCHAR(20) NOT NULL,
CONSTRAINT fk_ID_RA_Tel FOREIGN KEY (RA) REFERENCES tb_Aluno (RA),
CONSTRAINT fk_ID_Telefone FOREIGN KEY (ID_Telefone) REFERENCES tb_Telefone (ID_Telefone)
);

CREATE TABLE tb_Endereco_Aluno (
ID_Endereco_Aluno INT PRIMARY KEY AUTO_INCREMENT,
RA INT NOT NULL,
Nome_Rua VARCHAR(50) NOT NULL,
Num_Rua INT NOT NULL,
Complemento VARCHAR(20) NULL,
CEP VARCHAR(8) NOT NULL,
CONSTRAINT fk_RA_End FOREIGN KEY(RA) REFERENCES tb_Aluno (RA)
);

# Inserindo dados no banco:
INSERT INTO tb_Professor (ID_Departamento, Nome_Professor, Sobrenome_Professor)
Values 
(1, 'Andrea', 'Gomes'),
(1, 'Gilson', 'Pereira'),
(1, 'Fabiana', 'Almeida');

Select * From tb_Professor;

Insert into tb_Curso (ID_Departamento, Nome_Curso)
Values 
(1, 'Engenharia de Produção'),
(1, 'Química'),
(1, 'Administração de Empresas');

Select * From tb_Curso;

Insert into tb_Turma (Periodo, Num_Aluno, Data_Inicio, Data_Fim, ID_Curso)
Values 
('Manhã', 30, '20201005', '20231006', 1),
('Tarde', 30, '20201005', '20231006', 2),
('Noite', 30, '20201005', '20231006', 3);

Select * from tb_Turma;

Insert into tb_Disciplina (ID_Departamento, Nome_Disciplina, Carga_Horaria, Num_Aluno)
Values 
(1, 'Desenho Técnico', 30, 30),
(1, 'Química Analítica', 60, 30),
(1, 'Administração Interdisciplinar', 30, 30);

Select * from tb_Disciplina;

Insert into tb_Aluno (RA, Nome_Aluno, Sobrenome_Aluno, CPF, Email, Telefone, ID_Turma, ID_Curso)
Values 
(247680, 'Brenda', 'Gonçalves', '29356730990', 'brendagoncalves1@gmail.com', '1194536045', 1, 1),
(230920, 'Luiz Fernando', 'Coelho', '49202345676', 'luizfernandocoelho@gmail.com', '1190394393', 2, 2),
(228140,'Peterson', 'Silva', '23945678978', 'petersonsilva20@gmail.com', '1194567412', 3, 3);

Select * from tb_Aluno;

Insert into tbl_Departamento (Nome_Departamento)
Values 
('Ciência');

Select * From tbl_Departamento;

Insert into tb_Historico (RA, Data_Inicio, Data_Fim)
Values
(247680, '20201005', '20231006'),
(230920, '20201005', '20231006'),
(228140, '20201005', '20231006'); 

Select * from tb_Historico;

Insert into tb_Prof_Disc 
Values 
(4,1), (5,2), (6,3);

Select * from tb_Prof_Disc;

Insert into tb_Aluno_Disc
Values 
(247680, 1), (230920, 2), (228140, 3);

Select * from tb_Aluno_Disc;

Insert into tb_Curso_Disc
Values 
(1, 1), (2, 2), (3, 3);

Select * from tb_Curso_Disc; 

Insert into tb_Disc_Hist (ID_Disciplina, ID_Historico, Nota, Frequencia)
Values 
(1, 1, 9, 98),
(2, 2, 8, 70),
(3, 3, 7, 90);

Select * from tb_Disc_Hist;

Insert into tb_Telefone (Tipo_Telefone)
Values 
('Residencial'),
('Residencial'),
('Residencial');

Select * from tb_Telefone;

Insert into tb_Telefones_Aluno (RA, ID_Telefone, Num_Telefone)
Values 
(247680, 1, '1194536045'), 
(230920, 2, '1190394393'),
(228140, 3, '1194567412');

Insert into tb_Endereco_Aluno (RA, Nome_Rua, Num_Rua, Complemento, CEP)
Values 
(247680, 'Rua Jardim das Flores', 143, NULL, '04657129'),
(230920, 'Rua José Bento', 675, 'Apart 45', '02345690'),
(228140, 'Rua Antonio Bandeiras', 1094, NULL, '04653190');  


# Consultas:

#1
Select concat(Nome_Professor, ' ',Sobrenome_Professor) as Professor, Nome_Disciplina as Disciplina, tb_Professor.ID_Professor as ID
From tb_Professor 
Inner Join tb_Prof_Disc
   On tb_Professor.ID_Professor = tb_Prof_Disc.ID_Professor 
Inner Join tb_Disciplina
   On tb_Disciplina.ID_Disciplina = tb_Prof_Disc.ID_Disciplina
Where tb_Professor.ID_Professor = 6;

#2
Select Data_Inicio as 'Início', Nome_Curso as Curso 
from tb_Turma
Inner Join tb_Curso 
   On tb_Turma.ID_Curso = tb_Curso.ID_Curso
Where tb_Turma.ID_Curso = 1;

#3
Select tb_Aluno.RA as RA, Nome_Aluno as Nome, Nome_Disciplina as Disciplina 
From tb_Aluno 
Inner Join tb_Aluno_Disc
   On tb_Aluno.RA = tb_Aluno_Disc.RA
Inner Join tb_Disciplina 
   On tb_Disciplina.ID_Disciplina = tb_Aluno_Disc.ID_Disciplina
Where tb_Aluno.RA = 247680;

#4
Select Nome_Curso as Curso, Nome_Disciplina as Disciplina 
From tb_Curso 
Inner Join tb_Curso_Disc
   On tb_Curso.ID_Curso = tb_Curso_Disc.ID_Curso
Inner Join tb_Disciplina
  On tb_Disciplina.ID_Disciplina = tb_Curso_Disc.ID_Disciplina
Where tb_Disciplina.ID_Disciplina = 2;

#5
Select Frequencia as Frequencia, Nome_Disciplina as Disciplina 
from tb_Disc_Hist
Inner Join tb_Disciplina
   On tb_Disciplina.ID_Disciplina = tb_Disc_Hist.ID_Disciplina
Where tb_Disc_Hist.ID_Disciplina = 3;

#6
Select Nome_Aluno as Aluno, Nome_Rua as Rua, Num_Rua as Número, CEP, Nome_Curso as Curso
from tb_Endereco_Aluno 
Inner Join tb_Aluno
   On tb_Aluno.RA = tb_Endereco_Aluno.RA
Inner Join tb_Curso
   On tb_Curso.ID_Curso = tb_Aluno.ID_Curso;
   
#7
Select concat(Nome_Professor, ' ', Sobrenome_Professor) as Professor, Nome_Disciplina as Disciplina 
From tb_Professor 
Inner Join tb_Prof_Disc
   On tb_Professor.ID_Professor = tb_Prof_Disc.ID_Professor
Inner Join tb_Disciplina
   On tb_Disciplina.ID_Disciplina = tb_Prof_Disc.ID_Disciplina
   Where tb_Disciplina.ID_Disciplina = 3;

#8
Select Nome_Aluno as Aluno, Num_Telefone as Telefone, Tipo_Telefone as Tipo 
From tb_Telefones_Aluno 
Inner Join tb_Telefone
   On tb_Telefone.ID_Telefone = tb_Telefones_Aluno.ID_Telefone
Inner Join tb_Aluno 
   On tb_Aluno.RA = tb_Telefones_Aluno.RA;
   
#9 
Select Nome_Professor as Professor, Nome_Departamento as Departamento
From tb_Professor
Inner Join tbl_Departamento
  On tbl_Departamento.ID_Departamento = tb_Professor.ID_Departamento;

#10  
Select tb_Curso.ID_Curso as ID, Nome_Curso as Curso, tb_Disciplina.ID_Disciplina as ID, Nome_Disciplina as Disciplina, Nome_Departamento as Departamento
From tb_Curso 
Inner Join tb_Curso_Disc
    On tb_Curso.ID_Curso =  tb_Curso_Disc.ID_Curso 
Inner Join tb_Disciplina 
    On tb_Disciplina.ID_Disciplina = tb_Curso_Disc.ID_Disciplina
Inner Join tbl_Departamento 
    On tbl_Departamento.ID_Departamento = tb_Curso.ID_Departamento;




