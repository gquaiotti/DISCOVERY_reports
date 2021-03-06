USE [PRODUCAO]
GO
/****** Object:  View [dbo].[bi_ctb_moeda_vw]    Script Date: 19/01/2020 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[bi_ctb_moeda_vw] as
SELECT '01' as c_empresa,
       CTO_MOEDA AS c_moeda, 
       RTRIM(CTO_DESC) AS c_moeda_descricao,

	   CTO.CTO_SIMB AS c_moeda_simbolo,

	   CTO.R_E_C_N_O_ AS id,

	   (SELECT e.id
	      FROM bi_empresa_vw e
		 WHERE e.c_empresa = '01') AS id_empresa

  FROM CTO010 AS CTO WITH (NOLOCK)
 WHERE CTO.CTO_FILIAL = ' '
   AND CTO.D_E_L_E_T_ <> '*'
GO
