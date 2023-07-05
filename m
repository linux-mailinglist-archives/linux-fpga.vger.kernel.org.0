Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4160748169
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jul 2023 11:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjGEJrb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Jul 2023 05:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjGEJr2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Jul 2023 05:47:28 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A294F198D;
        Wed,  5 Jul 2023 02:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqZ6rNPGdazHsD6iLi0XkE8Z0CGJMvX3mapfg9BESCgWmA2SklpOPnIt5HOJSH8LlEu2LL3N2A7nIMqYk9jgsMkVWdAAaM+izHF3+j8euHitto+cysx24gd2ihtSjIeBDrkA0cBWZJ8LiyXeHNruUhG/fuWHIfkwh9Yjf6C1FZ+DMDJNFROFQwpllfR61nHYDFk+hxBNreg7F4E42XmjQ3OwrZMAk1y9prxMsYvzbJ+2Q8sL6MVk+9ajtST6+XnLzAWB0D0ucW7C5aZpfdfGgx459jFz0Qfcsc8zFvpxirwVJgnENIluLKirp8DcrHw9v9lQ+qJD+9H7UwR145LZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeBOksdayoUe7n1ygBMWX88dn19f22cmJeOzabc/SqU=;
 b=FlG3kDbe3AMQX8t4VJzmUXHdjdeykqhqVtB1Rw0wdwWkuddTEJNNAbBH6lhnC63co/KubQMLusOadQjIifPWcMAcK+aBkF/IPhvKW2ygFsb7MYhcVB35RMk2zgdxvGNzleLvlziKkamH9oABIBsnEccP2FkgJq3ozZSvdY+EJgX1BxU0g/xm5pbWCzVDc4XUE8By1uhBrkL3SYEi6v+4s8oq6sFThbWH9kMvlr86tNn61/shnrahHxDJsZIEpv6lEUxsEejIFtCAHOZ3Z3+hj+4KtsrSxyUwMHSmFH1x4nPpBIffzlDIstho8nmgLoJ+l0B4U+4bPIkpCDcribNJIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeBOksdayoUe7n1ygBMWX88dn19f22cmJeOzabc/SqU=;
 b=jNh8GtVE0LyVK1PG8/70iBMASszyrlFzizXNhaKOG96kCVpcC7i/PtcRrxXw3+JGATe7DrpJqItj5dxI1GVcx/gF/KR62SM9//I0/ZBEY9Z/+CukR9JvhHGVkubn6uG48omVItUumNV7/axcWYDbm3A4zZQe2G20EbSE6m3m1slasm5zR3Gxk7wtRObTGlhKGJCDNlTTAQ4jSkQWW80Z5IhVRQMR9OdCVBoy+NhVsN0Uo+XwxIaN57y0V/gl0qNUowDjuxubcIuJL+yJi89y8Mn7eHqRxg8YAbsCfVB+eFCwc5GFIb0XG+y1xi3XEFsUBLT5P5euo6ivVq2iSH2wKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6219.apcprd06.prod.outlook.com (2603:1096:400:352::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 09:47:15 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 09:47:15 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] fpga: fpga-mgr: socfpga: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 17:46:53 +0800
