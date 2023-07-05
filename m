Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8E7748175
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jul 2023 11:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjGEJtY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Jul 2023 05:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjGEJrb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Jul 2023 05:47:31 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CC319BD;
        Wed,  5 Jul 2023 02:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPW5YYxjbZHx8XVhPdeORq3bPdE0SDIHxJzQeRc9/nTK/Q73Toe76oDMf9WucqSloOBbOBCWmp2aJC6I2ZWs79RNJnZT+Zmu3vJ/oyCaosPegNNtI2XdsHy5MEGpNm6XMzF+WaO6b4qcd9WsguRqQ1ehN4zG0Ojwm830EzUmFgHbGYr4HMoLMF32178rqEPAinb2kVWw0Wy+8QsDzQEIqsPRKY0XVtseEIKkvQreb+Rm1ooiFpBmSl5v9KAN0ww6mGj0vJJ/ZkO+R/Lqe1a/nJhgS2uWNZngqAT9ZXTi0GbX5YHte/DVkcwU3vWk0dFcmj0AlpcLJJn4BcvoO9q4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyPX6jX1plieiooev6Icr9crN/8MKZaa36xXoB1z/2A=;
 b=mF1wlOtgfyYsNpiJdQrzdU59Kdjm4rSan9vDDZx8+qMPiVH4mcxViLMOfuPQg+HAjTMVwJw+Bb515osGQFYIDCbT6tp8+wOhMUi2ioiTgTPfD7qBYTOJDLRrmcVxqrhxcAX9Ajv2sRn+cmrCpShzLu7+wGJmm5KkpiARSqbLe5KBzmgjShWPu0I0m6n7T4qJBR8/bUi25lW0FRq0IB/sJjC52xuztQhfSqS6nhDZo5EILniOHOOpuCjtw6/1M4CfPy7h8d2pIH3RDfJ3oSq8FijmP6yJnyBVHeegbHVhwyHMaMaQBe9XmMr+P4RXxrGB36fQ378/5A0tY35DDf8UIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyPX6jX1plieiooev6Icr9crN/8MKZaa36xXoB1z/2A=;
 b=GLJOc/lIAH5aFpVFyTMNwiinO4oyDk5DVCOCPztWRIGpWnWY/nipGbjFSMhTE+g8dRSHw8LrN+QiGZfq4eqi3lFDqiZsDKwOXyT5ihTOBu3p/XT/mTXt5Dv+MWb+TGMcmE+8waumYZDHXTZY8NipbNqbqFTMr1bv5YhIFnpa86PCpZ5M+/qps+8cBmQMTvsonEnrB0kLktqOJIGnDh71g0HGIPR+jsg3+Ef0epVf6dl5FvthPR7PHoSH+3oeWQYoJkMqC1TUUCEMEx8K1NkcO44VRpgm1KeNoJxbZh1V7mTH43dUXwhW89SCvBK6xqSAeRuWKN0D41TWrc7qIU3jZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6219.apcprd06.prod.outlook.com (2603:1096:400:352::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 09:47:17 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 09:47:17 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] fpga: fpga-mgr: ts73xx: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 17:46:54 +0800
