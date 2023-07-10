Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D1974D7ED
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 15:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjGJNi6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 09:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjGJNiy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 09:38:54 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20717.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::717])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6012E9;
        Mon, 10 Jul 2023 06:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1c0GAwAyWqm1osqlzqDDIRGKMy+W3uxtxVP6Pffem6PVO9Bf2K2k/yIDDH79bdbu9sCWUat3DIl9fFOWZ/Y8BUr5G/6pDXVlXTjV2QOiItJX3PuayAoeVejqepTe1781pFPcFe0ArsgPIIo77og7NY3ir8e1AppIUMttdR75s+lSgq5jbVP6233JYCsdCdVKJpqTz5lzRzJx9E2cRqOoIxLPCOtOiFAn1BhT1NoqMxc/ci3cKUixY8LjBKK7hQrQpdKjoK2kHXdob6cEWgq35s1xntskFmrJ08t2TCESNyKeH7fs4zvbLc+cnxomQQmx6Ppded7LQaGRlK/TXhM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4w1Wimnk2eqTVF6ncwVzEltvFbxGwNzCAiyCOwi/gP4=;
 b=j8qbAvjxJLM6/AkAF8FevP86iNbAK33JU0db4uJaGtoqqB9t2qVdLaR2Me/Ml/hucDuIo1RaDDFhyGk2p9EpaZaVCziJGTO/QfgU7ywYnhjAnnVjizomv/z3yIAZJBJC7LcKTUsFuSCE3bu98VJnOy8u/t3L0NZYmdsNiuvpRQ4j6nNeT+4gXh9+3UNujUlsEAkcZh6PXobVP/OW03lJgEUHAsk/kXotEyMfJZANH73Mbdjltb7wmYk14IFBVaGx/UHxEakKGMP1gu9Q/HJYtAO+ZXhJuKrLWc6Lzdb7Co/VNiYxZE+iVIlb0AseHDi22cQjB2wqvFvQdgj0ALZ6Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w1Wimnk2eqTVF6ncwVzEltvFbxGwNzCAiyCOwi/gP4=;
 b=ZrR0fihT9n7Evr5hoyapS1BE3OAkgIjZ3QFYFLcoqbg19WT9k5ITeorL4et5TshxgHmdpkmDlieja7XtvSXJ01LBQJrY1K2f6RtHOkqvG/nedOP6RGPxckFIu6jtve6HDWzUdREq0Y7mILYd7GP2TRQ9VEpyPavoxPvR52/jqVD5NpYc16irZzAU0mWYsaxFd+Nx1pW0Lov+v53oihekyEu9n5OPYc8SU5Cyv/CqqGmgTBYdnIvaSdBdTfD0EtWkLVZ3oFhVccqMIJ6ZWl0dBB6zp8hys8G2FzSlzUtIJFK4XAjur4svwUtO4e+tKcnZs8NnV3JFEqWDvqEsJprLhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5594.apcprd06.prod.outlook.com (2603:1096:400:32b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 13:38:44 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 13:38:42 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] fpga: fpga-mgr: altera-pr-ip: Convert to devm_platform_ioremap_resource()
