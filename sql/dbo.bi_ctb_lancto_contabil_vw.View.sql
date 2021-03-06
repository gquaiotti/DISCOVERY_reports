USE [PRODUCAO]
GO
/****** Object:  View [dbo].[bi_ctb_lancto_contabil_vw]    Script Date: 19/01/2020 16:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






		





CREATE VIEW [dbo].[bi_ctb_lancto_contabil_vw] as 

SELECT '01' AS c_empresa,

       CT2.CT2_EMPORI AS c_empresa_origem,
	   CT2.CT2_FILORI AS c_filial_origem,
       
	   CASE 
	     WHEN CT2.CT2_DATA <> '  ' THEN
		   YEAR(CAST(CT2.CT2_DATA AS DATE))
	   END AS n_ano,

	   CASE 
	     WHEN CT2.CT2_DATA <> '  ' THEN
		   MONTH(CAST(CT2.CT2_DATA AS DATE))
	   END AS n_mes,

	   CASE 
	     WHEN CT2.CT2_DATA <> '  ' THEN
		   CAST(CT2.CT2_DATA AS DATE)
	   END AS d_data,

	   CT2.CT2_DC AS c_tipo,
	   
	   CASE CT2.CT2_DC 
	     WHEN '1' THEN 'Debito'
		 WHEN '3' THEN 'Debito' 
	   END AS c_tipo_descricao,

	   CT2.CT2_DEBITO as c_conta_contabil,

	   CT2.CT2_CCD as c_centro_custo,
	   
	   CT2.CT2_ITEMD AS c_item_contabil,
	   CT2.CT2_CLVLDB AS c_classe_valor,

	   CT2.CT2_MOEDLC AS c_moeda,
	   CT2.CT2_VALOR AS n_valor,

	   CASE
	     WHEN CT1.CT1_NORMAL = '2' THEN -- credora
		   CT2.CT2_VALOR * -1
         WHEN CT1.CT1_NORMAL = '1' THEN -- devedora
		   CT2.CT2_VALOR
	   END AS n_saldo,

	   CT2.CT2_LOTE as c_lote,
	   CT2.CT2_SBLOTE as c_sublote,
	   CT2.CT2_DOC as c_doc,
	   CT2.CT2_LINHA as c_linha,

	   RTRIM(CT2.CT2_HIST) as c_historico,

	   RTRIM(CT2.CT2_XRKEY) AS c_report_key,
       RTRIM(CT2.CT2_XCCOD) AS c_company_code,
       -- RTRIM(CT2.CT2_XREGIA) AS c_regiao,

	   CT2.CT2_EC05DB AS c_projeto,
	   CT2.CT2_EC06DB AS c_regiao,

	   CT2.CT2_KEY AS c_chave,
       
	   CT2.R_E_C_N_O_ AS id,

	   (SELECT MAX(e.id)
	      FROM bi_empresa_vw e
		 WHERE e.c_empresa = '01') AS id_empresa,

	   (SELECT MAX(e.id)
	      FROM bi_empresa_vw e
		 WHERE e.c_empresa = CT2.CT2_EMPORI) AS id_empresa_origem,

	   (SELECT MAX(f.id)
	      FROM bi_filial_vw f
		 WHERE f.c_empresa = '01'
		   AND f.c_filial = CT2.CT2_FILORI) AS id_filial_origem,

	   (SELECT MAX(c.id)
	      FROM bi_ctb_conta_contabil_vw c
		 WHERE c.c_empresa = '01'
		   AND c.c_conta_contabil = CT2.CT2_DEBITO) id_conta_contabil,

	   (SELECT MAX(c.id)
	      FROM bi_ctb_centro_custo_vw c
		 WHERE c.c_empresa = '01'
		   AND c.c_centro_custo = CT2.CT2_CCD) as id_centro_custo,

	   (SELECT MAX(i.id)
	      FROM bi_ctb_item_contabil_vw i
		 WHERE i.c_empresa = '01'
		   AND i.c_item_contabil = CT2.CT2_ITEMD) AS id_item_contabil,

	   (SELECT MAX(c.id)
	      FROM bi_ctb_classe_valor_vw c
		 WHERE c.c_empresa = '01'
		   AND c.c_classe_valor = CT2.CT2_CLVLDB) AS id_classe_valor,

		(SELECT MAX(p.id)
	      FROM bi_ctb_projeto_vw p
		 WHERE p.c_projeto = CT2.CT2_EC05DB) AS id_projeto,

		(SELECT MAX(r.id)
	      FROM bi_ctb_regiao_vw r
		 WHERE r.c_regiao = CT2.CT2_EC06DB) AS id_regiao,

		(SELECT MAX(m.id)
		   FROM bi_ctb_moeda_vw m
		  WHERE m.c_moeda = CT2.CT2_MOEDLC) as id_moeda

  from CT2010 AS CT2 WITH (NOLOCK)

  JOIN CT1010 AS CT1 WITH (NOLOCK)
    ON CT1.CT1_FILIAL = CT2.CT2_FILIAL
   AND CT1.CT1_CONTA = CT2.CT2_DEBITO
   AND CT1.D_E_L_E_T_ <> '*'   

 WHERE CT2.CT2_FILIAL = '  '
   AND (CT2.CT2_DC = '1' OR CT2.CT2_DC = '3')
   AND CT2.D_E_L_E_T_ <> '*'

 UNION ALL

SELECT '01' AS c_empresa,

       CT2.CT2_EMPORI AS c_empresa_origem,
	   CT2.CT2_FILORI AS c_filial_origem,
       
	   CASE 
	     WHEN CT2.CT2_DATA <> '  ' THEN
		   YEAR(CAST(CT2.CT2_DATA AS DATE))
	   END AS n_ano,

	   CASE 
	     WHEN CT2.CT2_DATA <> '  ' THEN
		   MONTH(CAST(CT2.CT2_DATA AS DATE))
	   END AS n_mes,
       
	   CASE 
	     WHEN CT2.CT2_DATA <> '  ' THEN
		   CAST(CT2.CT2_DATA AS DATE)
	   END AS d_data,

	   CT2.CT2_DC AS c_tipo,
	   
	   CASE CT2.CT2_DC 
		 WHEN '2' THEN 'Credito'
		 WHEN '3' THEN 'Credito' 
	   END AS c_tipo_desc,

	   CT2.CT2_CREDIT as c_conta_contabil,

	   CT2.CT2_CCC as c_centro_custo,
	   
	   CT2.CT2_ITEMC AS c_item_contabil,
	   CT2.CT2_CLVLCR AS c_classe_valor,

	   CT2.CT2_MOEDLC AS c_moeda,
	   CT2.CT2_VALOR AS n_valor,

	   CASE
	     WHEN CT1.CT1_NORMAL = '2' THEN -- credora
		   CT2.CT2_VALOR
         WHEN CT1.CT1_NORMAL = '1' THEN -- devedora
		   CT2.CT2_VALOR * -1
	   END AS n_saldo,

	   CT2.CT2_LOTE as c_lote,
	   CT2.CT2_SBLOTE as c_sublote,
	   CT2.CT2_DOC as c_doc,
	   CT2.CT2_LINHA as c_linha,

	   CT2.CT2_HIST as c_historico,

	   CT2.CT2_XRKEY AS c_report_key,
       CT2.CT2_XCCOD AS c_company_code,
       -- RTRIM(CT2.CT2_XREGIA) AS c_regiao,

	   CT2.CT2_EC05CR AS c_projeto,
	   CT2.CT2_EC06CR AS c_regiao,

	   CT2.CT2_KEY AS c_chave,
       
	   CT2.R_E_C_N_O_ AS id,

	   (SELECT MAX(e.id)
	      FROM bi_empresa_vw e
		 WHERE e.c_empresa = '01') AS id_empresa,

	   (SELECT MAX(e.id)
	      FROM bi_empresa_vw e
		 WHERE e.c_empresa = CT2.CT2_EMPORI) AS id_empresa_origem,

	   (SELECT MAX(f.id)
	      FROM bi_filial_vw f
		 WHERE f.c_empresa = '01'
		   AND f.c_filial = CT2.CT2_FILORI) AS id_filial_origem,

	   (SELECT MAX(c.id)
	      FROM bi_ctb_conta_contabil_vw c
		 WHERE c.c_empresa = '01'
		   AND c.c_conta_contabil = CT2.CT2_CREDIT) id_conta_contabil,

	   (SELECT MAX(c.id)
	      FROM bi_ctb_centro_custo_vw c
		 WHERE c.c_empresa = '01'
		   AND c.c_centro_custo = CT2.CT2_CCC) as id_centro_custo,

	   (SELECT MAX(i.id)
	      FROM bi_ctb_item_contabil_vw i
		 WHERE i.c_empresa = '01'
		   AND i.c_item_contabil = CT2.CT2_ITEMC) AS id_item_contabil,

	   (SELECT MAX(c.id)
	      FROM bi_ctb_classe_valor_vw c
		 WHERE c.c_empresa = '01'
		   AND c.c_classe_valor = CT2.CT2_CLVLCR) AS id_classe_valor,

	    (SELECT MAX(p.id)
	      FROM bi_ctb_projeto_vw p
		 WHERE p.c_projeto = CT2.CT2_EC05CR) AS id_projeto,

		(SELECT MAX(r.id)
	      FROM bi_ctb_regiao_vw r
		 WHERE r.c_regiao = CT2.CT2_EC06CR) AS id_regiao,

		(SELECT MAX(m.id)
		   FROM bi_ctb_moeda_vw m
		  WHERE m.c_moeda = CT2.CT2_MOEDLC) as id_moeda

  from CT2010 AS CT2 WITH (NOLOCK)

  JOIN CT1010 AS CT1 WITH (NOLOCK)
    ON CT1.CT1_FILIAL = CT2.CT2_FILIAL
   AND CT1.CT1_CONTA = CT2.CT2_CREDIT
   AND CT1.D_E_L_E_T_ <> '*'   

 WHERE CT2.CT2_FILIAL = '  '
   AND (CT2.CT2_DC = '2' OR CT2.CT2_DC = '3')
   AND CT2.D_E_L_E_T_ <> '*'

GO
