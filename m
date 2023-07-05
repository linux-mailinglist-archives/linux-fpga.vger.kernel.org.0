Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7D774815F
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jul 2023 11:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjGEJrO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Jul 2023 05:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjGEJrN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Jul 2023 05:47:13 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155CFE72;
        Wed,  5 Jul 2023 02:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/fsdpLv2MftUE0ZQk3XohB3zxEy7/sdgCvScn+J39sWismQ7qWtk/0LIrxwVdbEbBnB5Ltf7GTCBsS4RtXG7haeH88g9XJwkax1toaF3cnXE5Ipx8nBYVGnsy2RPMIvv5xVUFuqcOUxh/tIuSFZVi3nqrH8Yiu8wZKt5ThpjktdzZlVch8nErwidM0fHe2D0n7GgjAfuSl7vHl0XCpUY22KYqci9vxsnZHYgXfJVccrqqKUPBTNuMHKwAEaqMJbswXMtkpVVJTeiMF1ThMR4bVVZ1+IlS1Wt1+pvdfxWkDKYwh0Ajb2nWi1Mjgy6Lj/Bjf2XPWw48n/B515lpxD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JH7WIui+YXzkaTFLDLC5c//rYVZ2FNftzQliH8j1Bno=;
 b=nRRgoZ4c6vsmHerSbOQLoMmhe1a5+LbT1VFjuPbWXQkeECtkkNbqqAIh3hcXsc/8Ou58YtXx1ZywPxt2bJt29twedVAzKx/Xb+MJMYaUAdJ5Kx0znr4ct0TbeP+BJzodevikhifs+X3lPJhVzAjRrjhzXhcfUt15Lt3TPrnQSngFbNkrweLOAqsPVseRdAqiRn3dyYG1F0cV+zzhP8A+C1yviGDqot6TozJhGf1FgW0HiMbHZO2wSFoTiZGz7N+tMa01nvEtdx8jdzh+fabTlKfmsDRNcjhXh+0kku8zvGaUw5jxp8PEUtr13D62Ol+BnN9bDG79117pjMrN088mJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JH7WIui+YXzkaTFLDLC5c//rYVZ2FNftzQliH8j1Bno=;
 b=alA9Tti7VTtP5+elwK7wckzqFLCMF2vdRCHRTqtAD2Kgxszz308lufTkIWg7iceqTiZZQbI8elhnw8kz8jeB2O5YKD8sJM/FmZXSzQl3bAOW6JyWhtYezAdOmIDByU0tfOBXJnyy6LLva6nmWAzfiIziXUMdXLGnYXcV/QBaiepqJnxjSjVo3rXpbY+aQ2XshJjWBvw76TGxgW85s3DWStprA44qtgyzzEM/94NwuJKBmuPU7B789mCHYp4w+//p0cSMis9Je2MzXCXrQpVAJ5rNvLdnfdIUhugHN3Odr1apu7Bhja1n8uniALExuP+hRLMeY7p04x+Z7UorrfSX4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6219.apcprd06.prod.outlook.com (2603:1096:400:352::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 09:47:08 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 09:47:08 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] fpga: dfl-fme-mgr: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 17:46:50 +0800
