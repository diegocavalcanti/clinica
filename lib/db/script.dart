const sqlDropTableCliente = ''' DROP TABLE IF EXISTS clientes ''';

const sqlCreateTableCliente = ''' CREATE TABLE clientes ( 
          id  INTEGER PRIMARY KEY AUTOINCREMENT, 
          nome TEXT NOT NULL,
          email TEXT,
          responsavel TEXT,
          celular TEXT,
          observacoes TEXT  
          )
      ''';

const sqlDropTableAtendimentos = ''' DROP TABLE IF EXISTS atendimentos ''';

const sqlCreateTableAtendimentos = ''' CREATE TABLE atendimentos ( 
          id  INTEGER PRIMARY KEY AUTOINCREMENT, 
          idCliente INTEGER NOT NULL,
          data INTEGER  NOT NULL,
          texto TEXT
          )
      ''';

const sqlDropTablePagamentos = ''' DROP TABLE IF EXISTS pagamentos ''';

const sqlCreateTablePagamentos = ''' CREATE TABLE pagamentos ( 
          id  INTEGER PRIMARY KEY AUTOINCREMENT, 
          idCliente INTEGER NOT NULL,
          dataPagamento INTEGER  NOT NULL,
          quantidade INTEGER,
          valorSessao REAL,
          valorTotal REAL,
          observacoes TEXT
          )
      ''';
