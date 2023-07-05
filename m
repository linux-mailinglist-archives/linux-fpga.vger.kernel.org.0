Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEEC748173
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jul 2023 11:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjGEJtQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Jul 2023 05:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjGEJrr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Jul 2023 05:47:47 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CBD1FD3;
        Wed,  5 Jul 2023 02:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLy/abkUOrkNlaB/k/hgcrMeQqUpQsM68MveAGGE1LUOImBCQ2IMMILRMHt2QxTdUyhrxpcTyCg2gVmHbouDFNq40uiXdAS3wWbSEM7uCDX2BjIaYPbOLFkGuI54OTbnqB2JufVYp4ovrobOYQZ738KZEEBOsYxDwq4/eHtTqtlf8HeDIlu2qHh18Qd3FJcTD8RY/WgMd8UTsGnYBJ4cyvNCywjTcEPFCFqZbpoPGrbeXzsNH8KFyF79GeFyREav6RclylDjmmtfv5/6ncelSIeiCcpD+ZmU42NiPrisH2K6oXyZz13mJxSUJDT8tnFGvUFV3N0USQ6lRba4nrWXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjOm6UAG4W2jD5ACWQU6e6juSINzxVbwn97et2nkctI=;
 b=OhLahqgIha3dMuXYe3GCf+fNj43tt3Shatbn5num1Gd/o7bjlTz9GtdLExsB5kDc/WZvJAb65ScGbVpaRM8aPb59zN0OSME2FVIQuRzUvU5C4+DE5+7pZx1HYZ/stjOguPgnK9lNeHfYPrareX3JjH/3ezpP9cRnxAKIXMk4z0EMIgWAtCBFI70YjtOsf88itTraUaxROY8ZD+sDv/QokA5aDq3LfARFSJ1YE2/e2SSUu5cevO+mVEmhVmLrlVpQ1mXHQUeO2j4z2xNWS+FaoZOglB2VWFglXn3w0KxyBooTstnLB3vI5nlyrScgCffAKYgcM8MUCiC9VmkO8mrfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjOm6UAG4W2jD5ACWQU6e6juSINzxVbwn97et2nkctI=;
 b=BSnzHxV9p1LzYiI8IrUqmQipF1pRkO23rdtLe/8tVC/N8Mjf/g2kvwlc1E4DWV8BqGfKbypIH49jr5XJ/AyWBWW5Sm6Id6fi2F0Oo+t6+aA+6WWw3PRI0HGB+ELDrDUN+QC5jn22Uxj7hcqL9WRnGExCByHIZrhXLHdBnTqAigg7/SAr8R2UHpzpibm3wstLhpaGRXotyZTrSC6+ZZEGBhslYrbGI3UXrMXGpGj4nJXRjMsAI4WIoDjT3XzqHasP0LaoU7Hexb0THB2AL7XdQHHn0DS/okrq3kgXS+bsZBbxI9aJJsq1H/cQ8192kwndoFIEGOF2qAxFsfkgfD4Z/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6219.apcprd06.prod.outlook.com (2603:1096:400:352::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 09:47:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 09:47:19 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] fpga: zynq-fpga: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 17:46:55 +0800