Message-Id: <20230705094655.44753-6-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 10cc13a0-4db7-49af-343a-08db7d3cd057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t5XHGQgRwESP29a5FGOdsghfrwflt6l7PRTHWJX+8dgc2l384iJgyfZ3MGWs6v6MtTBQrbPKYROVOzV3Z3ERBsFH3/47vTX2fYEhTOmjMmwysqgbqKxd8idP77S6RiqZf7M0ortlS3jqyvzyFaP1KUXIT/RQsk3mfkwcD0uYXFilY+zPh9milgOydnFdRs9W/OroWYm4JzXm6lNkd3W9G1tUIQE1Dm3NE/04auZQDcqQ6owGPwN6SsnVtVb+7S5GUugnhKPemEI+SOKqqthcXiyyOQcNU7Spfay7MLNsopY7yo4OvCKTcY/9gNhWLueVVEFBtdJJ0p4iW2BMcI4KwOHJXTFdS1dl7Z0j+P9vy6JnvQjYbMCLKWU+wv69DTG0woiKt/iGOKnUju6WSewDlxj4AFhOwRVzlJ27gCePBafKlYyXyPiK/HR/Hj2Jw7qjaM7C/6OIXJRCVBm0gIVqq/w8Gj6kbrN+hxmWooR8+oDohCs+jAHFwmATtmua5TpBHqiXgTTgxL4zjKaPe7zRbKHNqSRxIBkgA931Gg9PSX8Vb9zu9gl6S4Eg4/KJo75ITio7b6ZtiQmf+qT4aYavZPjK85vZufKb3nq3z7zPyaZ35/P19W+86Dv+QvqbJTnU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(4326008)(316002)(86362001)(186003)(66556008)(66946007)(26005)(66476007)(6512007)(6506007)(1076003)(83380400001)(2616005)(2906002)(6486002)(38100700002)(6666004)(52116002)(38350700002)(5660300002)(478600001)(8676002)(110136005)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sB/QgiOojhdCNAfgT1BXCkx7LL1+2T6causTnpfNIGHtR0CZZiJFLvqanvCa?=
 =?us-ascii?Q?XbHonvgUwrvIH/8O0zxaW8o19uQ1eDqYeCqNXz9utlQfuYEJmugcxNRTi6h+?=
 =?us-ascii?Q?G+G7N7l/p2A9hbMxLxPkz/WDYHtHJSP4nnHqFfthXLqC2G1fJ3q27mojHrYE?=
 =?us-ascii?Q?J1wujCmgVSjfiuRR9h5/g19gZDXQ6BZb2F5LHDNFzfEZBUzGunCeIrJAuPYq?=
 =?us-ascii?Q?HUHtmB0AmJVr/fplQThNdo83MMRRVAt8L852O6MO5Vno0M3Ju30jua9Ax/wg?=
 =?us-ascii?Q?9g8vBrFQuk6J58qWZCQgXGUcyav+v5vTJWTtaXV9XWd4EJy5mdprN8o0Rsdu?=
 =?us-ascii?Q?o1DAhdiZlR32y3QCdKr8CuVvL/Nxrp7Ou2nc1ca93lB/C0IYnxsKy9PS1PKg?=
 =?us-ascii?Q?+6P8lnivjG00DZLKjLgjmZmtKrWNucwzRkdRtw9FHugqhI/FYnUCoRWslt+v?=
 =?us-ascii?Q?qH+swOZ0GneMs8wRs7kGvUWcoD56/sY/jYlpWmPeVZMg1OKQkcSh/QEAb4iU?=
 =?us-ascii?Q?8Je8HOCrr8cdGKOXlYR/39WWv6uhHXP+MMkx4knmBZ7vJMLtMwNcZUkXQ20T?=
 =?us-ascii?Q?5iqTAH2fFAuqZ01DmlKXm/3Mxs2HjlzKHUMptL+atHcAhnoGhapSU9wZD9R3?=
 =?us-ascii?Q?mhfWalEZY4Tdt0G+lTP3EbCZbZFrYQeMaYEfOVVS1hI4NS07oJ/CgbnMuve0?=
 =?us-ascii?Q?T5P25XrgrC/NaUjYKPUXMt5qcyJvfOutwyDcTNP3v0n9SG/FD7W+a6QS+ziM?=
 =?us-ascii?Q?/sfwamFLLrrXtN42BnwLlgNPGv+47HRipHPP7N8ySb7l7dwlp6bwD/0YZ8eZ?=
 =?us-ascii?Q?4gtxE+veb+iuLlkZLNCk+hWtu6qTapE+R0Xs8g6498/uhJcUbdNG/+SsseXg?=
 =?us-ascii?Q?c5gPmEBUkacrSMjo9JPVy1rHT1p9OyDnt1ya3+xq5ucit8AGNwt1fbCG0eyA?=
 =?us-ascii?Q?CGx3x+TfcnD/hhB622wMNhFwbbaO8QSSvLlJdNXF84Qqr2l2tUF14MDAUYDm?=
 =?us-ascii?Q?iLNKH92q5IqjOyYoX6psBQ5E8Dhsemy0xBqJhBF7Ct+udc71EBXfC6s+bMrX?=
 =?us-ascii?Q?WOiNftzYd1U5pfeCYIJDxAWnqusG/jurdiXUh+hI7Nb8Xeb+bG1+FGeN0i42?=
 =?us-ascii?Q?3L2ungCT4E0oiR5ForzPWZR1QlsFgFchGA7lByLyz3VrRgbk0dZGz/bepLEW?=
 =?us-ascii?Q?LpDJ7p42MZIjNHeXOj16qPAa5epbKqMAAJ6JX9N6vNKYcSbJGFXonYUlQhZP?=
 =?us-ascii?Q?IpVZdJYxm5FA19BXO6EQ+ZLXP7TaEoS2ltdLfxb5MgEGS39zrj4uHvQxk0Hh?=
 =?us-ascii?Q?kGEckzJup/e3QR+St7DxF1MMzSEN/BDtO0RdjNdW+C0ekYJgAIYhxE3q37cE?=
 =?us-ascii?Q?Sgbv1skz4vK8BKTp4xzEoTR1juOYXazHexE0bzibq48aO9JcD6fPtRhgposn?=
 =?us-ascii?Q?Ko3uQQA+fDcyx3ySIsDHyTv2U6u8Wgf9AMV1x+lAl8Th+mDEaxZTgS9KqISX?=
 =?us-ascii?Q?8Z1cfanyyUjXVSWZNVndRZj7d9IS1B/096yn7bFdQotQkmc59Ki621u0/1PB?=
 =?us-ascii?Q?/fpECHARkF7od/514lmHKDcMzErZ3R6HNPG4A3hs?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cc13a0-4db7-49af-343a-08db7d3cd057
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 09:47:15.1936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1M3OHX/sgC0gkCRqv17zzAPykNohsfL1dsf+mkA44ds1G6zbW8tGsjEwiMjHopxou7yV/LG5H8f5sqNnyepnA==
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
 drivers/fpga/socfpga.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index 7e0741f99696..723ea0ad3f09 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -545,20 +545,17 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct socfpga_fpga_priv *priv;
 	struct fpga_manager *mgr;
-	struct resource *res;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->fpga_base_addr = devm_ioremap_resource(dev, res);
+	priv->fpga_base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->fpga_base_addr))
 		return PTR_ERR(priv->fpga_base_addr);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	priv->fpga_data_addr = devm_ioremap_resource(dev, res);
+	priv->fpga_data_addr = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(priv->fpga_data_addr))
 		return PTR_ERR(priv->fpga_data_addr);
 
-- 
2.39.0