Message-Id: <20230705094655.44753-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705094655.44753-1-frank.li@vivo.com>
References: <20230705094655.44753-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d93bc1b-dc71-46b6-a4e4-08db7d3ccc8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5stK+Bgt4n8V2alhfryfXZPDA8WKijI3x3rY15/+FwSsoFP0zUNr0Hv8koJDo/msTNjwLKh/f5PGmaQ3L1jlFLAwULW+QJDSexxy9crJrmAbc25zqv6+O1TxIFA6QmldO3RkToohYrXqYkNS7eMeBn1o1JzTd+RJgI6leLD6uJmsJbvgKcrX8Q9ZVMGkOGPeFtJwDMytoSa1hMqdcbms8RjgIQUTd+feTNo8cM85QiHKOS7sESQs6/4tuzIx/wrmocrS+POHhF1roht7IuSMWG6J7/uYjjalGNBzYbSuQHd3wn6S0x4N0ob0FAfXSNj2LnbWQGwu8aayqTpUUhKudsEBunQnoPEKHAVd7gmfm+Mz2LAnOPe8zf5Tbe2y0xmYPcTBKbkCzX115tdE4RSr6xr7YhaRoppHd/zeUlMssdiWgrfJ+lS30JgT+nhKeCJQ1JLdV8OiguRC6BlcZr9krrr3CUq1h9ONNP6YyjK0I8VZASFwYnzmcjvRSiO9xROTJMdmdGbvoA8Ow0JpCWJ4+KdmBSNAiGVTbRyuctBafxS/mjM3AiMH++7px9dN45b39NIds4ucvH+hykFXi4R9eMri0Fr09Udc4MFhrCZ7pGifpr1CgF+mt8PMR0sPEWYS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(4326008)(316002)(86362001)(186003)(66556008)(66946007)(26005)(66476007)(6512007)(6506007)(1076003)(83380400001)(2616005)(4744005)(2906002)(6486002)(38100700002)(6666004)(52116002)(38350700002)(5660300002)(478600001)(8676002)(110136005)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VnjW0rWsIl5DSWh9Eg2YEcZpeK97ycYufRon+sIeDIQwMimP9nqe6PlCZ2Aw?=
 =?us-ascii?Q?yCy2bwWqtGmmxWwzeqF1yVy32+biHi5KTv+EtZ3NCLzY+16Yz/dbW/UC69Jp?=
 =?us-ascii?Q?kYgUMOKxuRcIsno57ou91DbPEU8y2DSaZIdEBF9PEOYfJzhtK2X8Y6qUjGzU?=
 =?us-ascii?Q?/dppD5qlylbL+LLjPtP01TysgyucAI8OzZqwUQur8j2dmuscgsHfs4TS1xMS?=
 =?us-ascii?Q?FOgtVOtDpllOtx//LnwqRgvKw5NKdM4PEZfhPxFFcziOrKY+3thA34op5byB?=
 =?us-ascii?Q?QLvYbbbIWe786NF0IVs0vHfvVz7cm4HrVWVwVxcQV72pKgC02s8vuQFut6qZ?=
 =?us-ascii?Q?iLgeo7aGANJ4Z/a0bKosuawJW0veIBr0c5boRR0s6gkCfn00liRFF4QgSMTn?=
 =?us-ascii?Q?4VYBeyBmqkNxat5rlXe2Kg2Pqz7cNGz24WZ/paQGd6/m7qIPUmmhqcobcx9i?=
 =?us-ascii?Q?6DnKhOtV/OMf2ElKgoiyyCYMdjMAz8NP0wKbWuo2jmbTKPyjgLCnBmuOh25/?=
 =?us-ascii?Q?jEl536hiuraIEBQgWTdXjBelaAO2lGr6ii0J5h7SAJ4zbmuo/cBeIf6kHstU?=
 =?us-ascii?Q?NEQK9IYNIuSOGFypzVMaKjbl2xb+D8GUOJVZMJfIKbjO7nPwJRiuQLjaHced?=
 =?us-ascii?Q?9aP0cXx9dIUKm/i6Cn/30/0aia+de4XtLN2YZY/FajywnRM0ygw/kppdRKqC?=
 =?us-ascii?Q?QJqsCiV8uSJCD9Au9ILLTuXz4cEV3AiP0wdpPrma73MG5remhO5feyTEcHIS?=
 =?us-ascii?Q?/h+XQ4G7x9+acooY66cH7/1TE+sfg4Qhl9tXUIVsdftNSQ6bMA2PavvbThV8?=
 =?us-ascii?Q?8ZIkIvnWw3M+XrtTLZbQciaR3QBHpy3fk2yE4ZF4XHqCIcfRKeF/nLLLq5x4?=
 =?us-ascii?Q?zUbYPtu7j3k61efOkF8Ufsp2ooYsudRkus04DQITxr/EyBiKO8kliBU+c2hC?=
 =?us-ascii?Q?wGdVYBMoRKWWX6OfKx8qDVbFdF15LUZwdBWnVoar2lvC3Hul0zHFyeHrio+0?=
 =?us-ascii?Q?o0q8WOvAWjQJx6GHmpXHE3M/ECG9nk8mkEPRqiFS/i1Sg1bPd5VyagRFhzfV?=
 =?us-ascii?Q?NUcvqX0Mky04MfxCBoRjUQLqkkezIGRDeHj+FENWwV7IOX8aiUOJRdnZg42c?=
 =?us-ascii?Q?lOjVe4O21tw2NFlJ9IlikRwoyBbVdyMysU0dZZZueasp54hM92snMpJGtIqr?=
 =?us-ascii?Q?cuDJ/0UGTYj79cwVfNQRCfN+K50ks53yhhxUf9KEg2KDz1qgcQYbQIfvxcKY?=
 =?us-ascii?Q?UE/Mp1sA4zYdNVkSaRaAUoNkcIbWqfDwzHnAvepITzk7R5p+tNKT5pfqFQ6D?=
 =?us-ascii?Q?GcuJreoz+qH7/2gHxtcK0WPoCMMfJwzW4iyMUiphSdgYHSGa2WAISiQjKPuO?=
 =?us-ascii?Q?hYrJyD9jM0KD+0Q3pqA0JjN4/Nou8ObHpcdLdhGOSSSx+yE8MldNf1dEYfya?=
 =?us-ascii?Q?oD+LcFMm4EieuGfOetzlI9r56+/CAKQ1TLd7h+BuRLUhuOut33wWzz9TU0N0?=
 =?us-ascii?Q?c3vinc3m7gaMV/3c9K/KO88ULjHf4EOwAHoauy6nLBccN0wSETSI72r/NPWJ?=
 =?us-ascii?Q?EwNX+Nw8qg8/C+2USrRfvlX/MJjokqXAyMo+3Rfn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d93bc1b-dc71-46b6-a4e4-08db7d3ccc8a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 09:47:08.8178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFAl7fBbf6vmHv2sjUEK4qgX7JFyzKvl2hlj5C+9PfOTCtCtfnp3m/Ecxz0lP/syn4Ii1IUpyADAEc13wSodPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6219
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/fpga/dfl-fme-mgr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index af0785783b52..ab228d8837a0 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -280,7 +280,6 @@ static int fme_mgr_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct fme_mgr_priv *priv;
 	struct fpga_manager *mgr;
-	struct resource *res;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -290,8 +289,7 @@ static int fme_mgr_probe(struct platform_device *pdev)
 		priv->ioaddr = pdata->ioaddr;
 
 	if (!priv->ioaddr) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		priv->ioaddr = devm_ioremap_resource(dev, res);
+		priv->ioaddr = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(priv->ioaddr))
 			return PTR_ERR(priv->ioaddr);
 	}
-- 
2.39.0

