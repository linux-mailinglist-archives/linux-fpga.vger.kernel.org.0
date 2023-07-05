Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424C4748164
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jul 2023 11:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjGEJr0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Jul 2023 05:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjGEJrS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Jul 2023 05:47:18 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECDB172D;
        Wed,  5 Jul 2023 02:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwGR+3OroQbojeceLU/P5V1f7M09WxpWZlItNtVlZCIbib6hqnxzdUBqqRbhgiWr/M3Vt8s42aUySp4pmhNJOUSJxm0vrYmOheijv2dSPGXx7MlYC/PXNMGdo2zKqXrdnubcNiqR4hqeuMfuVFq0jg+KbYEd0K/QX4iqxgXhv6rMGQzl80svJxMYYD+IqfPWhYfWP3KubqtUbuOVN2jNmrDriQAeiKT9+7PnDTpQH4xeczCbv1wb3t6pCaifKZhFdLfPoJwFUPSRFrIn9CfO/xQBlDefZYrUR3mCpWT+iTY45Ao5w++Fccp0eP9vsgUvDDJgXBCUmiuMjJe7XDINIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlZxzbmZ0KXhnVatLjdVj14GmndZ14kA93ta4Vhdcts=;
 b=i19/KnbTBXUIHTIr4YzUhtNAdDebL3pNvGHf7yVRsDNTN2dr8o+ztoePvY58c8jEdlQk7u9d0XxEkwYVB4CAD0WJ2Vcg+W1FLOtryt1gfroC8l1inlGDHTvGt8k7SQMhUgM6ZFvlSTlMN/5Sz0ALRgzSzBQ+0pC4YvFw/93RM46E+wdVvW4jMPvPcn/NjxB8mr5qyyZ1seTb6VbLwjYV+cM225J5NBjG44SAtT+REhyk3zFn1mUvP99MbY7SgaSm0o5WLZLAzVH76fA3oGdfqgsPQ8YBkarDAgUMRL0jpQ8OE5m+uFN+TmInxLnGJmOeNpWTFCc5hZXKlsMQUv39HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlZxzbmZ0KXhnVatLjdVj14GmndZ14kA93ta4Vhdcts=;
 b=HN0hLlmXzEXxbLG8WfM/lliJzKuyzo3DrSLlEQl3Gk4RyY5qHsGPOstlhfWBv5UJDYo6f9H+bee+AAYB1QPJ+9XBDVJcd7dAbih063OL4tv95s4+omWhL4GRsQuXfwCie0q6mkKn19xEmLUsWoIwm3c+UZ5NODPVEAcJXcap7KOIqWTpX72Lind2qGxXdJwYAH/LlfGVDhjZ5jZ6n/fM6a0flqEt9KpWfKz30aYA+8jjzg/qe0fAepgMdDvsmn/Vbw8FgkAlgxgl8MX1o0MuufuoShq4v6k52jmVar1EXQo7dVkwKt5+zsRZhggm7yNwSaq651t++D4yodpdS4aydA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6219.apcprd06.prod.outlook.com (2603:1096:400:352::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 09:47:13 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 09:47:13 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] fpga: xilinx-pr-decoupler: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 17:46:52 +0800
