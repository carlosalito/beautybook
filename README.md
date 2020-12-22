# BeautyBook
<img src="https://github.com/carlosalito/beautybook/blob/master/app/assets/images/logo.png" height="50">

Microblogging e app de novidades. 

## Dados técnicos - App

- A gestão de estado foi feita com **Mobx** com auxílio de injeção de dependências a partir do service locator **get_it**;
- A persistência local dos dados foi feita com **Hive**; 
- Controle de usuário e gestão de Json Web Token feita com **Firebase Auth**;

## Dados técnicos - Backend

- Backend desenvolvido com **NestJS, Elasticsearch, Firebase firestore**;
- Servidor http **NGinx** para servir o backend https;
- **Certbot** para gerenciar certificados SSL **Let's Encrypt**; 
- Todo backend e suas ferramentas estão "containerizado" e orquestrado com docker-compose;

## Tasks
- [x] Tela de splash screen;
- [x] Tela de login;
- [x] Tela de cadastro de novo usuário;
- [x] Tela para listar postagens;
- [x] Tela para listar as últimas novidades;
- [x] Tela para fazer um novo post;
- [x] Possibilidade de editar e excluir um post próprio que foi publicado;
- [x] Lista de postagens populada;

## Diferenciais (Opcionais)

- Construção de toda um backend com controle de acesso via JWT e com segurança SSL;
- Login social com **Google** e **Facebook**;
- Foto no cadastro do usuário;
- Fotos nos posts;
- Tela de edição do usuário;
- Suporte as linguagens **Português - Brasil** e **Inglês - EUA**;
- Modo escuro e modo claro;
- Controle realtime de novas postagens na timeline;

## Distribuição
A pasta *dist* contem os abis das 3 arquiteturas separadas, visando ter um menor apk no teste de uso. Contudo, normalmente, nos celulares atuais a arquitetura mais comum de ser encontrada é arm64 disponível em [beautybook arm64 apk](/dist/beautybook-arm64.apk)
