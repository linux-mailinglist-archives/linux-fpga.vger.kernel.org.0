Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E14D74D7EC
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 15:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjGJNiy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 09:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjGJNix (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 09:38:53 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20717.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::717])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE75BC;
        Mon, 10 Jul 2023 06:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih6I+pzi0JFAep1lG8NQA/09YIwaO7LlxFG40ZMQxSMIi1wNX2BEtabCJJc5mf2qNq816dXlzKOXfZ1MJykLT+iKs+zvmdAPgp5MatBmLr8JIZM9xXc7B2KapbLCmnlTk86DJYJsCQyVIDeS4vr9RkJ53hXe9pDtGyiw2hvjog6hutiT9+bfH807fYW2XtL+oNdMckPHH4Oe6zEWnxk/onVbwNkWR8KGFjRJF5cEBWoy+V04owNJA1w8HKOqhNYF4o8EbyQUaszWptiihtWsNYaZehWGvvO6Rptg9yZrHSXIvAAfF0nU8Tltq1B402W5E4CM8L5+uCVbn8qMGOQYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrleoFqRlrlpkA9zftySIVdwKeZrEz4wBhsA2wmpXgs=;
 b=KvG7tbk731hOHhCLTsIbqWjnaO1ExgeTfs1KYzh4BTPqUs54SyZuyKtKegccnJDCoS7qiOqdHsbLYdnHe8+W00EIms2gRieGvQhX6yRFTDgupSnvwTPKfh0Rn0AJx0892Z5RDqS0vn+8oMLSGsz+iCpxK8zcz5XzGIAmUZWHsLQDAdyCpVQLYBWRqQLbQrBnJu7PcRXEwl7wsN9affQbOi1EhkEKgDmPo3z6w6q4krAAhIU0UjXceW55oPg2BI89OhtrvSgTXJxf5+EMkMYlmOtjrrmpuIxjrh7uWjW/fXEVHWPNQPyoFZ2E3N8KX7eHeMr3LYe62E4EAal4Db6NVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrleoFqRlrlpkA9zftySIVdwKeZrEz4wBhsA2wmpXgs=;
 b=i8RmKwzMc9TPfuyb3hjkqXJrAHC4S6n9NARLgw2bITaVnQNZw14s/4sZ7zU7jDJa/TKzfkea8T264fhba0zj1mf7yZqdOHeuPMEoQHyDFo30qPePaDBH/+Uaz+6B8G5pBn7oWCf4Jxgpsp/R65hQWprbgfcoFqiuI+7v8IGR5Gozfvh4kuaqY2xZpy21XnoUSfipdlDGkw9NRH0RyrgiJlkIV5piGsIjmwPX4gccz/Iz45dKLeflnTdS3Lx7q1c1ydLiGG9d9JtU/ErEPAJeBWJHFHwPKQhhQ6YzqhD1tHs52kEbaESO0Dr4FqvVvks+95e1s/wouQNyfKk7EjFAOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5594.apcprd06.prod.outlook.com (2603:1096:400:32b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 13:38:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 13:38:45 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] fpga: socfpga-a10: Convert to devm_platform_ioremap_resource()
