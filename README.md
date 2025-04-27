
# Descrição:

Aplicação em Flutter que é capaz de fazer pedidos POST http. Projetada para ser utilizada em conjunto com a aplicação *CrudAlunosSpringReactMongoDB*

# Requisitos:
- Flutter SDK
- IDE configurada para flutter.

(A api que usei para teste é o mesmo backend que compõe o projeto crudAlunosMongoDB em: https://github.com/Skheier/CrudAlunosSpringReactMongoDB.git)
E seus respectivos requisitos:
- Java 17.
- MongoDb.
- Maven.

# Setup:

- inicie uma nova aplicação base do flutter com o comando "flutter create *nome_do_projeto*".

- Instale a dependência para fazer pedidos http. com o comando "flutter pub add http".
Mais informações em "https://pub.dev/packages/http/install".

- E substitua o arquivo "main.dart" na pasta "/lib" do projeto pelo main.dart do repositório & salve o projeto.

- Execute o comando *flutter run* na pasta "/lib" e a aplicção será iniciada.

# Uso:
Preencha o campo da URL com o destino desejado ("http://localhost:8081/new" neste caso. Ou outro port caso tenha alterado no aplication.properties da API, ou utilizado outra API compatível para o test).

- Preencha todos os campos corretamente e clique em post e seu pedido terá sido feito.


# Altores:
- Mathias Moura / 04722-102
- Vitor Lima    / 04719-302
