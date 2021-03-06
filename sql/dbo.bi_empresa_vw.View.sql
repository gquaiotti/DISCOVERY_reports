USE [PRODUCAO]
GO
/****** Object:  View [dbo].[bi_empresa_vw]    Script Date: 19/01/2020 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[bi_empresa_vw] AS
SELECT M0_CODIGO AS c_empresa,
       RTRIM(M0_CODIGO) + ' - ' + RTRIM(M0_NOME) AS c_nome,
	   MAX(R_E_C_N_O_) AS id
  FROM SYS_COMPANY WITH (NOLOCK)
 WHERE D_E_L_E_T_ <> '*' 
 GROUP BY M0_CODIGO, M0_NOME
GO
