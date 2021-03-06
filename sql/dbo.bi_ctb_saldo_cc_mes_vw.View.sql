﻿USE [PRODUCAO]
GO
/****** Object:  View [dbo].[bi_ctb_saldo_cc_mes_vw]    Script Date: 19/01/2020 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








create view [dbo].[bi_ctb_saldo_cc_mes_vw] as
SELECT '01' AS c_empresa,
       
	   CASE 
	     WHEN CQ2.CQ2_DATA <> '  ' THEN
		   YEAR(CAST(CQ2.CQ2_DATA AS DATE))
	   END AS n_ano,

	   CASE 
	     WHEN CQ2.CQ2_DATA <> '  ' THEN
		   MONTH(CAST(CQ2.CQ2_DATA AS DATE))
	   END AS n_mes,
       
	   CASE 
	     WHEN CQ2.CQ2_DATA <> ' ' THEN
		   CAST(CQ2.CQ2_DATA AS DATE)
	   END AS d_data,

	   CQ2.CQ2_CONTA AS c_conta_contabil,
	   CQ2.CQ2_CCUSTO AS c_centro_custo,

	   CQ2.CQ2_MOEDA as c_moeda,

	   CQ2.CQ2_DEBITO AS n_saldo_debito,
	   CQ2.CQ2_CREDIT AS n_saldo_credito,

	   CASE
	     WHEN CT1.CT1_NORMAL = '2' THEN  -- credora
		   CQ2.CQ2_DEBITO - CQ2.CQ2_CREDIT
         WHEN CT1.CT1_NORMAL = '1' THEN -- devedora
		   CQ2.CQ2_DEBITO - CQ2.CQ2_CREDIT
	   END AS n_saldo,

	   CQ2.R_E_C_N_O_ AS id,

	   (SELECT MAX(e.id)
	      FROM bi_empresa_vw e
		 WHERE e.c_empresa = '01') AS id_empresa,

	   (SELECT MAX(c.id)
	      FROM bi_ctb_conta_contabil_vw c
		 WHERE c.c_empresa = '01'
		   AND c.c_conta_contabil = CQ2.CQ2_CONTA) id_conta_contabil,

	   (SELECT MAX(c.id)
	      FROM bi_ctb_centro_custo_vw c
		 WHERE c.c_empresa = '01'
		   AND c.c_centro_custo = CQ2.CQ2_CCUSTO) id_centro_custo,

		(SELECT MAX(m.id)
		   FROM bi_ctb_moeda_vw m
		  WHERE m.c_moeda = CQ2.CQ2_MOEDA) as id_moeda

  FROM CQ2010 AS CQ2 WITH (NOLOCK)
  JOIN CT1010 AS CT1 WITH (NOLOCK)
    ON CT1.CT1_FILIAL = CQ2.CQ2_FILIAL
   AND CT1.CT1_CONTA = CQ2.CQ2_CONTA
   AND CT1.D_E_L_E_T_ <> '*'
 WHERE CQ2.CQ2_FILIAL = '  '
   AND CQ2.CQ2_TPSALD = '1'
   AND CQ2.D_E_L_E_T_ <> '*'

GO
