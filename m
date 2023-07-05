Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1117748160
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jul 2023 11:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjGEJrM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Jul 2023 05:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjGEJrK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Jul 2023 05:47:10 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE15172D;
        Wed,  5 Jul 2023 02:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyFqWKWBUTHZb6uvv/QgVIkBy47tI4BdqbU3FVzkjSfr3a/jq3dXXMOSW5E/7LSGMY6YU/BfKe9g3Cda5sBvgXj/2DTkq0cdEjaCOsL0kF2/Lv4HNAhWd5LPhMoMg6OvD5zqY6Gkzj0a1E7xmfKuiepXpz+0J5H1/lLA7cvOfLH7hOcjxe5ciKJTnHFNINjpEBzRFX88xkLY4Drg8A3n/zHsuHrjSaR0Egq/RN8i/MkpXAwBBlR5NtzHrwGVvr//8v42oc3NJKW8oMFmidF0zfVcVrWwOslZalsm7tGoio+2dUXyh7akY7AP21EuEXOxu/WUlIFYjqExvbCHfRszvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RVLV+DRWVTxkFRKiZWy5JIZiY0q+aMhKaE7SR+5njA=;
 b=G1ajSX/CxfQ17Hs7yGlLrvE+rtfz9rxv44V03k44mBfLlCqNaPEK+dovCMHlNeP1nfYKbwomT5vXtXD1mPy3LNLlkTlqyEe7GSJVXeUsdwHjTEJnEUCM9hEJO9VNbhsBZUwlCgAk1Lrs7+SP7I7uIe9ayhdVzpEIJ77Y7VaYHvG9yqCccB2g9czzxaLwq5eGjlxUUXwwTwpjla4i+5MLIu3lJLrWEbkWDdi5otJgP8M3MRH2b7RBLDAgVMwugubILtPP0YyxxOKATQnVmrRvPO2gFqAJiYe6JbBG9RnXm7CcQNmcePrF+N0Js7zm0OG8qI+/MgyV2JrP4ut4p6WIoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RVLV+DRWVTxkFRKiZWy5JIZiY0q+aMhKaE7SR+5njA=;
 b=cFE/lZyEiKLNqPolnMX+OCRrHOA/xOGfDnd1OMbb8VWWAQIYGzM5PY+CICUeb3iQdROSh8jBmfF47EIfrCocNZyDuoan1siFNyF3hTLHhZtOxXvCEq/ly+5jf3b1jVNcL7/IsPsW3lggyA6z1Tk72+kUh1SMjVdowqcM8KmV/wRNaIE28mpFcZLHZ1AOwHT+qpr4iOtaEJeT9TCfnNk+QScsnT8bnJcPP9mezARvrvPhfuzhGgrLpgrJTrE/A9WIT5WaTV6yZjURA1xLyZpYVdjJARYo0mqtE3EWYH/NSP7pi6RHEuBaVUmRmqbRK1dgxsHCYr4/iuIbbR7QLKa33Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6219.apcprd06.prod.outlook.com (2603:1096:400:352::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 09:47:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 09:47:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] fpga: bridge: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 17:46:48 +0800
