﻿USE [PRODUCAO]
GO
/****** Object:  View [dbo].[bi_ctb_saldo_conta_mes_vw]    Script Date: 19/01/2020 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







create view [dbo].[bi_ctb_saldo_conta_mes_vw] as
SELECT '01' AS c_empresa,
       
	   CASE 
	     WHEN CQ0.CQ0_DATA <> '  ' THEN
		   YEAR(CAST(CQ0.CQ0_DATA AS DATE))
	   END AS n_ano,

	   CASE 
	     WHEN CQ0.CQ0_DATA <> '  ' THEN
		   MONTH(CAST(CQ0.CQ0_DATA AS DATE))
	   END AS n_mes,
       
	   CASE 
	     WHEN CQ0.CQ0_DATA <> ' ' THEN
		   CAST(CQ0.CQ0_DATA AS DATE)
	   END AS d_data,

	   CQ0.CQ0_CONTA AS c_conta_contabil,

	   CQ0.CQ0_MOEDA AS c_moeda,

	   CQ0.CQ0_DEBITO AS n_saldo_debito,
	   CQ0.CQ0_CREDIT AS n_saldo_credito,

	   CASE
	     WHEN CT1.CT1_NORMAL = '2' THEN
		   CQ0.CQ0_DEBITO - CQ0.CQ0_CREDIT
         WHEN CT1.CT1_NORMAL = '1' THEN
		   CQ0.CQ0_DEBITO - CQ0.CQ0_CREDIT
	   END AS n_saldo,

	   CQ0.R_E_C_N_O_ AS id,

	   (SELECT MAX(e.id)
	      FROM bi_empresa_vw e
		 WHERE e.c_empresa = '01') AS id_empresa,

	   (SELECT MAX(c.id)
	      FROM bi_ctb_conta_contabil_vw c
		 WHERE c.c_empresa = '01'
		   AND c.c_conta_contabil = CQ0.CQ0_CONTA) id_conta_contabil,

		(SELECT MAX(m.id)
		   FROM bi_ctb_moeda_vw m
		  WHERE m.c_moeda = CQ0.CQ0_MOEDA) as id_moeda

  FROM CQ0010 AS CQ0 WITH (NOLOCK)
  JOIN CT1010 AS CT1 WITH (NOLOCK)
    ON CT1.CT1_FILIAL = CQ0.CQ0_FILIAL
   AND CT1.CT1_CONTA = CQ0.CQ0_CONTA
   AND CT1.D_E_L_E_T_ <> '*'   
 WHERE CQ0.CQ0_FILIAL = '  '
   AND CQ0.CQ0_TPSALD = '1'
   AND CQ0.D_E_L_E_T_ <> '*'

GO