Message-Id: <20230705094655.44753-8-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 23b25d1b-3efa-46af-e538-08db7d3cd2ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqu5Bb7J9kuNH49tDirhm39Ay58Dz6gtO+PobEio3Kf4sc0HGiXlqWY4Z+X/hhdQSOiURV1Vvexcs4vE5ookCsCS8N2yaRS4xS3/do+ntjg1Y0l+n7uA/Vj+wAKaj8iSfgWfYFKoebi40WYgPI4TUzckQz6pWU7E2b/yQKG2CyHsz9mlCaHNYIhxprVWmsJJfkg7rhcCKipk++rnd/Ex38zBOQtxDPDwR5HR5SLWQNt/yOw+GW4kKl98RGB8qgTz53ltpYK1q/CY4fTPiRL9d8aJkjRJbES8kWuUCYf/99tVYaKBO15QMZgUkgxQ4ZP5Vg0NHs1QIfxbXJHdZ3VUr8SZMLJmpcibnkBs4AlrY52dLOgdO8rSSyw6RGm+kMeVWFbtPtUL8H4DJ2QuHUK6drkEEF93GE6zhDxxZWHEgWpXJ/G7+57XyqJFv8jpaBPxDtxQAEWJdvnXmoFG5UCBFjoP6JimMo/FIR72OLRP+hTFaS5a2MT4KS4/s0rj/2nQ6q1FfKUGcW9aOeo0+YxeruORu+TWEH2ltfyxFCimfq63mcJikchO/M5VOesItebuZBQwlPiet6uMQlF8xGxAlQTJRaosO1TDjNCL1kBncupDiruK2cOhJ7U2nT2ZZsN4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(4326008)(316002)(86362001)(186003)(66556008)(66946007)(26005)(66476007)(6512007)(6506007)(1076003)(83380400001)(2616005)(4744005)(2906002)(6486002)(38100700002)(6666004)(52116002)(38350700002)(5660300002)(478600001)(8676002)(110136005)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CjsGwhFSKNfwkkGbGFMcml4gCxzQUF6KlmQJK6isLZmL1md0DVH/O+3jlPiK?=
 =?us-ascii?Q?g3PfGZLWT3gL1EmCYSl3HOUKocUIMqZZolCl/F3yfkRGz+7XmBdN9ZY8jNNO?=
 =?us-ascii?Q?HsYQFRS7dQ1fiLuO8CS9LRII3JR1XPILV7oTc7U7KbzTvXI5esme3q+uGX3D?=
 =?us-ascii?Q?jgzNdsvrIiqe3MX7YdvzEqBRZRHTWDBb7g07yBmXc/xJCu5E4pe2aENssUKu?=
 =?us-ascii?Q?4pPB97qAvA40EisPsJXafohGuXS2aRIHanxP538dzmEzMH36fqc6PlvR3aAS?=
 =?us-ascii?Q?CSuUqtFm9ql19TjVJ4AxKt1mHnQFqheaCMm4hzX1o2hB1nIRP/fMsnNRPe3e?=
 =?us-ascii?Q?/2bDbtFlkIlW0SVhIzZTxt14niQsfsNF8To8rvGBTlDkjP6WT0egPqQBoZ6H?=
 =?us-ascii?Q?6g82bxJJ8iEnfv3pR5E5dymNSEOUy9WrpSMaG61iAluH17uCFOwZMYpq0G5h?=
 =?us-ascii?Q?rP9E89nhO7hZboLCIvlfnIHETdSVQQG7tlss6hwhKHDAyO0ch6TdNawKWBjR?=
 =?us-ascii?Q?so6v8iah6INQZ9BQvwVsjP5Z0py5xnZ5O2QTSYjn0l/915iOEkORTOyT63Nd?=
 =?us-ascii?Q?0gcNkQnmFBth4UBQawykMuQSggzPn/o0RWP3naRgOBZLL6pWwJuRO+sk/85W?=
 =?us-ascii?Q?nPVZrkKYEzJclPelv4kDfr4UWU9JWLnfcEbYMnzA04omUnAJJtArNW6mtcrI?=
 =?us-ascii?Q?sd7CL5lA3LxCsRrN912TYkDofklT9n+Jio8Fbel3GOtO8FA28kqUJGECE5YG?=
 =?us-ascii?Q?J+iriXF05VMXhaPMTVmsxr4HQ8mH3TAK1MiJ+H6s4gHfO3Ogph3fLzcZCfO0?=
 =?us-ascii?Q?vUsVKAXv3XAUwzwyRaqpsmz85Yx+mCQgHy0JRX3pdpjn4UvyW1sAvLpav2zI?=
 =?us-ascii?Q?/YizovNcFDjLL2TpbvlLrI5IMDsEh4Lw93TSfGbITBAwY2YOwcABw9CQQBzl?=
 =?us-ascii?Q?YpjbOAW73/EPzDpuSCBIL1yGgrD1n1BXycglRbEG+D78GBeyLdgCCDlRs9Au?=
 =?us-ascii?Q?KQ68JDWG1pWnAP2hilzBcDbKZ8FaLZZ+dtZipTRZL9rAp51/3aXApPajOwmY?=
 =?us-ascii?Q?sA+VvbMRV0pa1E8fjATRWMFpocIuhL6u0ANPnTPehJknBKN7HZyZV98cEP6t?=
 =?us-ascii?Q?2vItmBzaVNoaQtBlz/KXd88wa05lBl6k5BR+8n4Ry7SOARowEJcdaLa0ZoHj?=
 =?us-ascii?Q?VuqMvqebPPDJBpAQtyBGok6i7sPhXjYdnSSk0ql6qD7/O3csirzM4dK6qb1+?=
 =?us-ascii?Q?Zia5iQ1ThTW5ELgD9+p0QnXVjbiYA1VdqZnl5TQl/96m31cFYoi43p9cq/CP?=
 =?us-ascii?Q?7OwDBXeeYOYNMuKa6EEjpYbYDiMBKxjkmvEp5HuJ2rW9CzZ+MDWC3Xe0LmNT?=
 =?us-ascii?Q?7bFvZ2n/pLEpaPomVPnm1u8JZ3UAhBgqrCyqWORhduyZofBxUaPaVyUKnY+w?=
 =?us-ascii?Q?InyYjSQWXwVdLZwxbd1E8H3CC9vfVivBeO6HmVmOROqpn/NQXCdxgkbrlxbV?=
 =?us-ascii?Q?hHLSM5iXKeQ2YKuwBE/ULjoVO/HLOmRGyqL4Vrfm7zNoZRtBOzr4MtkbRr3W?=
 =?us-ascii?Q?yfoloUAJSUmA95l3Pm1xlSfY5RLrhkGo3lPLT1Dg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b25d1b-3efa-46af-e538-08db7d3cd2ce
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 09:47:19.3292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8UexYpLTS1QQKFxOYCJlG/YtJU3o8s1VM06iGPEBq4L/j9Q6xxxYY1vgCCs4YYyHyDwgtyIhDYjIlEnhG490g==
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
 drivers/fpga/zynq-fpga.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index f8214cae9b6e..96611d424a10 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -555,7 +555,6 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct zynq_fpga_priv *priv;
 	struct fpga_manager *mgr;
-	struct resource *res;
 	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -563,8 +562,7 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	spin_lock_init(&priv->dma_lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->io_base = devm_ioremap_resource(dev, res);
+	priv->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->io_base))
 		return PTR_ERR(priv->io_base);
 
-- 
2.39.0

