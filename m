Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D725574D7EE
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 15:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjGJNi5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 09:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjGJNiy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 09:38:54 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2116.outbound.protection.outlook.com [40.107.117.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BE09E;
        Mon, 10 Jul 2023 06:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+cEvGl/3N9BoZ5lWHmYN/gQ1kvDZW977K2ZZbNeVbH7uLQV6zsBUSkvxbMjNfrzkTXTzXsuqeZINHGbwp+MR1J1WwDkVSKDKjRa7NfBf7pm8j9dzHFX3mGHgunQNeugmr9CvEiy3EnZIewPRnXHPJbUpsf4AlxU+jqufQQ0JgT8IaTdOBortykiUT/bEhmf8W0Lk7GQsrEcD/OpYPCzcF1tnIOus0DOdYsZEWKRtgUsdCsP5maNWjc7uJWHNLD3UlyX23AtPao3bSXf7ZnyQZogo+vwtphSTfrGjiIBkgw7RrHEt1BDPkq2k25Je33lHm/OMy22YFyvn3kxJWl/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7VzhSVCDtYEhHSCRlGff+uvbOUct4iHuir2pmvSfPM=;
 b=ksZiVN+U/BqH/9emuAgogyrz9wpUBJImHDJvDPW1FLI3JdFDGs6QOOxNekI0FdkTlm4nrYPQ6F4MzUSbPAv/uQkzUomo/TZTcflsEo+dM59o66hxuoVaEJOPIh/6Xf54J4vPDiuDI0E4TYl7Ou3YqtXepPgx5q+V/9i8C5t0Dkx8f6JG++eByZp2e36SkvpuJ6OuPfzmv+pmE9sXPWFr5l3kVKmJ39GXDae8NOBQ9rEwY1ZrfJRmxeuvULdI7sxLvuLhMwWxO/hxba9demQJwql87qaiylCW+SGI8zpB69Ix7E3CxpLX84XGAv8vfV2AUyjB0KCQNCpiwejlpRURng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7VzhSVCDtYEhHSCRlGff+uvbOUct4iHuir2pmvSfPM=;
 b=QeFgz1bbxrNJEvaUu1zSgiqZXs65HNNWM+wDXEGYHC2Wz95dSIGt+14W9wW+M5I9GDEvxN63lR0EG06eJjfQVHcgXe/oUZyykcvAnmTej2/lco6BhuuPXO7md8Y77rX1NmgbFQCrADqAvFzUqTT6QeT+nEyzE09PRwVCcKlqTA0UBWleCH50q3c5V4ag3leWyjUbExr/RjtQbMI0oQHu5Ax4qJ/y7LYD1TXGoiC3sD1gfrj+O2b67x09KlFqhvln0X0iBe7CdNEOG6n6qLEgiJr9fA9ESli6cvIQG2I8t1yQlcS4pTnYTC5r4p6LbdxMTBVxyJUklVatxFqmsayvig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5691.apcprd06.prod.outlook.com (2603:1096:101:af::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 13:38:46 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 13:38:46 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Alan Tull <atull@opensource.altera.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] fpga: socfpga-a10: Fix incorrect return value of devm_regmap_init_mmio
Date:   Mon, 10 Jul 2023 21:38:30 +0800
Message-Id: <20230710133830.65631-3-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5691:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ea1440-c5b4-400f-aa1c-08db814afc23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UWwYlIa65jARA7dQEe2thK+PJmyY5Thybxz041NIpNo8xPdRjiRDKucqfRMh39t30FF1mFDOw5QTqWvmWdG3JV0WgXdf14UjbK/ZVRKm1AYrC8UPhmJqT8Wu7MLf1TY/llkTHnFxpWBQ41xXW/yungjcvwlgPGD6A/RDWauYfql26O9kD9W+yffk2eyU8FlwzAmLM4auySejcCN5BCVuAGHsni7l1p/OJMRdEMTbnlb1aUlrcy77UVTAqKMdbCvDNAw7lyiQT2LRQo3HB6jZbImg2VEsdQ1BJzoJNGSf/jUHcMk8UX9tMOulz3GWK0z/ZGoekKQhNsO9r/kDSj5xqMQc6AGOLccQZ19tphtsw0BE6+8JxhHahjypeMyPHdTet9FDBirBNI/XZi4LpmMmFfYaM3jgA7fCIMWqxFiS3nqe3XNKXIjMrTGeZr/8nT72Y9rQh22KWc5w0O7jvsEJKMC1wtTcO915pbY89mRplavjjyW5TzEQ3i4oMGVOV34Jqwc3/toTqeeTEHvl5QgJVat6G2+OgGI96FhXGPbk+GK4JWKvyNdvpr3XIQTnis80q4YqY77YJ6+aCA8jqsXFVuUJDR1Ir4m+LedhQPH566/57qcK9UADpGZ8YnMe95EG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(86362001)(38100700002)(38350700002)(36756003)(6666004)(6486002)(52116002)(110136005)(54906003)(26005)(6506007)(186003)(6512007)(1076003)(2616005)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(83380400001)(4326008)(4744005)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RYK89IMncJL0x7pOI/YhHpKXf90UqYI5YYRK0fga0cwilwJZVftCKS27GevN?=
 =?us-ascii?Q?faXJvVwLr3Vot6xBOVCAyNmL+OHakaZtBx5QsxMIV9sPJw1IjKzvpijjrTK7?=
 =?us-ascii?Q?FgVu7uywtZ8gFL0xerIdV3Y4ImVxieXjW1E83JacD6XJCkFY5Y5gP/iSdl6q?=
 =?us-ascii?Q?GXEJtdnmgj/zYhtUczElSuTGSoZoQAIHd3wVVvZuhHY08o4flW5q/ZjeRlJ2?=
 =?us-ascii?Q?Gej7+WZCpROoVlMvQe/e32Kl0as41QOXAEzrNT6wQ5Dc8vFD4T8JhV5zLRhL?=
 =?us-ascii?Q?D0H3cZSgLosZMK/q4dXB28jHraoIPxNS0nRaeY5bD9UWjAAz4Mu85Ee4PwOD?=
 =?us-ascii?Q?B9bhXj053VJNcki5TlmJDhFmF5GXcjIF2qvy+EeFmaN9GrFUrKedmROEquPR?=
 =?us-ascii?Q?Njb1uGIWh0JH/w8xuoRQX8P5FOuTIXiD3ITT2bPwoefYnkhoMBheuV5N+Z43?=
 =?us-ascii?Q?XgnOKLAlju6mou99bDTR1H/+8pU2Jrd8JLYklOEWpPXHKMNYZ9GFAsBAf8aB?=
 =?us-ascii?Q?gEbM8CtSLJoZw0NiRHc4+zWNFTpGHTl7ssGHviObIhNXndUAH5JlRCaVKDX7?=
 =?us-ascii?Q?aRJ3edFLDm+qyNW8kUATTRGPBtmAyFipdxWTbJaOCQkDsZtRSwJa+7f6ZE9H?=
 =?us-ascii?Q?ZqeqF+YVXiiOuInbUc0S9wGSxnGcPf2vZ8xZa3dAuljNA1f8cyswTcbRPpZj?=
 =?us-ascii?Q?qdWTGr4k6cvnwMEn70dfF9jVGqVd+yqmv37P9GqZLWFCQMJjMAD8HGjtGB8S?=
 =?us-ascii?Q?NPBizATztmpUafqHDC204FS20cJWdvnlUkT7ECSt6RXwDEsNxU4zbOvoeFET?=
 =?us-ascii?Q?pq8dTisOLa1IEblIrrHLPA3vtJwJsiDcWb/EUbQZFMCB1XYXUykYwS1dhBXB?=
 =?us-ascii?Q?9OW6YttvKcIv6hyX1EIP2lq1rgJo4chSzQ0TdyaNggYntnkSSB4+rk61UKbh?=
 =?us-ascii?Q?spoMp1KDGlhZZ8vKu9Sr4vq+aQ4H5AhqFdXtnu+yeswJslYWvnpZGBuSzQrV?=
 =?us-ascii?Q?v0QlFWHJ8GD8maRgXJx2qMf0H7zkdEDb5iJDsKoUp8l9Ysia781Ah1LpI5G5?=
 =?us-ascii?Q?4iHp8QxcXv65q2SVI9H44WvUM/se2XBzyqxAk2jp2etmRPHtE0Pjor9OWSA7?=
 =?us-ascii?Q?+sAJzLONoqNG7O5T7bWz1v6l9NftQ/vhMc9Yu/012Uut597h4xVIPsVjAMJG?=
 =?us-ascii?Q?LeUkRYU8xR5pz7XBbo3l+H6cactHAazV2VxHUyCfc2TmqjppGvLfazgNmUet?=
 =?us-ascii?Q?zqEbRn9u+wKNpbv+6Wdc2H7MjDbRk1Kpa9hOfy6m7x9ymWLeqWXsl+uUgDmD?=
 =?us-ascii?Q?Ld8PcYtXohhsV+QDq0fsEX9rDjfHZSuUdG+Oic8a7COdEsLHgQth/ZLZ24i8?=
 =?us-ascii?Q?xPSbQJIJBhaF2gqO2Nptrc/NyioPB0jRZqSowypIPRGCzBMXeb6DqesP3n3f?=
 =?us-ascii?Q?8Iu7Ng4PAUj+OmiEI1+hA7impx+XgGXGYmXGD0YF6v88FNO4uHmdA9jFoEVa?=
 =?us-ascii?Q?FSu9X0Lle4q3Rtzfyyb4ybW9TQSKp4OUzPDz1hAQyJjAdcdoT0/EV8Bd8AEL?=
 =?us-ascii?Q?QmgHwCqjkz5oqAPtmAnfC/kBNw5aNmnoOFw1Tn2h?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ea1440-c5b4-400f-aa1c-08db814afc23
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 13:38:46.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zN13aynZKfvenEymh0X8wn0vt6GnKQo+igqRuNp7tm1uK2lVVqTQLNie2+fDbzNMLWu1Qbi+mjdQ+yPWuEZq6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5691
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

When devm_regmap_init_mmio fails, we should return PTR_ERR(priv->regmap)
instead of -ENODEV.

Fixes: acbb910ae04b ("fpga-manager: Add Socfpga Arria10 support")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/fpga/socfpga-a10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index cc4861e345c9..b7b6e0bdb3d9 100644
--- a/drivers/fpga/socfpga-a10.c
+++ b/drivers/fpga/socfpga-a10.c
@@ -491,7 +491,7 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
 	priv->regmap = devm_regmap_init_mmio(dev, reg_base,
 					     &socfpga_a10_fpga_regmap_config);
 	if (IS_ERR(priv->regmap))
-		return -ENODEV;
+		return PTR_ERR(priv->regmap);
 
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk)) {
-- 
2.39.0

