# Nome do compilador
CC = gcc

# Nome do executável que será gerado
EXEC = meu_programa

# Diretórios do projeto
SRCDIR = src
INCDIR = inc
OBJDIR = obj
BINDIR = bin

# Flags de compilação
# -Wall: Habilita todos os avisos (warnings) do compilador.
# -I$(INCDIR): Adiciona o diretório 'inc' à lista de busca por arquivos de cabeçalho (.h).
# -fopenmp: Habilita o suporte à biblioteca OpenMP.
# -g: Adiciona informações de depuração (útil para usar com gdb).
CFLAGS = -Wall -I$(INCDIR) -fopenmp -g

# Flags de linkagem (necessário para OpenMP)
LDFLAGS = -fopenmp

# --- Geração automática de listas de arquivos ---

# Encontra todos os arquivos .c no diretório 'src'
SOURCES = $(wildcard $(SRCDIR)/*.c)

# Cria uma lista de arquivos de objeto (.o) correspondentes aos arquivos .c,
# mas no diretório 'obj'.
OBJECTS = $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SOURCES))

# --- Regras do Makefile ---

# O alvo '.PHONY' declara regras que não produzem arquivos com o mesmo nome.
.PHONY: all run clean help

# Regra padrão (executada ao digitar apenas 'make')
all: $(BINDIR)/$(EXEC)

# Regra para executar o programa
# Depende de 'all', garantindo que o projeto seja compilado antes de rodar.
run: all
	@echo "--- Executando o programa ---"
	./$(BINDIR)/$(EXEC)

# Regra para criar o executável final
# Depende de todos os arquivos de objeto (.o).
$(BINDIR)/$(EXEC): $(OBJECTS)
	@mkdir -p $(BINDIR) # Cria o diretório 'bin' se ele não existir
	@echo "--- Linkando o executável ---"
	$(CC) $(OBJECTS) -o $@ $(LDFLAGS)
	@echo "Executável '$(EXEC)' criado em '$(BINDIR)/'."

# Regra para compilar os arquivos .c em arquivos de objeto .o
# Esta é uma regra de padrão que compila qualquer .c de 'src' para um .o em 'obj'.
$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(OBJDIR) # Cria o diretório 'obj' se ele não existir
	$(CC) $(CFLAGS) -c $< -o $@

# Regra para limpar os arquivos gerados (executável e objetos)
clean:
	@echo "--- Limpando o projeto ---"
	rm -rf $(OBJDIR) $(BINDIR)
	@echo "Diretórios '$(OBJDIR)' e '$(BINDIR)' removidos."

# Regra de ajuda para exibir os comandos disponíveis
help:
	@echo "Comandos disponíveis:"
	@echo "  make all    - Compila o projeto (padrão)."
	@echo "  make run    - Compila e executa o projeto."
	@echo "  make clean  - Remove os arquivos gerados pela compilação."
	@echo "  make help   - Mostra esta mensagem de ajuda."
