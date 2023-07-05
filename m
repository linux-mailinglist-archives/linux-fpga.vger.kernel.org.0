Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060BC74815E
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jul 2023 11:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjGEJrM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Jul 2023 05:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjGEJrL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Jul 2023 05:47:11 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA215E72;
        Wed,  5 Jul 2023 02:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkdZly88RIkGP4LRi2K++CoolxI93ZcVpdDz7ln05u2jJZk0f5C1lmtSPu2aPK31FsnEeLQpDpqqlRbtEGVRfmDIHsupuZRqiYv7eRAmpHJ9iCDS3fUIU78n+teXax9rSziuKjXEAE+3PXsTwKm7YB7JMRzCwCzKB3BolXOi875CjWsrxoR6x4UZ7hcRMO3Si7GWwOjtEs0HIWazdh6xWD0WOkoPOcCSoH3WkprI8hlmwBKhZajCKmAdzuduIg8zW5fB//7R/oRcORFG1+sl+eBZ1ICypEaULjNvjLBtUYS3FyW0jo1xfZMZrJ77cLgidlaLDXjhRR5olVStWDgynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntc0WA3RegtqQnRTN0Tly75aTIgb1dBhmrZVsmV7fVc=;
 b=LoqxKpshUTJXIpudnN8uIbhSPDwo/q6/+HY6gQo9ZyND4RqvuPT6HRdSMpHecdCRadO0PafnyOiExiYfd8Wg032ykFK80rVW9v3ynnFjXl9VleMIDMEU/UFeHGktA0vi0tpETiAqtkV6vsvaXnK7sTjJo0aOAYi2tZOk12Uaha4sjfYB3E88sabTp8SvqJOdeyHsSfIK8cUU2aysTErOpeGbX2YibcPpPbkgD2ikYYWY8QGp7Vtmp1RtZbRgGGEzo908YtBVoT/EPqWqPpzzAm6lkBmHv7zemj8gHH+3A21JCn2H1ywCT89l7n7F7ShLUBAtMpB3xd07S3WVH3F62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntc0WA3RegtqQnRTN0Tly75aTIgb1dBhmrZVsmV7fVc=;
 b=g1GEXn3s2ptXVTrizYRi7lHIG66DB4M4T3WyKpV5fGEqfjFzdtrL2NRDCBiiQcRMBbaAf0AxFtDyO+kj553ZDXLoUgIQO/4cB+CbuWYR8ytkmyQ/SH77WYg1DF0EMaVXJH5VUPV6tqHRcZNZNMEP0fXhE9rUTC9gkBELl3bbIyTDWuqEGII2qv7/5rQLUhueepOlENyHAuQCUTPLlp6gVloed9oOzg/9u+50cIKzSfg/DkmaAwtBL4luMgMZjVeuevFqpxVBrGwno0Tauax49P4vFbvPwn1hxWjl28mtPNGhvZR1fJfXziVE2H8nsOZkcdQWEckB3JS3MEI8m1YgYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6219.apcprd06.prod.outlook.com (2603:1096:400:352::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 09:47:06 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 09:47:06 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] fpga: fpga-mgr: altera-pr-ip: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 17:46:49 +0800
