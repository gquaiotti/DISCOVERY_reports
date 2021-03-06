USE [PRODUCAO]
GO
/****** Object:  View [dbo].[bi_ctb_grupo_contabil_vw]    Script Date: 19/01/2020 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[bi_ctb_grupo_contabil_vw] AS 
SELECT '01' AS c_empresa,
       
	   CTR.CTR_GRUPO AS c_grupo_contabil,
       RTRIM(CTR.CTR_DESC) AS c_descricao,

	   CTR.R_E_C_N_O_ AS id,
	   
	   (SELECT MAX(e.id)
	      FROM bi_empresa_vw e
		 WHERE e.c_empresa = '01') AS id_empresa

  FROM CTR010 AS CTR WITH(NOLOCK)
 WHERE CTR.CTR_FILIAL = '  '
   AND CTR.D_E_L_E_T_ <> '*' 
GO
