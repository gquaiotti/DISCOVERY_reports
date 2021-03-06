USE [PRODUCAO]
GO
/****** Object:  View [dbo].[bi_ctb_centro_custo_vw]    Script Date: 19/01/2020 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[bi_ctb_centro_custo_vw] as 
SELECT '01' AS c_empresa,
       CTT.CTT_CUSTO AS c_centro_custo,
	   RTRIM(CTT.CTT_DESC01) AS c_descricao,
	   CTT.R_E_C_N_O_ AS id,

	   (SELECT MAX(e.id)
	      FROM bi_empresa_vw e
		 WHERE e.c_empresa = '01') AS id_empresa

  FROM CTT010 AS CTT WITH (NOLOCK)
 WHERE CTT.D_E_L_E_T_ <> '*'
GO