Date:   Mon, 10 Jul 2023 21:38:28 +0800
Message-Id: <20230710133830.65631-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aaedd47-bed6-474e-884f-08db814af977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPN2SsbK9nYJE0oFbOhKOlj804cFIE8/mKwQwqF+iHvlbbhgPXD2fVwAyoQwLIkx5eiBxIfGOpA2mLokdg5EjOaKCSYd0nQbQcqwUwapF26YADZnP+0auYLZf1rQqz/AWyFYfUAoYdwzdC8yNZXxi7wuB/fv9tOPIhRj4q3WiT4KB/obPci/cLxwkaIRbAYO9XmHgWUVOWOl6PXYd7M09tBHnWqVGEpdXKOWgWcQfYfe1DWgGgn94rds9ZYGDoHmzwX6V9TXq5//zpfQI7hzxbDCiP/YrFFkzHoE62ZLxeA6AsYA/uqvCpUzKXW7kuHkvGDlSSfLDQCpaPJ5rXXOAXLnEraMynNtu/IhqgcHnhAOz6ocuxTDLiscKA2Nuh7ZItXJxypvJ/PqEXWOzd9ZBCwwbmOnqm9CI1E62qlEp4RknmhXELpiK478EfikDn4Xmwe89pTNHUqrQrp0ywrGilnPg1swjUnKqxX+yXoA6qzVbkEbKEv4+LQ0Uv35qsoZPR/XBfiqU2KPFduPtlrdJewzpzPWb3cBR5L9eCR7RwzEUnKJ4LvrKQL6dvuBZGOrAGQRG6EAAbhPp3+ENYhUQj8/P/ftHvzcy/GxRtNCptl2nx4TQ1dWRNz7kuLebwHN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(186003)(26005)(1076003)(6506007)(2616005)(6512007)(83380400001)(41300700001)(4744005)(4326008)(66476007)(2906002)(66556008)(316002)(5660300002)(8936002)(8676002)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZzU5v3snO9MYj4fjvaVmjzzoxGiP5oZGDvxJSRIg4DvIGUc1P2XOJ4WqGpsw?=
 =?us-ascii?Q?iGhiyWhQe7WqJOa+4OhPJRb6Glqi2um37oaKxH3uRjp0FoKgiTM1kWcWeKPA?=
 =?us-ascii?Q?3TvnxxoJFvjdFs4eKGWzrYNpy1hRd1wPyUO7ZP9JNcFAm4UJGcWma3R9QHIb?=
 =?us-ascii?Q?rfqGhCXOjOf18212LLpctrhcJz62dM23KIFf230/bu1aRbFIKtZemA6CaYG8?=
 =?us-ascii?Q?7jfX9LsL6mXs9kiT0NQv4T+bXQtyG03LId1FR/q7uuRAieGEeQmkH18Fiey0?=
 =?us-ascii?Q?EMkZTO9obXXuvbG8gK1JrIYumpABfEgKt8JRghm9C6dF8TiXOewdOOKW9AkF?=
 =?us-ascii?Q?gD6ACPAicKRHHIz1KzhWB6N9PKF9/pY5m31BN1/32FBJBLuHHrZ0DHHIYqHO?=
 =?us-ascii?Q?4wDgdazZ4dqC5dvHlVL/iPLLO33r/m9PsfAPrSI5h1WwBpOgeCXPIBKse77M?=
 =?us-ascii?Q?LDNtno9h8YqGt8v00e7ZoK6Jk4R0YfaknJZM56gy910FkBdawdLFjSkJ9C+q?=
 =?us-ascii?Q?Z90MmXEvoyUGz7m5JVn8SrhbKGn74rjSHGKVWgNUyspRISyhSoa0wX9J5lTO?=
 =?us-ascii?Q?hAlm6NSZ50gRIV/4lcVrFU0cZmsbyTivyWTjrWC0z86YUbeOdXc8WIZqEFci?=
 =?us-ascii?Q?dg9xHBEnBzB1y/Nwh8lnEnEIYerLps8ZfCOqCtOlHAfRJPFKb2OaK+bYvM+p?=
 =?us-ascii?Q?//r/BtQagRnMeH4vJlETBoRmWol8WV2+1jWJLlwOFyVQVdzV8DdEchG9WM5B?=
 =?us-ascii?Q?9RLyf0wmyZ3f0lwfDd6lwsYnKry9yDs6LUmq36+nimiNEKPTbW/RxileJMAj?=
 =?us-ascii?Q?8tJC5jIWCUWq7LeFxWy6spUuZcB97Uc7SC5Gmh8K0AfPOw54rmrV0xJP+m2c?=
 =?us-ascii?Q?JbfSMR3zf/ZcCFY0d+efWI05KwFFl2SaNuU7c2y3ROvKIxc8QoVd7CGedeWB?=
 =?us-ascii?Q?jJL82xMSbgxO7l4avmGUo5K25eQGA8WeJLx8OhH0z9gyA8ZOTjn57C7hzW+C?=
 =?us-ascii?Q?ofhik9Yu6bvJijsxrPjHkTLpgRztSXBFJ/nXutywvkvdD6CoTJtEEaqwvq1j?=
 =?us-ascii?Q?R9mLjEI7g/uk9pdATuExxzoWnhaSkFJ+VcTxsqNIs0/Oq1LIXC8PqApMw333?=
 =?us-ascii?Q?VL2FFl9XDj30jlzRa3szhApgqBK+uAEnJv7kw3L1TlrozOYBw84OX+qNUvfB?=
 =?us-ascii?Q?yIqAHUgv5DcTv1sMg5XWbYimQjtjhN4TjhMOBVFIndUpifyj/fU9G0QcwrA+?=
 =?us-ascii?Q?jf8T/gp0I9qlAoq7Pb/r6FjWzV4q/zQvT56GR6Nj0nGHp1pUw1x0l6+5hKMP?=
 =?us-ascii?Q?gF5biCwDJ56zucxa/8Y4cYvWN9SzWYVqXj44rs0XFmF3OlwKOmy1EdnEFvvQ?=
 =?us-ascii?Q?2aKjE28JFnLNAfbQXbhHXAs833HTCFN8ZrZqZdn5KvplimUND8r6DAdpCF5I?=
 =?us-ascii?Q?eNu+f2Ov4pKgDevo3zPQV4ycJwaJLWBLBKcu9f92aYbEKAfkcT1UO4E12KbQ?=
 =?us-ascii?Q?0ZSByApDCX0U/mnGh5y19MfpCL9e1GQSUsbiqx4gilyFnTsfJyUPveqsr04S?=
 =?us-ascii?Q?Oum9PukJpxPrzkvEmR6ZV/jA0aDszAT37qqK9ytu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aaedd47-bed6-474e-884f-08db814af977
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 13:38:41.9658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixUVb5TbK7U16UD6Y2mWL3nOribrgAbARVgNjDguCx4QkThkN+HB33vBcTYqa3nxK8R9oMv6TtwdpB8wiD2XFw==
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
v2:
-keep comment
 drivers/fpga/altera-pr-ip-core-plat.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/fpga/altera-pr-ip-core-plat.c b/drivers/fpga/altera-pr-ip-core-plat.c
index b008a6b8d2d3..06c6a4721205 100644
--- a/drivers/fpga/altera-pr-ip-core-plat.c
+++ b/drivers/fpga/altera-pr-ip-core-plat.c
@@ -15,13 +15,9 @@ static int alt_pr_platform_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	void __iomem *reg_base;
-	struct resource *res;
 
 	/* First mmio base is for register access */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	reg_base = devm_ioremap_resource(dev, res);
-
+	reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg_base))
 		return PTR_ERR(reg_base);
 
-- 
2.39.0

