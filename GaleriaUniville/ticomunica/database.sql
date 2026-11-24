-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: galeria_univille
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `artista_linguagens`
--

LOCK TABLES `artista_linguagens` WRITE;
/*!40000 ALTER TABLE `artista_linguagens` DISABLE KEYS */;
INSERT INTO `artista_linguagens` (`artista_id`, `linguagem`) VALUES (2,'artes');
INSERT INTO `artista_linguagens` (`artista_id`, `linguagem`) VALUES (3,'artes');
INSERT INTO `artista_linguagens` (`artista_id`, `linguagem`) VALUES (3,'fotografia');
INSERT INTO `artista_linguagens` (`artista_id`, `linguagem`) VALUES (4,'cinema');
INSERT INTO `artista_linguagens` (`artista_id`, `linguagem`) VALUES (4,'fotografia');
INSERT INTO `artista_linguagens` (`artista_id`, `linguagem`) VALUES (6,'cinema');
INSERT INTO `artista_linguagens` (`artista_id`, `linguagem`) VALUES (7,'artes');
/*!40000 ALTER TABLE `artista_linguagens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `artistas`
--

LOCK TABLES `artistas` WRITE;
/*!40000 ALTER TABLE `artistas` DISABLE KEYS */;
INSERT INTO `artistas` (`id`, `nome`, `email`, `senha_hash`, `bio`, `vinculo`, `curso`, `periodo`, `foto`, `instagram_url`, `contato_email`, `contato`, `perfil_publico`, `criado_em`) VALUES (2,'PASSOCA','p4ssoca@gmail.com','scrypt:32768:8:1$2Aa40a08WE6LcTvY$56dcc056d3d7e6ecdaf89bb95606c3676de09c626a0de7357c4635e6ee5bc92b6c9e0d91a4df54286b7960cd5e1cf31120e575ff2027cca24ab40d897f3670e0','Passoca nasceu em Joinville - SC, pinta desde os sete anos e usa dos meios artísticos como expressão do que sente que deve ser dito sobre si e seu redor. Hoje cursa Artes Visuais, por conta dessa criança criativa, e tem interesse nas individualidades, estudando isso ao seu redor, trazendo sempre a mirabolante ideia de nunca sabermos fielmente como alguém se sente.','estudante','Artes Visuais','4','538101d68a9746159f93924b28b2aba4.png','https://www.instagram.com/passoca.art?psln=MW9kM3Zqc3U1dXNhMA%3D%3D','p4ssoca@gmail.com','(47) 99609-3251',1,'2026-11-15 23:51:00');
INSERT INTO `artistas` (`id`, `nome`, `email`, `senha_hash`, `bio`, `vinculo`, `curso`, `periodo`, `foto`, `instagram_url`, `contato_email`, `contato`, `perfil_publico`, `criado_em`) VALUES (3,'LIA','lia@email.com','scrypt:32768:8:1$3xTQ1FkROUNzPYJu$59cdfebead0a6a92453af2f327db4be14fc4b55cea62374fce0de4dcea81cb88494415a767d09a605f1bf8fd4b069e31bfe6b8512f35af20d51118a761108577','Lia nasceu em 2007 em Florianópolis e cresceu mudando-se pelo Sul do Brasil, atualmente mora em Joinville e cursa o 4° semestre de Artes Visuais na Univille. A artista é associada da AAPLAJ onde integrou a exposição \"Cartografia do Amanhã\" (2025) do Projeto Arte em Movimento, \"Vozes e Cores\" (2026), Exposição comemorativa dos 50 anos do MAJ (2026) em parceria com a AAPLAJ e também \"Pesadelo Lúcido\" no CEU das Artes do Aventureiro.','estudante','Artes Visuais','4','ce6956f53eba40f8a04e5483a19df45a.png','https://www.instagram.com/liaarts_07?dlrf=NnV3MGFuNXh1cHQ2','','',1,'2026-11-17 00:53:54');
INSERT INTO `artistas` (`id`, `nome`, `email`, `senha_hash`, `bio`, `vinculo`, `curso`, `periodo`, `foto`, `instagram_url`, `contato_email`, `contato`, `perfil_publico`, `criado_em`) VALUES (4,'Vinicius Manske','vinicius@email.com','scrypt:32768:8:1$cAu9ShdU9msFefsA$f4352acf755f18311a958b52ef3ab5914c8edd1df33e10d79acaee50f73cfc704a88d52d2624e3e3f3982aeba31444e85c45126fd2f1ac4e80e262803a696d31','Vinicius Manske é fotógrafo e realizador audiovisual, formado em Cinema e Audiovisual pela Universidade da Região de Joinville (Univille). Sua produção transita entre a fotografia e o cinema, explorando a imagem como forma de expressão, memória e narrativa. Interessado pelas relações entre natureza, cotidiano e subjetividade, busca construir imagens que despertem sensações e diferentes interpretações. No audiovisual, atua em funções como direção e direção de fotografia, tendo participado de projetos reconhecidos em mostras e festivais.','ex-estudante','Cinema e Audiovisual','','d901056c1def44bbb2e92041ae5f8415.png','https://www.instagram.com/vmk.raw?cplk=MWN1eTFobGNjYTh5Zg%3D%3D','viniciusmanske@gmail.com','(47) 99288-7020',1,'2026-11-17 01:53:15');
INSERT INTO `artistas` (`id`, `nome`, `email`, `senha_hash`, `bio`, `vinculo`, `curso`, `periodo`, `foto`, `instagram_url`, `contato_email`, `contato`, `perfil_publico`, `criado_em`) VALUES (5,'Julia Goal','julia@email.com','scrypt:32768:8:1$0EO6Ga5R2ubEcRis$ee258c2df8856084d37b071baaf85b2c48c7b025729d4c593f23b205cbc32dd530deb905601a612ebe5d97dd487f831b4115a5e3cd0cab5af70e4219accaf07f','Julia nasceu em Joinville - SC, apaixonada por filmes musicais, sair com os amigos para jogar boardgames e de músicas que ninguém conhece. Acredita que as pessoas inspiram, emocionam e que cada história é única e precisa ser contada, ela faz isso através dos filmes de uma forma autêntica. Formada em cinema e audiovisual, trabalha com audiovisual há 5 anos, nas áreas de direção, roteiro, fotografia e edição.','ex-estudante','Cinema e Audiovisual','','15e3379c36134d7790e0155d02c04e49.png','https://www.instagram.com/deluacriativo?psln=MXh3cDFrNG94eDRweg%3D%3D','deluacriativo@gmail.com','(47) 99166-7717',1,'2026-11-17 02:29:08');
INSERT INTO `artistas` (`id`, `nome`, `email`, `senha_hash`, `bio`, `vinculo`, `curso`, `periodo`, `foto`, `instagram_url`, `contato_email`, `contato`, `perfil_publico`, `criado_em`) VALUES (6,'Marilia Rossdeutscher','marilia@email.com','scrypt:32768:8:1$eaKvDPHcjLzhEm7X$b398d7ca797955eb3db30ba8cd371de2ac71d1df90ad13d3be6780e129ff0744f4ec3f53612e74167af02530b907c8d0fd4900debbfc04adf4cb68905e02225e','Com formação em Cinema e Audiovisual, Marilia tem atuação na área de som direto, além de transitar entre outros campos do cinema. Assina Corpo-Corrente como sua primeira direção e trabalho de conclusão de curso.','ex-estudante','Cinema e Audiovisual','','b8cd497d42914a9dbedf5889bae5ceb8.png','https://www.instagram.com/mariliarossdeutscher?srtk=bHUwYjA2NjQ0Njk0','','',1,'2026-11-17 02:37:41');
INSERT INTO `artistas` (`id`, `nome`, `email`, `senha_hash`, `bio`, `vinculo`, `curso`, `periodo`, `foto`, `instagram_url`, `contato_email`, `contato`, `perfil_publico`, `criado_em`) VALUES (7,'Malu By The Moon','malu@email.com','scrypt:32768:8:1$9Af12qyZ6XqFwi5Y$b789b4b366356fb62e887eb8592664eeb43cbfd0c266b7aacd9373be7a09a71db141e65446663c0c87289e72d412ec8012e4ed96baf3f5e86bed01968f104348','Maria Luisa, é nascida em Maringá - PR e vem de família de artistas, contando com artistas plásticos, poetas, fotografos e estilistas. Essa influência trouxe muitas inspirações para sua infância e seu desenvolvimento artístico, tornando-a uma artista multidisciplinar. Atualmente Malu trabalha com pinturas em acrílico, ilustração digital, cerâmica fria e artesanatos. Além disso, Malu é graduanda em Design Gráfico e Digital na Univille e trabalha em agência de publicidade como Assistente de criação.','ex-estudante','Design Gráfico e Digital','','cff49a0ebd544a51ade8885901ff4096.png','https://www.instagram.com/malubythemoon/','','',1,'2026-11-17 02:50:58');
/*!40000 ALTER TABLE `artistas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `obra_detalhes`
--

LOCK TABLES `obra_detalhes` WRITE;
/*!40000 ALTER TABLE `obra_detalhes` DISABLE KEYS */;
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (5,'dimensoes','70 x 100');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (5,'tecnica','Óleo e tecido sobre tela');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (9,'dimensoes','120 x 90');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (9,'tecnica','Óleo e tecido sobre tela');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (10,'dimensoes','40 x 70');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (10,'tecnica','Óleo e tecido sobre tela');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (11,'dimensoes','170 x 120');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (11,'tecnica','Óleo sobre tela');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (12,'dimensoes','21x14,8cm');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (12,'tecnica','Lápis de cor, nanquim e aquarela');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (13,'dimensoes','42x29,7cm.');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (13,'tecnica','Lápis de cor de pastel');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (14,'dimensoes','70 x 40cm.');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (14,'tecnica','acrílica sobre tela');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (24,'dimensoes','65 x 118 x 14cm.');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (24,'tecnica','Papéis, gesso, tinta acrílica, fios, algodão cru e miçangas sobre madeira.');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (26,'dimensoes','29x42cm.');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (26,'tecnica','Lápis de cor sobre papel Canson 300g.');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (27,'dimensoes','29x42cm');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (27,'tecnica','Giz pastel oleoso, giz de cera e lápis de cor sobre papel 300g.');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (28,'dimensoes','21x29cm');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (28,'tecnica','Giz pastel oleoso sobre papel Canson 300g.');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (29,'dimensoes','42x29cm.');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (29,'tecnica','Giz pastel oleoso sobre papel Canson 300g.');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (30,'dimensoes','70x70cm.');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (30,'tecnica','Oléo sobre tela.');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (33,'duracao','27 min');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (33,'genero','Documentário');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (33,'video','https://www.youtube.com/watch?v=bpKwCaNYMCU');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (37,'duracao','15 min');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (37,'genero','Curta-Metragem');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (37,'video','https://www.youtube.com/watch?v=x1B85c4MLbw');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (38,'duracao','14 min');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (38,'genero','Curta-Metragem');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (38,'video','https://www.youtube.com/watch?v=tHsV8HIVb4M');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (39,'duracao','9 min');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (39,'genero','Curta-metragem');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (39,'video','https://www.youtube.com/watch?v=yUX9VqEq3z0');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (40,'tecnica','...');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (41,'tecnica','Lápis 6b, tinta acrílica');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (42,'tecnica','...');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (43,'tecnica','...');
INSERT INTO `obra_detalhes` (`obra_id`, `campo`, `valor`) VALUES (44,'tecnica','...');
/*!40000 ALTER TABLE `obra_detalhes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `obras`
--

LOCK TABLES `obras` WRITE;
/*!40000 ALTER TABLE `obras` DISABLE KEYS */;
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (5,2,'Cegueira Azul',2025,'artes','Perspectiva do que sentimos quando não vemos o concreto da ação, um quadro sobre sensações do corpo através do tato e do imaginário que constroi a ambientação. A obra dialoga com o estar perdido com a necessidade de mudança e como essa mudança pode vir de modo drástico obrigando assim uma nova perspectiva de existir…','ca6b4d351f5e43cbae47ce4882f450bf.jpeg','pequeno-retrato','2026-11-16 00:12:11');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (9,2,'Todas as (M)Àguas que Escorrem pelos Dedos',2025,'artes','O quadro fala sobre como somos todos ínfimos mas infinitos, coletivos de experiências, confortos e desconfortos, assim as Gigantesas, essa personagem imensa que protagoniza a obra seria nada mais que um espelhos de onde viemos e para onde consequentemente iremos, a TERRA, a Mãe, é uma súplica pelo descanso de um colo quieto, de um rio que canta e de uma mata que abriga muitas curiosidades que são também nossos espelhos.','a0bd3e8ab6ab439ebb3fd9322f3614ef.png','medio-paisagem','2026-11-16 00:37:21');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (10,2,'Um Fecho de Luz na Floresta',2025,'artes','Que carinhos podem aconchegar a mágoa? Essa pergunta é a mediadora da obra e leva a pensar sobre o corpo (agora novo) que se vê perdido nesse mundo de possibilidades, é a primeira obra a apresentar as Gigantesas, e também os pequeninos, e mostra uma gama de possibilidades que é essa floresta verde e fantasiosamente imensa que ao mesmo tempo que nos engole mostra diversas possibilidades de novas trilhas…','cacc3b53c6ae4b42b00bacf02f370ffd.png','pequeno-retrato','2026-11-16 23:22:20');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (11,2,'Fantasmas de Si',2026,'artes','O que somos se não cacos daquilo que nós transpassa a pele? É outra das perguntas mediadoras de uma das últimas obras da linha Gigantescas Espaçosas e vem como uma possibilidade de futuro onde depois de nos sentirmos perdidos em nós e assim  buscarmos uma fuga que nos leva a arredores ampliados e com mais gama de possibilidades voltamos a olhar para as raízes que nos perpassam e assim encontrarmos um modo de crescermos…','5521eda33bf44222af33e22e7419f442.png','pequeno-retrato','2026-11-17 00:24:40');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (12,2,'Guela Abaixo',2026,'artes','..','d0848e796171437dbaa9c448aad21f49.png','pequeno-retrato','2026-11-17 00:29:33');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (13,2,'Nostalgia',2026,'artes','Quem pode ver que não caibo mais? Como sair sem quebrar o que já foi um dia importante?\r\n\r\nO lar se fundamenta em parâmetros que fogem das bases pessoais de quem foi criado ali dentro e se torna um referencial distante ao que pode-se permitir vir a ser NECESSÁRIO. Com isso, cresce sem ver, e por não ver não sai, e quando o tempo bate a porta, ela está pequena e apertada, esperar é o que se pode fazer sem sair, porque saindo quebra , e quebrar não é uma opção, resta-se então só sufoco do gás que sai pelos pulmões.\r\n\r\nA casa poderia ter sido sua casa de boneca…','0aff22bece564b4aa03f5f3c122cb3f2.png','medio-paisagem','2026-11-17 00:33:56');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (14,2,'Borboletas Quando Morrem Viram Casulos de Mariposas',2025,'artes','O que acontece quando dormimos e não acordamos mas como nos conhecemos?! A obra reflete as transições da vida a partir de uma perspectiva de evolução, já que é impossível ao meu ver involuir, e vem da ideia de infância adormecida, do corpo que ocupa nosso corpo até se sentir livre para sair e sobre o terror que pode ser não se encontrar nesse novo corpo…','cf71690915ea4fbb8b9a77135c949685.jpeg','medio-paisagem','2026-11-17 00:36:14');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (19,3,'Com Carinho, Sonho',2026,'fotografia','Sonhos são a manifestação de um outro lado, um outro nosso. Seja o inconsciente subjetivo ou alguma força do além tentando comunicar-se. Sonhamos dormindo, sonhamos acordados. As vozes que nos levam até este lugar entre lugares, são muitas.\r\nAtravesamos a barreira do mundo real, entrando em transe e somos abençoados com a possibilidade de um encontro caloroso com quem mais se busca. 

Este trabalho conta sobre duas vozes que tenho escutado.\r\nA primeira delas soa calma, tentando purificar a escuridão com seu afeto. Trata-se de uma passagem espiritual. A abertura de um corpo receptáculo para uma força maior.

A segunda voz é de quem sinto saudades.\r\nEla se faz presente de maneira imaterial, para todos aqueles que ainda precisam ouvir seus sussurros. Escode-se debaixo do véu da realidade pelo tempo que lhe é permitido, e assim nos reencontramos.\r\nDeixou em terra muitos amuletos que hoje nos pertencem. Eles são nossas proteções e firmezas.','8410bcbcf96f4b8a9b95b96c9c1b13db.jpeg','pequeno-retrato','2026-11-17 01:21:14');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (20,3,'Com Carinho, Sonho',2026,'fotografia','Sonhos são a manifestação de um outro lado, um outro nosso. Seja o inconsciente subjetivo ou alguma força do além tentando comunicar-se. Sonhamos dormindo, sonhamos acordados. As vozes que nos levam até este lugar entre lugares, são muitas.\r\nAtravesamos a barreira do mundo real, entrando em transe e somos abençoados com a possibilidade de um encontro caloroso com quem mais se busca. 

Este trabalho conta sobre duas vozes que tenho escutado.\r\nA primeira delas soa calma, tentando purificar a escuridão com seu afeto. Trata-se de uma passagem espiritual. A abertura de um corpo receptáculo para uma força maior.

A segunda voz é de quem sinto saudades.\r\nEla se faz presente de maneira imaterial, para todos aqueles que ainda precisam ouvir seus sussurros. Escode-se debaixo do véu da realidade pelo tempo que lhe é permitido, e assim nos reencontramos.\r\nDeixou em terra muitos amuletos que hoje nos pertencem. Eles são nossas proteções e firmezas.','90a854954ead4d93a868c26e6418954d.jpeg','medio-paisagem','2026-11-17 01:21:59');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (21,3,'Com Carinho, Sonho',2026,'fotografia','Sonhos são a manifestação de um outro lado, um outro nosso. Seja o inconsciente subjetivo ou alguma força do além tentando comunicar-se. Sonhamos dormindo, sonhamos acordados. As vozes que nos levam até este lugar entre lugares, são muitas.\r\nAtravesamos a barreira do mundo real, entrando em transe e somos abençoados com a possibilidade de um encontro caloroso com quem mais se busca. 

Este trabalho conta sobre duas vozes que tenho escutado.\r\nA primeira delas soa calma, tentando purificar a escuridão com seu afeto. Trata-se de uma passagem espiritual. A abertura de um corpo receptáculo para uma força maior.

A segunda voz é de quem sinto saudades.\r\nEla se faz presente de maneira imaterial, para todos aqueles que ainda precisam ouvir seus sussurros. Escode-se debaixo do véu da realidade pelo tempo que lhe é permitido, e assim nos reencontramos.\r\nDeixou em terra muitos amuletos que hoje nos pertencem. Eles são nossas proteções e firmezas.','987f97fb488d4dea8d7e93aa2b49af4d.png','grande-paisagem','2026-11-17 01:23:54');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (22,3,'Com Carinho, Sonho',2026,'fotografia','Sonhos são a manifestação de um outro lado, um outro nosso. Seja o inconsciente subjetivo ou alguma força do além tentando comunicar-se. Sonhamos dormindo, sonhamos acordados. As vozes que nos levam até este lugar entre lugares, são muitas.\r\nAtravesamos a barreira do mundo real, entrando em transe e somos abençoados com a possibilidade de um encontro caloroso com quem mais se busca. 

Este trabalho conta sobre duas vozes que tenho escutado.\r\nA primeira delas soa calma, tentando purificar a escuridão com seu afeto. Trata-se de uma passagem espiritual. A abertura de um corpo receptáculo para uma força maior.

A segunda voz é de quem sinto saudades.\r\nEla se faz presente de maneira imaterial, para todos aqueles que ainda precisam ouvir seus sussurros. Escode-se debaixo do véu da realidade pelo tempo que lhe é permitido, e assim nos reencontramos.\r\nDeixou em terra muitos amuletos que hoje nos pertencem. Eles são nossas proteções e firmezas.','253154413c134d60850478013931fd6a.png','medio-paisagem','2026-11-17 01:25:16');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (23,3,'Com Carinho, Sonho',2026,'fotografia','Sonhos são a manifestação de um outro lado, um outro nosso. Seja o inconsciente subjetivo ou alguma força do além tentando comunicar-se. Sonhamos dormindo, sonhamos acordados. As vozes que nos levam até este lugar entre lugares, são muitas.\r\nAtravesamos a barreira do mundo real, entrando em transe e somos abençoados com a possibilidade de um encontro caloroso com quem mais se busca. 

Este trabalho conta sobre duas vozes que tenho escutado.\r\nA primeira delas soa calma, tentando purificar a escuridão com seu afeto. Trata-se de uma passagem espiritual. A abertura de um corpo receptáculo para uma força maior.

A segunda voz é de quem sinto saudades.\r\nEla se faz presente de maneira imaterial, para todos aqueles que ainda precisam ouvir seus sussurros. Escode-se debaixo do véu da realidade pelo tempo que lhe é permitido, e assim nos reencontramos.\r\nDeixou em terra muitos amuletos que hoje nos pertencem. Eles são nossas proteções e firmezas.','8e51237429fd455f8033d9f4096d8dba.png','pequeno-retrato','2026-11-17 01:26:18');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (24,3,'O Fim terá cheiro de carne humana podre',2025,'artes','..','d9dbc3543746492284d55bbd4d5cedfe.png','medio-retrato','2026-11-17 01:27:52');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (25,3,'Com Carinho, Sonho',2026,'fotografia','Sonhos são a manifestação de um outro lado, um outro nosso. Seja o inconsciente subjetivo ou alguma força do além tentando comunicar-se. Sonhamos dormindo, sonhamos acordados. As vozes que nos levam até este lugar entre lugares, são muitas.\r\nAtravesamos a barreira do mundo real, entrando em transe e somos abençoados com a possibilidade de um encontro caloroso com quem mais se busca. 

Este trabalho conta sobre duas vozes que tenho escutado.\r\nA primeira delas soa calma, tentando purificar a escuridão com seu afeto. Trata-se de uma passagem espiritual. A abertura de um corpo receptáculo para uma força maior.

A segunda voz é de quem sinto saudades.\r\nEla se faz presente de maneira imaterial, para todos aqueles que ainda precisam ouvir seus sussurros. Escode-se debaixo do véu da realidade pelo tempo que lhe é permitido, e assim nos reencontramos.\r\nDeixou em terra muitos amuletos que hoje nos pertencem. Eles são nossas proteções e firmezas.','86064eb2b5444457b6578e0dfba6ee63.png','medio-retrato','2026-11-17 01:28:48');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (26,3,'Desbocada',2026,'artes','O que poderia ser dito que deslocaria a mandíbula? Abrir a boca, levar a língua ao céu seria capaz de causar tamanha dor? Desbocar-se envolve falar demais, cuspir as coisas e estragá-las. Somos todos meio desbocados.','f03bd05faab644cfb3166aa3e14239bf.png','medio-retrato','2026-11-17 01:30:19');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (27,3,'Nascimento',2026,'artes','Todos nascemos e somos ditos alguma coisa, antes de sequer saber quem ou o que gostaríamos de ser. Não existe gesto mais brutal do que nomear um indivíduo antes que ele possa realmente ser.','744fce3ccd9f4faf8fceb2aa3c4c6823.png','medio-retrato','2026-11-17 01:31:04');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (28,3,'Cordas',2025,'artes','Um relato de uma prisão que desperta acima de tudo, raiva. Ela pode ser imposta pelos outros ou por nós mesmos, de qualquer forma ainda é sufocante.','ce10fe900c3848da842b484eab6ccf13.png','pequeno-retrato','2026-11-17 01:36:35');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (29,3,'Cuidando de Casa',2026,'artes','Existem formas diferentes de cuidar da própria casa, da própria mente, delicadezas específicas que apenas o cerne de nós mesmos pode reconhecer. Algumas profundezas de sentimentos e ações são mais antigas do que percebemos pela superfície','77f24c72c2554e6693a3b20ce9541491.png','medio-paisagem','2026-11-17 01:37:30');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (30,3,'Carinho',2026,'artes','Assim como o corpo físico sente o toque do afeto, o imaterial também sente. A obra traduz essa sensação, o calor de gestos tão simples espalhando-se através do que não podemos ver ou tocar, mas esta lá.','93872268d1bf4631847c5952ddf89c6e.png','pequeno-retrato','2026-11-17 01:38:14');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (31,4,'Azul',2026,'fotografia','...','a6216c311d0340a499ea79390c401cc0.png','medio-paisagem','2026-11-17 01:55:34');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (32,4,'-',2026,'fotografia','...','fee6745414a848e4b8929627f4f32d22.png','medio-paisagem','2026-11-17 01:56:12');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (33,4,'NEEB - Núcleo Espírita Eurípedes Barsanulfo',2025,'cinema','O documentário conta a história do Núcleo Espírita Eurípedes Barsanulfo, conhecido como NEEB, através dos olhos de seus voluntários e da comunidade da Ilha do Morro do Amaral. Traz reflexões sobre o impacto e o potencial de transformação social em grupos vulneráveis.','fbf68746ebbd40918909711bfffe896d.png','banner','2026-11-17 02:01:10');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (34,4,'Solitária I',2026,'fotografia','...','1cbf48b2e140400e99df38ddc863eb5c.png','medio-paisagem','2026-11-17 02:04:07');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (35,4,'Solitária II',2026,'fotografia','...','d082e7ab7c6d47d9b138d7f46551e177.png','medio-paisagem','2026-11-17 02:04:46');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (36,4,'América',2026,'fotografia','...','959e9786a7c9497a8bdf03887315bd49.png','grande-paisagem','2026-11-17 02:05:29');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (37,5,'Olhar Amarelo',2024,'cinema','Carla, uma jovem de 20 anos e estudante, está na dúvida se deve ou não enviar uma mensagem para Pedro, um jovem que ela encontrou no ônibus. Em certa noite, ao caminho da faculdade, ela observa Pedro trocando mensagens com uma pessoa que conheceu por aplicativo, ela observa que talvez ele esteja se iludindo e pensa em avisá-lo, mas ele é uma pessoa reclusa, introvertida então não é tão simples. Além disso, Carla não conhece ele.','ab8290adeb40413e8885941208ae9e14.png','banner','2026-11-17 02:32:08');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (38,5,'Música sem Nome',2025,'cinema','Com 20 anos, Saulo ganha um gravador, nesse momento começa a compor e transforma cada sentimento em música. Agora, com 40 anos, ele deixou a rotina tomar conta, não compõe e nem se expressa. A vida passa e ele só acompanha frustrado. Até que em um dia algo faz ele se reconectar com a música: uma caixa de fitas cassetes.','2f9b7148fbf546ccb39ed2b7436ece6b.png','banner','2026-11-17 02:34:04');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (39,6,'Corpo-Corrente',2026,'cinema','Sentindo-se preso em um corpo que não o representa, René enfrenta um processo de aceitação e libertação em busca de sua versão mais autêntica. Corpo-Corrente é uma história contada a partir do movimento, a dança aparece como uma metáfora as palavras e o corpo reproduz o que não é possível dizer com a boca. É a passagem entre o reconhecimento, estranhamento, entendimento e aceitação.','65b3b1522f954ef08ccaaee5e590a336.png','banner','2026-11-17 02:39:59');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (40,7,'...',2026,'artes','...','6fcd77b3297941a2ac04f06f497f3444.png','medio-paisagem','2026-11-17 02:52:38');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (41,7,'Malu',2026,'artes','Autoretrato rendas','9bed1176fd124a2d9adf5e2671effb45.png','medio-quadrado','2026-11-17 02:53:04');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (42,7,'Nascimento do maquininho',2026,'artes','...','7b8b0cde62714982a8a9415404eb565e.png','medio-retrato','2026-11-17 02:54:03');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (43,7,'Casinha',2026,'artes','Atrás desse portão, tem uma casinha do telhado azul, sabia?','c6a7752482bd480e97433086ca8ec75e.png','medio-paisagem','2026-11-17 02:54:43');
INSERT INTO `obras` (`id`, `artista_id`, `titulo`, `ano`, `categoria`, `descricao`, `imagem`, `molde`, `criado_em`) VALUES (44,7,'Microbiota',2026,'artes','...','60d0fd3c0b434fe0b6bdd55e2b3f622e.png','medio-paisagem','2026-11-17 02:55:15');
/*!40000 ALTER TABLE `obras` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-24 12:14:35
