CREATE DATABASE IF NOT EXISTS `corretora` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `corretora`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `casa`
--

CREATE TABLE `casa` (
  `id` int(11) NOT NULL,
  `casa` varchar(100) DEFAULT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `estado` varchar(100) DEFAULT NULL,
  `bairro` varchar(100) DEFAULT NULL,
  `endereco` varchar(200) DEFAULT NULL,
  `preco` decimal(10,2) DEFAULT NULL,
  `acombinar` text,
  `dormitorios` int(11) DEFAULT NULL,
  `banheiros` int(11) DEFAULT NULL,
  `area` float DEFAULT NULL,
  `Venda` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `chat`
--

CREATE TABLE `chat` (
  `id` int(11) NOT NULL,
  `id_imovel` int(11) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `mensagem` text,
  `data_hora_envio` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `comentarioavaliacao`
--

CREATE TABLE `comentarioavaliacao` (
  `id` int(11) NOT NULL,
  `id_imovel` int(11) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `comentario` text,
  `avaliacao` int(11) DEFAULT NULL,
  `data_avaliacao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `contrato`
--

CREATE TABLE `contrato` (
  `id` int(11) NOT NULL,
  `id_imovel` int(11) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `data_contrato` date DEFAULT NULL,
  `tipo_contrato` enum('Compra','Venda','Locacao') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `imagem`
--

CREATE TABLE `imagem` (
  `id` int(11) NOT NULL,
  `id_imovel` int(11) DEFAULT NULL,
  `image_path` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `transacao`
--

CREATE TABLE `transacao` (
  `id` int(11) NOT NULL,
  `id_imovel` int(11) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `data_transacao` date DEFAULT NULL,
  `tipo_transacao` enum('Compra','Venda','Aluguel') DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `senha` varchar(100) DEFAULT NULL,
  `admin1` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `visita`
--

CREATE TABLE `visita` (
  `id` int(11) NOT NULL,
  `id_imovel` int(11) DEFAULT NULL,
  `datavisita` date DEFAULT NULL,
  `interesse` varchar(150) DEFAULT NULL,
  `cliente` int(11) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `casa`
--
ALTER TABLE `casa`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comentarioavaliacao`
--
ALTER TABLE `comentarioavaliacao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_imovel` (`id_imovel`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Indexes for table `contrato`
--
ALTER TABLE `contrato`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_imovel` (`id_imovel`);

--
-- Indexes for table `imagem`
--
ALTER TABLE `imagem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_imovel` (`id_imovel`);

--
-- Indexes for table `transacao`
--
ALTER TABLE `transacao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transacao_ibfk_1` (`id_cliente`),
  ADD KEY `id_imovel` (`id_imovel`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `visita`
--
ALTER TABLE `visita`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_imovel` (`id_imovel`),
  ADD KEY `cliente` (`cliente`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `casa`
--
ALTER TABLE `casa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `comentarioavaliacao`
--
ALTER TABLE `comentarioavaliacao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `contrato`
--
ALTER TABLE `contrato`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `imagem`
--
ALTER TABLE `imagem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `transacao`
--
ALTER TABLE `transacao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `visita`
--
ALTER TABLE `visita`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `comentarioavaliacao`
--
ALTER TABLE `comentarioavaliacao`
  ADD CONSTRAINT `comentarioavaliacao_ibfk_1` FOREIGN KEY (`id_imovel`) REFERENCES `casa` (`id`),
  ADD CONSTRAINT `comentarioavaliacao_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `usuario` (`id`);

--
-- Limitadores para a tabela `contrato`
--
ALTER TABLE `contrato`
  ADD CONSTRAINT `contrato_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `contrato_ibfk_2` FOREIGN KEY (`id_imovel`) REFERENCES `casa` (`id`);

--
-- Limitadores para a tabela `imagem`
--
ALTER TABLE `imagem`
  ADD CONSTRAINT `imagem_ibfk_1` FOREIGN KEY (`id_imovel`) REFERENCES `casa` (`id`);

--
-- Limitadores para a tabela `transacao`
--
ALTER TABLE `transacao`
  ADD CONSTRAINT `transacao_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `transacao_ibfk_2` FOREIGN KEY (`id_imovel`) REFERENCES `casa` (`id`);

--
-- Limitadores para a tabela `visita`
--
ALTER TABLE `visita`
  ADD CONSTRAINT `visita_ibfk_1` FOREIGN KEY (`id_imovel`) REFERENCES `casa` (`id`),
  ADD CONSTRAINT `visita_ibfk_2` FOREIGN KEY (`cliente`) REFERENCES `usuario` (`id`);
--
-- Database: `fabiana`
--
CREATE DATABASE IF NOT EXISTS `fabiana` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `fabiana`;
--
-- Database: `rodrigo`
--
CREATE DATABASE IF NOT EXISTS `rodrigo` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `rodrigo`;
COMMIT;
