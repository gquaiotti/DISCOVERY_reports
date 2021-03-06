USE [PRODUCAO]
GO
/****** Object:  View [dbo].[bi_ctb_conta_contabil_sint_vw]    Script Date: 19/01/2020 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








create view [dbo].[bi_ctb_conta_contabil_sint_vw] as
select '01' AS c_empresa,
       CT1.CT1_CONTA AS c_conta_contabil,
	   RTRIM(CT1.CT1_DESC01) AS c_descricao,
	   
	   CASE CT1.CT1_NORMAL 
	     WHEN '1' THEN 'Devedora'
		 WHEN '2' THEN 'Credora'
	   END as c_condicao,

	   CT1.CT1_CTASUP as c_conta_superior,

	   CT1.CT1_GRUPO as c_grupo,

	   LEN(RTRIM(CT1.CT1_CONTA)) AS n_nivel,

	   CT1.R_E_C_N_O_ AS id,

	   (SELECT MAX(e.id)
	      FROM bi_empresa_vw e
		 WHERE e.c_empresa = '01') AS id_empresa,

	   (SELECT MAX(CT1SUP.R_E_C_N_O_)
	      FROM CT1010 AS CT1SUP WITH (NOLOCK)
		 WHERE CT1SUP.CT1_FILIAL = '  '
		   AND CT1SUP.CT1_CONTA = CT1.CT1_CTASUP
		   AND CT1SUP.D_E_L_E_T_ <> '*') as id_conta_superior,

       (SELECT MAX(g.id)
	      FROM bi_ctb_grupo_contabil_vw g
		 WHERE g.c_empresa = '01'
		   AND g.c_grupo_contabil = CT1.CT1_GRUPO) id_grupo_contabil

  from CT1010 as CT1 WITH (NOLOCK)
 WHERE CT1.CT1_FILIAL = '  '
   AND CT1.CT1_CLASSE = '1'
   AND CT1.D_E_L_E_T_ <> '*'
GO
