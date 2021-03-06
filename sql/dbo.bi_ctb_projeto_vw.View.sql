USE [PRODUCAO]
GO
/****** Object:  View [dbo].[bi_ctb_projeto_vw]    Script Date: 19/01/2020 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[bi_ctb_projeto_vw] AS 
SELECT '01' AS c_empresa,
       
	   CV0.CV0_CODIGO AS c_projeto,
       RTRIM(CV0.CV0_DESC) AS c_descricao,

	   CV0.R_E_C_N_O_ AS id,
	   
	   (SELECT MAX(e.id)
	      FROM bi_empresa_vw e
		 WHERE e.c_empresa = '01') AS id_empresa

  FROM CV0010 AS CV0 WITH(NOLOCK)
 WHERE CV0.CV0_FILIAL = '  '  
   AND CV0.CV0_PLANO = '05'
   AND CV0.CV0_CODIGO <> ' '
   AND CV0.D_E_L_E_T_ <> '*'
GO
