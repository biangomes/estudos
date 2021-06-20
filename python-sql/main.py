# Import SQL driver e pandas
import pyodbc



# Criando a conexao 
conn = pyodbc.connect('Driver={SQL Server};'
                    'Server=DESKTOP-3TFNKAR;'
                    'Database=Empresa;'
                    'Trusted_Connection=yes;')


# Criando um cursor: é uma instância usada para invocar métodos que tornam possível a execucao de sql
cursor = conn.cursor()


# Criando uma tabela no banco Empresa
tabela1 = cursor.execute("""
CREATE TABLE Funcionario (
    id INT PRIMARY KEY NOT NULL,
    nome VARCHAR (100),
    cpf VARCHAR (13),
    email VARCHAR(40)
)
""")


# Inserindo um registro na tabela Funcionario
valores1 = cursor.execute("""
INSERT INTO Funcionario (id, nome, cpf, email) 
VALUES (1, 'Beatriz', '44687700071', 'beatriz.teste@gmail.com'),
       (2, 'Ana', '20510742084', 'ana.teste@gmail.com'),
       (3, 'Diogo', '42450407006', 'diogo.teste@gmail.com')
""")


# Imprimindo o registro inserido anteriormente
cursor.execute('SELECT * FROM Empresa.dbo.Funcionario')
for row in cursor:
    print(row)


# Lendo o SQL e armazenando em um DataFrame
# Utilizamos o conn, pois eh o objeto que faz a conexao com o banco
data = pd.read_sql('SELECT * FROM Empresa.dbo.Funcionario', conn)
print(type(data))