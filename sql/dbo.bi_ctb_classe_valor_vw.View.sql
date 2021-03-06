USE [PRODUCAO]
GO
/****** Object:  View [dbo].[bi_ctb_classe_valor_vw]    Script Date: 19/01/2020 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[bi_ctb_classe_valor_vw] AS
SELECT '01' AS c_empresa,
       CTH.CTH_CLVL AS c_classe_valor,

	   CASE CTH.CTH_CLASSE 
	     WHEN '1' THEN 'Sintetica'
		 WHEN '2' THEN 'Analitica'
	   END as c_classe,

	   CASE CTH.CTH_NORMAL
	     WHEN '0' THEN 'Nenhum'
		 WHEN '1' THEN 'Despesa'
		 WHEN '2' THEN 'Receita'
	   END AS c_condicao,

	   RTRIM(CTH_DESC01) AS c_descricao,

	   CASE CTH.CTH_BLOQ
	     WHEN '1' THEN 'Bloqueado'
		 WHEN '2' THEN 'Nao Bloqueado'
	   END AS c_bloqueio,

	   CTH.R_E_C_N_O_ AS id,

	   (SELECT MAX(e.id)
	      FROM bi_empresa_vw e
		 WHERE e.c_empresa = '01') AS id_empresa
		 
  FROM CTH010 AS CTH WITH (NOLOCK)
 WHERE CTH.CTH_FILIAL = '  '
   AND CTH.D_E_L_E_T_ <> '*'
GO