Message-Id: <20230705094655.44753-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: f350f6e7-84a5-41e1-8fcf-08db7d3cca10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4xpYkl9i7B23iMudcvfUnRDbIryR5Nk3WQ0dNfH5heEPOrB5J9xlZfdwURN8JUNHPhElRtRJTw35ALrm/pIYAKsp5KqAcXcOIs9B6+JbjsaqeefG9l3nWnEB/5OA8R4EaaowkOSDPxhhsl3XspMUmDLq4dAYCjOamecET9GeIxhjZ9BPk+UExEn7k14UQVpg/0U57ccUpmvvvE3qA/V2x8fw+ahWbuf01bpccyhQ5UeGEnCr1AGhpwxz3qWyvEvl4ECDY2Uhs1weGf0k8Jf1YeSoLmiKVhstj83uV1TGst6+aoMXbnrtVhai9ryq0OomQWeAX4z6nM+pLYi1PW49hZ0fobnEM3zjcpMdjQfqm6aptJ4uBeLf9vVSDPuB3u3NCCjUdzegxGubuuqHGGfjw0hwmV3uTdjzE6nb/6Zzi+vFmRMsJtTnJGbdAoUqFuOGFeSudg1ardAgkQsP1AcjfAuxdw/A9HC4Kc1sFPNJSis5QKBNdr9hwi0m2bkHLCzCh+xtJEdYbyIjgRcKrTEKjipetWDXki3UGbGOV1nujlXxyBX0B1hju1ngYwRE+zZh+ulpQUqCLU0g8SgPEAmZjjNm3RBgHnd0vY8tROzWLkZ0+wc79GK81rhi8ws8AIa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(4326008)(316002)(86362001)(186003)(66556008)(66946007)(26005)(66476007)(6512007)(6506007)(1076003)(83380400001)(2616005)(4744005)(2906002)(6486002)(38100700002)(6666004)(52116002)(38350700002)(5660300002)(478600001)(8676002)(110136005)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fZJBgfJjvk25d+LXDZM2wxbbj8d92qbT4WRjtm+ftZhCQrBHFFoTn99uEyyX?=
 =?us-ascii?Q?MOCZ/n3dfu/leca+Thao04lkzJ5EzUvRNO3oi3ZWbLjEfXXYcsIfR06+59S5?=
 =?us-ascii?Q?9F+AKr2cl9v4ZLQ6Ay5LH3YdHUhh+lei9KucPYYADb5OoQDMyudo4HYN0HKU?=
 =?us-ascii?Q?I6srR9LZUkFnPOkfKmzYZHVHeuE1NH43upSd/7MI54KnbhA5ZASq7I5i5Z/d?=
 =?us-ascii?Q?2YC3RCxYMyRIJQqkDytzP/K0vo1EPH3EKnrwz4e0p+y9rPHHx8E/6rQlysXj?=
 =?us-ascii?Q?GQmhkFTI3OF+ZsBQTiuJwpMQYslgugKVtIpILGr3VAffGvmwAs4yDNzmb7FN?=
 =?us-ascii?Q?LdrstRpSmUYixMLXEvngTI/EW7+gg3oiPjSEjIbKi2fVttcHSDGK7qP5NSQV?=
 =?us-ascii?Q?9A/zIuQiymp3TX3R/VmciIczikIRLe38MktjswYwzbbCdJ43z264YEngKBgy?=
 =?us-ascii?Q?b5VQAeWPLnFBY4aIhosQHyAwZHygL6cytFJ4ohOZ4QAHqOB4EZf8gR4zDdKk?=
 =?us-ascii?Q?I6u1MhTU8KR9dwyWs9MprztrAAY+E+OFK+gIeAZhE0ad9fvp4n5dj36GtNwC?=
 =?us-ascii?Q?F5PbUhw7nLBi/RJzKbNfs1iXqtLtjnF/P9HiPyO0ZgbRLiPixMgsTCB5qUAo?=
 =?us-ascii?Q?ROCwq+cLXkRvR8HyZdUfDShOc8DDalvrr8zrqptRbYOHa9oK81i5MFX/Oo64?=
 =?us-ascii?Q?eBjh8ZnRGaBk6v3xJOI8i69bq+xKuVptBZtaHBnjVTiGUmXux4RntbxEce+g?=
 =?us-ascii?Q?S3F8Td/xBq3sqL1un9PG9jDNoABiDxPpfBW1DZOJiiJx0Zz3QdtDm0E5QCRG?=
 =?us-ascii?Q?/BL0ien0aqzOeQKbwmm1NJ+kGULNcIxoP0SFQCAmh3CRsH5VGznR1GJqWU0k?=
 =?us-ascii?Q?fZl1DYMd+Jakq5UObeTs8XeYPGBM6IcNojOtHVE9kGIFbrMCko6Tq6hq/3PL?=
 =?us-ascii?Q?k27eTkQ+qVID7EhiDPy4baYeyDElS8oFnpT62X+NDEaP9ZCdsv8XNPdejWeh?=
 =?us-ascii?Q?cE8ydg63S2V56Zy2PlDypBxI29u7adzKjo13SdpUkb0iWFdT+fSeKzZo9O9Y?=
 =?us-ascii?Q?OoYcbpBZH4I1DPJfoLRXEI7AtGCJBkvG3KRwHQ4kK+qgTWDElO6ctZ9iZlq/?=
 =?us-ascii?Q?3zPWcr9d/rjPyFQ/nODybyQAtB12nAtcD+tsQ4ygnUcS1t6vQxTIkFk5Ej8i?=
 =?us-ascii?Q?oNJebg/Rcjbaq+Ff6lSchHdFD88xxQXQaGu0W0Oxr+/20+ivPocYuuRcyWBc?=
 =?us-ascii?Q?G27IsqajYAKga1F3dGclAotWEfY9yWQvIE/veF6ZoKRJBKYio74++kmgxrEY?=
 =?us-ascii?Q?lYTRIS15U1Zd/twhOGwiDWEamw0/PV+W5wnerIayYgpVedo3gdk8O3aMZ+m7?=
 =?us-ascii?Q?Nj35EeKlBBq1ooRa60l3lcutThS+Wpb1j9drMJr4SWIQ19d4MiWND2tO9ibs?=
 =?us-ascii?Q?CpqCTQhdeEc1HohpAVZ+gS9sh81nmDptWLxArQwVa0AyDkvrbklC9Pvyj/CE?=
 =?us-ascii?Q?wzMej1CtO2tF6KYpjv9+tSMrw/5peLyjsPaIB9y29/cs4qPmEMXHvjcpABxV?=
 =?us-ascii?Q?V2L8JI+8vSK+vHBsCEjdRysI/i8A6iOerZneIRQH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f350f6e7-84a5-41e1-8fcf-08db7d3cca10
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 09:47:04.7219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0B0zoJgrBIcHnms9KjrzkIvN8uO+DcctHSop4YiSRYjifrZkM8cInL8SMQgeXOOOxirphxjNr7lcIreekn5Xw==
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
 drivers/fpga/altera-freeze-bridge.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
index 445f4b011167..bb6b02ec2d21 100644
--- a/drivers/fpga/altera-freeze-bridge.c
+++ b/drivers/fpga/altera-freeze-bridge.c
@@ -213,14 +213,12 @@ static int altera_freeze_br_probe(struct platform_device *pdev)
 	void __iomem *base_addr;
 	struct altera_freeze_br_data *priv;
 	struct fpga_bridge *br;
-	struct resource *res;
 	u32 status, revision;
 
 	if (!np)
 		return -ENODEV;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base_addr = devm_ioremap_resource(dev, res);
+	base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base_addr))
 		return PTR_ERR(base_addr);
 
-- 
2.39.0