Date:   Mon, 10 Jul 2023 21:38:29 +0800
Message-Id: <20230710133830.65631-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230710133830.65631-1-frank.li@vivo.com>
References: <20230710133830.65631-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: af66a250-d67f-4bf9-df18-08db814afac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlobQLh7qDsU0Xf9GrHBqPjguow2RzrLVTeGJYYZqB48G9fw5L4Ksl25EFxB7NpYwNW/ICLEhTzvmL2029z+4ep/rJ3hkf2OkUTDbiwAaqf9OUnUPUjj7pQxXkRuI6OIwoO2k1Eke6Zoaljm7GbZwO6Lhue7L3DoHz7OP7WRo1mreG5wjusb5s3jpNUtpYsYWNPovIk0wwTG6Edu/l5ADQ1NLjhk8bTgrB2Tl4/zbaaf4Rz/7nwdD8VkjZi79LdtRT3FlJ4GB8+ICEiyBGXQcL4wgBcfWRE9KhSgOjZcv2bqCZ8uD4LcrmoUv9+5A5O2/SpF+v5yUfOIoSddx/uCpZp0gKbmTNrjySlFBl4HbPCAEYsZ/cKY7cbxzecKrAM89w0XD5gmcUfgg7xdfkPP6/diLdpfGO9V5bIA50rcHcY7SpIYAdAUkxdYouFM28YrhOYJUlw2jsxNspMGXyYcE38kYm97cggRC1/ea1DYTUPTwfnipPO8sBNwO4acTY9+5L/RJbzePyxj9SsANB+pOKelqfV/lj8/ARLiOOYd6K9C5Pvlc+2TAXFkCbVViSJ/BfkbzmW6VOyFHITv84STRQMgdzsJOS5fTuM3eKuaw126iKpvkMoqTIpiHBKCNax6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(186003)(26005)(1076003)(6506007)(2616005)(6512007)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(5660300002)(8936002)(8676002)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oq0w6evc7Ug4YSIKKM9P9F1geLvUeUAgE0Ad5NI3DxoMBya7wUol/gFlACL1?=
 =?us-ascii?Q?/yBpzVf2XYkFhqS5U4wwqJeuToQrrTptjBpBnmXe6ndW6zXlAwW0Ev7LebCP?=
 =?us-ascii?Q?8j5s2Pm4eqC8sQj3sJDbsBoxZD3qXOal7zwZuCqDjnDNDsLqQmz7NYGh4o5h?=
 =?us-ascii?Q?y6oUrBpZ2JqSrpMEcejWmbNUZ7ySP/cymHzk7OVWZjA1/60a1IpMIrXvGCPV?=
 =?us-ascii?Q?3p/mLC7bPqACMsfl+ydg9wBw2/dGKyvOWxmOXMANrWEzViPX1NLWmhVeXVjR?=
 =?us-ascii?Q?ZlTEHWK1u7V58MnGcIw25qrlLYbotwpAsp6GdYfa73M/jAOEhFlngcIS5E6z?=
 =?us-ascii?Q?d8ClSIMEEzKEF1KdaRnFuMtvM+CAdkOvZJkDyXHOrroTy7UXJ8ASJQcWDJnS?=
 =?us-ascii?Q?NEsqs5fYkH8mPGijng6CBwEwVcsLs4R2xUym4kAxZ0pDvuFj8SN7dj4BrhKm?=
 =?us-ascii?Q?xfZ87dCjLkwd3QyC6aVjOrRUx2ExmaNdSs7IYwNT6InHPakrZo11s0b/U1B6?=
 =?us-ascii?Q?0sl21ONZFwj7xdsrO3meMUPwQu8dCkY2eMrRU4EVcZW+JPRTk7R7hfyvu75u?=
 =?us-ascii?Q?TR3vNbrpjAkCiocXIAYHr+gmAbnRS6PwB+f2H6JKjerc3oV5pn8RFGg/tpSu?=
 =?us-ascii?Q?h5ZQiPqbg9MZ9uj924mlzDUhOvKUz7q4xm5zkOSUsLOkhI/n/gRL8UIcptqL?=
 =?us-ascii?Q?Rok8DWMoWjbV1aawgWXfkih8tkIQI88jh5wHuFKe4eA14u8S/pmbZ8p/X1bz?=
 =?us-ascii?Q?1MmxAMq1hf33cQ7hZCR4t1FqrN4x/upBavAC6LUcqMIsKzMKo+50V1Y1nQ7q?=
 =?us-ascii?Q?zBBcynJM1xgun1terLxuw2sV+yFLYVYJsmXaz191AfJDVaO3Hov41RcWoYGh?=
 =?us-ascii?Q?S/e93TRX/xCWGPVGYbPf0lihcPDecZvAT7jBHgKGz2CauQXduseDmMN1NuZ2?=
 =?us-ascii?Q?RztYgXu/yaLWnYjT1vauLdniUHMB2LE7zJQqdSFZycXDv3cNB+a1ODWS1a4j?=
 =?us-ascii?Q?pZjRdccSx89wO5sWCyWVOHXH55lhA08pSaRU+epQPvQ6ymOOP/WzZEZ/VG4d?=
 =?us-ascii?Q?dAGqGNpZ4280QkCozvNiU2+jbZ4VrrFILsjf3NFnezj05f2blL/uLfAhn4ZM?=
 =?us-ascii?Q?ZMReLHLJAzNDeadFp4qtQD4vBmdn/31QOJgnFZ7G5Rotk3LtNG2thMVgPEZB?=
 =?us-ascii?Q?/mdqC9kT7FyBtT7VPn/FmI+RJOhvVXKUHRcWo6EodjdDbmBaN5ZrsBLgWDK3?=
 =?us-ascii?Q?QIa9+/aPfxUW6sfZcNI9TW4YGREy8hsCGgFG593mT68wCwDuBQSs+vrDIyKM?=
 =?us-ascii?Q?1zXUxn6Rpl46czF4h3/KDkPU65wL/7tPSJ670wc6XEh6mH8YchZQmPTEByft?=
 =?us-ascii?Q?sGK30gWDvNadGH3T1kkYoFfj+AeJWX8OJMePmJHi7522sY5ZfoQ+X7IGt2eR?=
 =?us-ascii?Q?yNm1Am/nQBSVzzvK3jLgSeJJv+Dgismr0J59Ebb5SF8A7bTwRJM4AbAke9VG?=
 =?us-ascii?Q?1BC057mPCR7pACNM3g0dYVHCRXka7n9GJDE/Mn88SlUTtedhfDzHIM4j3GGL?=
 =?us-ascii?Q?nSVU1gTuDMXMpFI/QLat6nPLvQHxnUbn5wfedlGZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af66a250-d67f-4bf9-df18-08db814afac2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 13:38:43.9769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTYWvebKy+nMz/I/z5R/nOvhKLxFaMYXNCiAtppChDEZhrRQIWhF/ADWHeF5BNpBfax8+Yw5xPYJQrn+8SCfww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5594
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/fpga/socfpga-a10.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index ac8e89b8a5cc..cc4861e345c9 100644
--- a/drivers/fpga/socfpga-a10.c
+++ b/drivers/fpga/socfpga-a10.c
@@ -471,7 +471,6 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
 	struct a10_fpga_priv *priv;
 	void __iomem *reg_base;
 	struct fpga_manager *mgr;
-	struct resource *res;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -479,14 +478,12 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* First mmio base is for register access */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg_base = devm_ioremap_resource(dev, res);
+	reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg_base))
 		return PTR_ERR(reg_base);
 
 	/* Second mmio base is for writing FPGA image data */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	priv->fpga_data_addr = devm_ioremap_resource(dev, res);
+	priv->fpga_data_addr = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(priv->fpga_data_addr))
 		return PTR_ERR(priv->fpga_data_addr);
 
-- 
2.39.0