Message-Id: <20230705094655.44753-7-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 852dc03b-bd77-4ec8-a314-08db7d3cd177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CfrP4r44wY3HwWe5RdQCUKaT3HW6OiAHccdtau/WEI2CSRsm9ei1ZrLM2skU9RZvauyZI/5nmFhbOUODRxP5f365JMtAFjOvQYO9irGW2Pca+23SZvACNccqdwCQVxOdw6AUw26H8MJsYSoxdgx+64auonL9yKeJ6CG3xXJ1nft+5awfLBAt4RrEMHSxDNtxic/f/yyJiWN0p1NU/UTXtDuFGvvYncRaHqb5xvTtA2Uubc435epcdBWZrR+1GEc7/cuupD78imsrD+x7AvE24oV1bPntj7TxnDafDX2LVBz0+zMmD+C5OZYxb2jJa9DfxDoRSk4IHc7RO2hN6fp47CrzvmeoIdQy3JHFQ9SkGu/HivUHMQgpRRDbYYApBrchk59W9AQZQziLetfat46LBGJkOitB1huXEqWBx8xxzcgcpbSR1OP5EJEN+K26umnHAX5rytpO39+krtf8adsd2u7uONOu+3c/q7OEtaDe/wlqyMtO1cr8O8IeTTLsJWSayFNs+wXjI5J3b4vgHY9aHUxwCBzrJBhybezHqjYQ2p6SztnWYbM97L+2rSlIA4JIEB5MF0tMtDe44YDqjj9a2BXwoR6SOgkMn/UlnTTOUnFSheNoPbxt6fXNRY90/wVv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(4326008)(316002)(86362001)(186003)(66556008)(66946007)(26005)(66476007)(6512007)(6506007)(1076003)(83380400001)(2616005)(4744005)(2906002)(6486002)(38100700002)(6666004)(52116002)(38350700002)(5660300002)(478600001)(8676002)(110136005)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5juN/ZinfmldglX8IUqvKL1zH2BsBA2p67Hwg+3X9BbAd/HUBdTz1lKLI+Dw?=
 =?us-ascii?Q?+7J2SooOZdPwauNkgSTwphuHeIoI6TZHq4q+E6T3ZsPFLVnuTy0K2pHtO4nS?=
 =?us-ascii?Q?1NhZLMaQciuEunA9W4SR/ybvI5uMZpEvje9D14ARmS9Nk6DanozBksOAsK1Q?=
 =?us-ascii?Q?+DKUUi/L24SUuXha4AuePTka0HV7rRtoGdkqxPFMkjhCIOWKOZDD8KPAuxyv?=
 =?us-ascii?Q?mTqEpywAHAo7yGxk478ZRJp4LT/zmn8dBxBljtwQqJoZmagncZ/2vAN6PyTH?=
 =?us-ascii?Q?wWI14Q3RkcO//hDNwRTvZqGkqon+L4u5L5pnDtszghMWUR1k6B9+f+od0fla?=
 =?us-ascii?Q?MF6YnnT9cjjSl/Uue8ndp5VXRbVfAupoM4vbXX6R5BGgONypDj3MFr43wSPy?=
 =?us-ascii?Q?4vntqHqUBdxjJVJP4GANPdqYmbEWDU3clQmR1CgC8cOMmsckskaItwIIq6Qg?=
 =?us-ascii?Q?VDxrme5lcsuFHFuEtA9j2x+BfQOwVbXbYFlbFnv6zull2qA5Y65nk7aIsC22?=
 =?us-ascii?Q?ybDcaxQBUXdQz6jwdxf7ijMMWybc42nTgJAJNpsTv8FHU8qaY0BkLuyXGBkO?=
 =?us-ascii?Q?MtdKQRxDhp+VHzy83Mo7PejzPIp9NDa781lLVwBZcaDQiIZcRStA6ltQZNtG?=
 =?us-ascii?Q?AyU2Uc1baGP/AKrXOQsSugw9XBw3Mwtqq9HPzuh2bBDlskTNTgPcUZWBskjI?=
 =?us-ascii?Q?N7k/F17qYOVs+ckbllIrplizsXB8t3Ca0/IdlassWEWg4M4N/uRcnAeypbq2?=
 =?us-ascii?Q?EDCn3km0ZAqxnJg13eDtHjFo9LALXuAgP4kPxgUcx9YVAT3i1ic5faO92NrW?=
 =?us-ascii?Q?2WYAizUb8+od/wsmk1Ng/mCn5guI19DCOi6vNFUUxNulBMJOsHCkIEZijw4i?=
 =?us-ascii?Q?QWytQRV65aq9hov6jhuXwISRWy0rOBGYp5BM6wS+Vbr2Mtp1qzI1E27ykLWA?=
 =?us-ascii?Q?lyXLCcs7MQBBKhfF/NR0OZoydppiSNznVGVhLJ7KN8VSkkguyEZc+aXbelZV?=
 =?us-ascii?Q?L6ASvelUUacDckEI/YKO66tS188lQIcFdCfK3Ozt1t4WKnSTzKKwxbjcIitD?=
 =?us-ascii?Q?aOCJL/FqUNiF1CxP6q6UB914Ot4qlmvskKEQSfTBOK1u8qqbh+Bb2NkT8TzI?=
 =?us-ascii?Q?3f8jgc0nEgZejSKeJE/4KkXMSmSRi2zng4Ei/nIXakTm0Fpl4ImUEpAUuVDA?=
 =?us-ascii?Q?tpA5l3sqpzdpTUV/ZZaHWlk1LLEwMroZnm5o87do1INO+e4sBlVrLEYcVYEB?=
 =?us-ascii?Q?OV8OJS2gEIXQ7nwWtJORacsFTVLrSBOJRmOne0Vgd0zixRx2FZxHocUJgxxz?=
 =?us-ascii?Q?/uRy4ZddznwZDRU8QbZWm5f9s205skNEbsxtNEEEuOQjRt/ZQqKK618XK5Ut?=
 =?us-ascii?Q?efbBjW2ErhGXNFfbDipyT9d8an9xLC7eEGEboXyptAlNO4equyaa1a60LCJg?=
 =?us-ascii?Q?PqUO5TwUblCKt5colf8GI/LHbOv/ZV0Qhr/n+cAEb3rPIe+Ag72g9nLnS1A3?=
 =?us-ascii?Q?wEiOu+IlAHd5bRrDwBlJJ78ymLlBw723U9PXsPUwPHOCGZW6kcjQz7Elo3Dr?=
 =?us-ascii?Q?acNFybOJeSnkEnXkU27gSR4e5PrmRDO9SVatnB2z?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852dc03b-bd77-4ec8-a314-08db7d3cd177
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 09:47:17.0831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYW00Al25bdXWRcDUFIFM20XkXyIYR4iOCDBOKjU7zSY3LF1//zvTd/ldUlzunC5bJ186WVPzmAp7LU39W/q4w==
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
 drivers/fpga/ts73xx-fpga.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index 8e6e9c840d9d..4e1d2a4d3df4 100644
--- a/drivers/fpga/ts73xx-fpga.c
+++ b/drivers/fpga/ts73xx-fpga.c
@@ -103,7 +103,6 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
 	struct device *kdev = &pdev->dev;
 	struct ts73xx_fpga_priv *priv;
 	struct fpga_manager *mgr;
-	struct resource *res;
 
 	priv = devm_kzalloc(kdev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -111,8 +110,7 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
 
 	priv->dev = kdev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->io_base = devm_ioremap_resource(kdev, res);
+	priv->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->io_base))
 		return PTR_ERR(priv->io_base);
 
-- 
2.39.0