Message-Id: <20230705094655.44753-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b11eba2f-af4a-4710-996a-08db7d3ccb4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IEyMpcsyDtT18+u0Z8bD7r1rriaYtjbBuoOcW9amDk2mpXYE8TJH9G7jIlLkl3xreG6oZJUvkJGFPK9Q+4h14Q6J8unQRpoS3iNJTn58fbHhJV+tRHSFvby4MHeR6VjKknU0m7mskuy8Qxs82fhzEzjqUY/ZPiGeFtCoIZkGHWEGD4acuMq3cv6GZTSMldSAEV/6DiBswE72VMEPmTZIZNrvdN6LPvUenQsuIaxp+budfjhD6QiarcxXgmsUhr134LtS8VCTIb3j/GZIAb87Q5BXDtxxTjkwoBihEw1HYC/CuxgHTNzeOvAmia+Dn0bRA8ejAfnEIgYPK4ZWt7n0yAYoygDMuO4gs4fMB4vYwojCxNJdlVpZ6tYJTNpH7YAuhXYvqSgIc24bHNyCVo6CRAbnHhrk4mSG+Jehl3ZXa4WzwjmHywxzYyuaOZnOZuQFNb2lqDF2zTl2Dk8VG2LYws4TqXGVi2mHK16jt/JAHPCnCPtQGp1H+WcdwBTwmQgnqK/VGbaZO26oW23cBzRz3Ud/fN/LlhuK1IMCt7G2wzOLFTouAgCvc5aQ/0rySt3s2wCPn8bv+nkjIlx3Gwq6wY3Zcw8gMUEqB7UlHF8CYp2Ya8pBGisWkZzmH2Hbbgbc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(4326008)(316002)(86362001)(186003)(66556008)(66946007)(26005)(66476007)(6512007)(6506007)(1076003)(83380400001)(2616005)(4744005)(2906002)(6486002)(38100700002)(6666004)(52116002)(38350700002)(5660300002)(478600001)(8676002)(110136005)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1sqWD7EgQiMXYirrpZd2KYE//RekrBOK8tTl9Puasxoj5mCou9GUjmEzCz64?=
 =?us-ascii?Q?CFZ+cW9W5snz1/OnQg60INEayGrojvRPd5nDlCZDUCkMTLmvAROalk84a2b8?=
 =?us-ascii?Q?jCmRSE3DCpPxVNjHlW+VGLlq2x0vvp6O0ciF6oPoHu5XzGqQB4qLILfXjpuh?=
 =?us-ascii?Q?qiHuV2FR0tczMIodsjYrr0xiJEZrTiI08MUNYXo9i2qA8cicGNMvCb6EjjIz?=
 =?us-ascii?Q?iaUj8moNoaWcLXxWrYwVc04hUC1fOLJ7dIgME7VOoKRxGy87/qRGg6CXNaLX?=
 =?us-ascii?Q?THDX6/xcmivssmAhwagn9zR4BnrVVmtrSKqRmUnC2SVThqzK3I768giTg/Cj?=
 =?us-ascii?Q?MyO7Ftf8oKwjME9lnsj6prBrPRQXdMz6lfnnGjSedunWM9fp6EVSylUH+VNY?=
 =?us-ascii?Q?5DnANRqW5VIGgtCOqhDS0Ygn9lUzBnr+Xu4jvOa45Uh7TdvcV/iJPwGN2ZiT?=
 =?us-ascii?Q?1ZdBdEAnn/QP11D2nArguGYSIrzGEd3mLYSs/5EJzrTtQ0DtnpYfFIKWyyA2?=
 =?us-ascii?Q?Cv6vU9llLMB1ndHfYic6EqebaEFEeRjyflAzgzlDbc8hyETIIIUFpoJmqOS8?=
 =?us-ascii?Q?wUgl1vzsoWIdcHt8tYp7nt+8x7xczCBCU6MObBPCmX1wotQeOCTquJXSMA6M?=
 =?us-ascii?Q?gdBNtcDxE05vQKtfXRWxjEcLCUF3tXYBobDoy6dPGiK67W4ZUsUroWhH6VfK?=
 =?us-ascii?Q?RqcYmRHgO4jwrbC0iownWLbvsOH77SWypaZaL0WMGYaCX2jGDutrZ0o8Pu5Y?=
 =?us-ascii?Q?ZXk67dTYdy7PX/2z5TvYVJD9+KeXF/xp1Cn0qo9SAoeHJuSbUIDooTy25Ovx?=
 =?us-ascii?Q?OeQ5AgRhC8iQ/xYwUyyxThLxOokDuJLLaIC91tXtYz3PHMpVoqQj3NjPFRC4?=
 =?us-ascii?Q?wqm5W9ZdMqeQB7QUWFAnXi8ZaFCooSAeq1UF48DxZKQ/BJYJstHvYgvwu148?=
 =?us-ascii?Q?faXiCGPsb9pwhzl7FFIFgpDaMRFhdn0I3ifYpsOJ46eoR+4AG5aKN8Nr//Cw?=
 =?us-ascii?Q?Ly8PqUnQ5jKuqlqBTORLlOAbWY8AURMBvQRUu16n2qk/v0rgTN1bDfpq1pbf?=
 =?us-ascii?Q?Cd3Xq/VpesxgJwhQixUM2b5ovkjeJmIvOS0T60xuxZQQt9wdOK/IFpqMgsVF?=
 =?us-ascii?Q?seC2P9gGEOagbvOrGOn/szWeCCbAfjTgaRAQNfq9LWwhA5Fdj1b94f2a+pN7?=
 =?us-ascii?Q?zs2L7OLQRIxYdpDEZ8Yrw2LbR1swh9+mQAt5yf2Qh4PEqO9jOkRUBqHTyuTc?=
 =?us-ascii?Q?D90zQLGlgpm2u6wPHHALkBFTmZWcpm5Vmc+rUzXjpPU46Z71AiZoMePLuIfC?=
 =?us-ascii?Q?licNOGixMbpNaHhtir1Eq5bKdD0NqYGGcYHMya/obyPdQaWJtfjMuwbFfETd?=
 =?us-ascii?Q?sHL8DxtITsHS2tGqE6SlUaq6/dP4mayGQGvqm1gmxG856surPJq3LzphHYiV?=
 =?us-ascii?Q?l3Luhb04pR0sOuADTSQ5eWUtLNoKhoEcvwg1EMqqitd/qavtYNjsRl8fq79h?=
 =?us-ascii?Q?5foS3TIWWCtLuO5C+7jAEAbbfoP6LwuZKFfj1G+nmhe83ENVe4sGadikAxPW?=
 =?us-ascii?Q?nrWt+yXrhjE4Fi3mOOdWxe+kYAVU1/+VSA7b5zSf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11eba2f-af4a-4710-996a-08db7d3ccb4d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 09:47:06.7575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sgfkXj/suhFhXli21R0naLoZfF/eZWCV1QzqTzaI9HUvx6BJ6rzKrJGs4ownjVsShaPECPAJJLmtW6PQDuYIg==
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
 drivers/fpga/altera-pr-ip-core-plat.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/fpga/altera-pr-ip-core-plat.c b/drivers/fpga/altera-pr-ip-core-plat.c
index b008a6b8d2d3..fbeae6e68f60 100644
--- a/drivers/fpga/altera-pr-ip-core-plat.c
+++ b/drivers/fpga/altera-pr-ip-core-plat.c
@@ -15,13 +15,8 @@ static int alt_pr_platform_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	void __iomem *reg_base;
-	struct resource *res;
-
-	/* First mmio base is for register access */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	reg_base = devm_ioremap_resource(dev, res);
 
+	reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg_base))
 		return PTR_ERR(reg_base);
 
-- 
2.39.0