Message-Id: <20230705094655.44753-5-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c2456431-d38d-478e-18a3-08db7d3ccf07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4s/RppLXxoHY3PN0K1xeViWlvgbKW/s4T4lf/ZVxwvBwPW4J7Af7zdgTCXGYxM/Jl+MStaOCD9lFE+IBHL79JRmYT4DHLdcxubiy/qc7ANgdIhtQAB2JTSmCH7tzX7JdNL2P2ItuW7z75TxLKcAH7cSgQP8FUv3kwwxTtfEOhnTvfbqrf6qb9DxNXNZQGrjbc4UbzcL6OQaHmLQQkUg7CNoYqw2K9U2LIPf6ExCnHtXsBSfl91cTHBHnft5sqo7Wwis9vYsvTbTDir4uSMOtD4miHmtBBWEf4uorRLbW0TxP2kEUiW5iSs3qYdaac6NNziszmQur1SdFE2t1w294BLsRpRrmaxILlQzaDEBieyrm1GR55817DoKkh5oPseq9dinfX0UimrCwk+T0Z3H9wK9ZtiGg9RaAdL0U37/efMq13HPizlGpxAhxkQp2aRz4cVWtXTyXZCbSOGoKQUmUDYsQEgLM0qR2PqOdg1dVPR2JY8LDepjQAszeSqh9n17EF2ZpdfYq/BC20fFiGFneBmpb5752ltCi+93/cPbg0p0/WHzbq1XxdOKN2uwbPxbFgtJ2P4Vpo32dYp2Tu8sX07jdYixGcW5RNqyA3fO26UL4MQklJmjNeIJRpDMGerMT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(4326008)(316002)(86362001)(186003)(66556008)(66946007)(26005)(66476007)(6512007)(6506007)(1076003)(83380400001)(2616005)(2906002)(6486002)(38100700002)(6666004)(52116002)(38350700002)(5660300002)(478600001)(8676002)(110136005)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0H8BqldWk/jskUf7jRmYbB8TkRfi2w/2z6msPZ06QO4o++Ta3eCPjOsrJ6G4?=
 =?us-ascii?Q?IidAN6KFjwtcnjHDrmtuSLohh09Bvwm2aHmnswfLeSX38aa4AbMMTU9CgyA4?=
 =?us-ascii?Q?iGqLUDf1UbAch/IiWIsLhtgLOGa3SztS6i7g7E6HLrs/UoZ6+nP3+FDNpJcf?=
 =?us-ascii?Q?4F+oKXgN/bptU5b9bOkkpr2cUgCA3pUWOrQvjUy0/3cVkIUXe22MMKGL5lfk?=
 =?us-ascii?Q?3sO38kZlFBzZRQWEkVAWdxxL4eWhFl+ZCpIsdUFHJjlU6h8APmTpGr/ji+kY?=
 =?us-ascii?Q?IDnMcfPrEpqCeL/YPeAnbxrjtexIdj1ntC3CJ9EZhe64XvilqVGmSuSHygyG?=
 =?us-ascii?Q?DOoaamIhLltuNyEqGL2Dml6J/6+ZSJE4xXOpZVFGZzMQ5LkupHVFlYzOcENA?=
 =?us-ascii?Q?TM/8DeOMOC2QSIsBrFGZ4W1pxi5l44NZEIKAZU/V68V7/L++Veb1aXfBiTxa?=
 =?us-ascii?Q?oh73xEQqJyDTW1guK71OONYVPCeK/4U9+rQrr0T7UJDxPN83ormixwjjJWnv?=
 =?us-ascii?Q?1iALrlasZmuz3GyWHltKnHrogEVCNi1pyhrtsGqKVnQIblbE7WRb13cYauFn?=
 =?us-ascii?Q?XPci6V57VtGhMHw+qHgQ6Fpt+m1/inBaMhjKy0zaq1DyvpSl22xw35uCNNTp?=
 =?us-ascii?Q?/83L6DThpm5Cy82aeGSb+RxlvdbzhiALqmGLI726LGkzw6G3X+53Xk/A6h21?=
 =?us-ascii?Q?+6+66w8Kdrin7QfzrefbzJ1o5Vmr1fwyMp7MWMvLQt2jmrSsTNH9jPPcaYMw?=
 =?us-ascii?Q?+ehsTlehVh7R2f9UXXC08HjbZ9zxrieMZm0WZqrpsfVJl08k6uHmn9VER0Z2?=
 =?us-ascii?Q?+vi3EIGQhGTfMZFvjgi72Kco7faxvGo2EEi5tcXK9AtCdV30ztAg+daBuCQ/?=
 =?us-ascii?Q?MZ6Eiyk1JwPFQEVOcCpSOH4eKWhS7xfI7b5EV4PUEHK9XF+j65a6vtg36gDo?=
 =?us-ascii?Q?HQ0ZfdLaWxq6cHFUOyBqab9G5Bp2XTUUdOPm6D5QXP+cXcr48ZjzziNB/aON?=
 =?us-ascii?Q?2iw63Fp5EH+Y/otByXITZ07eWULkk4vSosqQxkrJv46Uk0lVR0+UnR8FBMQG?=
 =?us-ascii?Q?TVky849IFVeeIx8GIiqgOcrk64FHn6ZczjY3bhiIiSSOzgRIqUAGEozFBT0n?=
 =?us-ascii?Q?+2V7CAoT6qBUPMcWURXVwSg9fMFHKsQXq4/akaS1NYOw25URUa0Bo07FWDpA?=
 =?us-ascii?Q?lDY3stQ6njOsN2OJAMzsmutZwiRRkhNR8vm7ykI8vxgJCK4PFpUZY9Ew2Zj8?=
 =?us-ascii?Q?02qg8BvYGwz9aZu086UbOa8dd9Fuq8Hhnwl56MOja1jAwCUxxNiQdlYgDEML?=
 =?us-ascii?Q?qM0WuX6BcmrAFYgtyTPoyXmBVzbm3oKI90NUYQyRB6IqvcJfz8C2IRf2JC/T?=
 =?us-ascii?Q?UsjHG70iG3za5QawQVO+NlWk9diz+8N60ArJMhzSu60HUdtMpcrtaq24GmgZ?=
 =?us-ascii?Q?EoUiE3DKHbrbsU5DNLkdHdi49+gsMbWz2wSJLy6dnUTAnBxAbM7L5YFDzSMp?=
 =?us-ascii?Q?nxqZ0Rhosg1OdBH/J0sMTJHwTD7SVl1UUqU8ou0FVY+tAfjwutMNvfII0yZu?=
 =?us-ascii?Q?+dz/E2NrNPZWBlsUvMrar4ipY6X07CJlSx83HHXS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2456431-d38d-478e-18a3-08db7d3ccf07
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 09:47:13.0223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFNH8VLQizfzM2X4T+Lr5A0qeVzGKF6GCaNUKBZDJsmQq0+q4g8u4GnQo9jKfZ0wKLuXmW5KFfcfpJGFIR8D+g==
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
 drivers/fpga/xilinx-pr-decoupler.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index b76d85449b8f..208d9560f56d 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -108,7 +108,6 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 	struct xlnx_pr_decoupler_data *priv;
 	struct fpga_bridge *br;
 	int err;
-	struct resource *res;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -122,8 +121,7 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 			priv->ipconfig = match->data;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->io_base = devm_ioremap_resource(&pdev->dev, res);
+	priv->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->io_base))
 		return PTR_ERR(priv->io_base);
 
-- 
2.39.0

