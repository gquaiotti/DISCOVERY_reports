USE [PRODUCAO]
GO
/****** Object:  View [dbo].[bi_ctb_item_contabil_vw]    Script Date: 19/01/2020 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[bi_ctb_item_contabil_vw] AS
SELECT '01' AS c_empresa,
       CTD.CTD_ITEM AS c_item_contabil,

	   CASE CTD.CTD_CLASSE 
	     WHEN '1' THEN 'Sintetica'
		 WHEN '2' THEN 'Analitica'
	   END as c_classe,

	   CASE CTD.CTD_NORMAL
	     WHEN '0' THEN 'Nenhum'
		 WHEN '1' THEN 'Despesa'
		 WHEN '2' THEN 'Receita'
	   END AS c_condicao,

	   RTRIM(CTD_DESC01) AS c_descricao,

	   CASE CTD.CTD_BLOQ
	     WHEN '1' THEN 'Bloqueado'
		 WHEN '2' THEN 'Nao Bloqueado'
	   END AS c_bloqueio,

	   CTD.R_E_C_N_O_ AS id,

	   (SELECT MAX(e.id)
	      FROM bi_empresa_vw e
		 WHERE e.c_empresa = '01') AS id_empresa
		 
  FROM CTD010 AS CTD WITH (NOLOCK)
 WHERE CTD.CTD_FILIAL = '  '
   AND CTD.D_E_L_E_T_ <> '*'
GO
