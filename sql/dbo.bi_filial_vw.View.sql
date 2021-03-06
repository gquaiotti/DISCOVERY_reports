USE [PRODUCAO]
GO
/****** Object:  View [dbo].[bi_filial_vw]    Script Date: 19/01/2020 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[bi_filial_vw] AS 
select M0_CODIGO as c_empresa,
       M0_CODFIL as c_filial,
       RTRIM(M0_CODFIL) + ' - ' + RTRIM(M0_FILIAL) as c_nome,
	   R_E_C_N_O_ AS id,

	   (SELECT MAX(e.id)
	      FROM bi_empresa_vw e
		 WHERE e.c_empresa = M0_CODIGO) AS id_empresa

  from SYS_COMPANY with (nolock)
 where D_E_L_E_T_ <> '*'
GO
