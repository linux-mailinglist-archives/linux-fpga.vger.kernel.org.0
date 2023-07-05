Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB15748162
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jul 2023 11:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjGEJrU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Jul 2023 05:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjGEJrP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Jul 2023 05:47:15 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E38D1710;
        Wed,  5 Jul 2023 02:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rlj7ZP+Kd7qcm2IRoQcCVfUvYnE6RwDBMsHc1BfjEi8YcKYxlMQ4KL5Lwey0EV5XYD4le8upzMcTcB/Ip49lC45Tr+QcmwczgdmOH4eW5Pv3SXJA5LYZPawvqiylmXY41EPqEaXQOwzilqBhmnf8S5CqLGMbBN3YjTnd9IYuBuENw9GW+nkjknD6r2Pg8QDAoeEkKisjnXZ5lap/dLT4lp7sOMHhNRXoWkzP1eY3nLFzeV70UmTAh0KGcj/G3J0kse/AfXhSgB+JaEMxa/R+/22qPB3jaJ+tG0FMZr/NRU5FhruQ9c7vPZAtWKMrGB3e7lP08j7rlQIGTL/R4nBERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi9xdE4rc6Wv8p4pWdX5mT3He611Xszf9pkmg5rnzaI=;
 b=C6Sut4ogx6pcWiRpI7vKR3+Xi/Cvf0ojT9MzciAazFIpKbhylaA3k19qRcVTyYR4YXpx8ovwdl2tkxCGg/c4Ulzt0AucCy/EAiIGZ42vzAZH2YWzYDE7fCsLFO0REG4n0/i2PXlC+h5cEkViKeRWnVk/Zs+KTGCg/CoiExEMRh+ZXBrctSd6pXiRsUD/Yi6Cj1YyMjOam8MAvFcxPWd//NqlTqWveuk2NHSwngvIccf8WJYb3Gg+YH6OUxckjr7xB4rhDblk6a48d9UxBmOm6oT72ML7jrRstY0OJKGypiw80K0+P76/zsINgAadSoL9MlZnOwgg+p6ilMdaf/6dCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi9xdE4rc6Wv8p4pWdX5mT3He611Xszf9pkmg5rnzaI=;
 b=jfbF7R7PtcLpz6uGj3PNZ7uh4HUurSo2TAZdaS8kBm//0YFE8V97N7zvciqE3kbMDeg2h0M+rDX0s753893FWu3k2BxAh0MwmYY0SKj+pbQLoH5M+6JpUMAnO1RLb1NtrU5RHIekcJmghPxyuBmJJZM/FEDtVxw/0NUeDSH8fVaYHttPNFOeeQisxdKJuTkw3iNx7J5nUdVf1dMYrc6fguZuHVSYjQcWWwLz64TV5zQl/Xp3MHdw/JNrbF2ZJk4Fu3QpqJMQEPrFRNScoYRQmK1AVpcSPIoYEFHo+EpRQX4WdnsSxqbaNpbstmK//yq2EbINPtkpI+sx0pMs+6CrEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6219.apcprd06.prod.outlook.com (2603:1096:400:352::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 09:47:10 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 09:47:10 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] fpga: socfpga-a10: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 17:46:51 +0800
Message-Id: <20230705094655.44753-4-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: fde6ca75-b463-44e1-c199-08db7d3ccdbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQzDQdxIwCFNTEW5GTeNj+uAaKT/t8iO6+++jh4/iok9u/q8ONrnbUOrp2y/lx7cxavAmIplJb5GGf16PuHgJpTrxDfsAAgQn+LQoO7qXtwmZ3L3W65uJEqCmjZXkC0ttbyUngVh0N1EvNqGGFIgn6c/Ox8JDU5K4wLqJfJk7+IR5C1hz1hDK6lT2sAriLrvnro5G8yy2JPtyOkUACqiJmD6fBpHMv3jgqEl69EUBGgYbCzDYO1t5c3NOpy+i0H3dpMoXUDzLcwIhgDN0D9yLNryHvf6EmvXTHs4sa+UWSuiuAc2YdMTqGTsxCbNSPt/0wyKgpUgzwttXP8Y1P3Mgo5usJzpP0X1lI2O5yWdWr89qHErk4VngkW16asSpyxWpuL04uzumVj5xfQGnbPX3O9zyZ3lHbKbFNPI6iETHupFpcR8j5bAOHhnqOgE2FgGSzmatjQiLsBsX1aQldgTDMSPKbP3Nx3C+1oDuVGjlQbhBkAhvspXrv3BnJSJAPVRlle7pN4U6t7RI8yhYQbEtM+UTMldjbxCHzFlD1WGn1BYXGTs8YorO18h4csjnXLVK6OkASXtbEKIbMwjvS7Dix3rFM5UIfRJn9E6P9jYPy8OqLWhz0GICpXVkKz9Yz9G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(4326008)(316002)(86362001)(186003)(66556008)(66946007)(26005)(66476007)(6512007)(6506007)(1076003)(83380400001)(2616005)(2906002)(6486002)(38100700002)(6666004)(52116002)(38350700002)(5660300002)(478600001)(8676002)(110136005)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d8b/iMZQe5Kbhp2Oh/6OwvRpXO0GLwzv4hWRJ2cY9BAlaF2+Qe4Is8Xzmqmp?=
 =?us-ascii?Q?TPsFJ0j/pHVWxrj104JJW1UrYDqiRLnV7dMUoe2I6XQuV4EJMdp95faGH/2s?=
 =?us-ascii?Q?7CKgbowN1QZxXrYEAbMraBqg95V8QZ2qZaqkROXUljCmtV8X99YwJBNfd0Xq?=
 =?us-ascii?Q?3tkmE8eqc6Dz9wgOdyrqFnif4wSEVH/NM7Q8GXTttWHaBNByyBStQeoQBCHD?=
 =?us-ascii?Q?XfLAQNI95FwALmOinVemfrhRb/saO0MoR1T2MChw4zhozYP0vNqmjCqyHy/i?=
 =?us-ascii?Q?xTzF/5Gde9Y5H4HEWpZG2T7ehMv3x62fstD0kZKY5kA/EX3DzTwDjsDk9vGY?=
 =?us-ascii?Q?PUyRfVMlzgYWRbDidd8KYgxn+7Z1+hnONtu1h4pXRAOVOn0AFj6KVPntGkJH?=
 =?us-ascii?Q?9W4kOC7ulBzm+lhpr+70nQ8Yvq7HdzF5jNtrkyU57wRhFGK87mfiWAwDjWEF?=
 =?us-ascii?Q?kZyLdpVFF1ThTTiN5eQ2bf4OlasEXb0Tg1367D2LXjTJNlKxZ6w6Xa0wXMaj?=
 =?us-ascii?Q?Tcwtzk7mvuMMcXjyAEGuUyDbBNFp8F17EG/wjZS0NZeptQB0kgmnmv71jjUl?=
 =?us-ascii?Q?XGSxDlyFsrrv7ylIhmGb+N4RMT+aGjR82jWECbPgS8K3dhHHkGqRF1fpqgoU?=
 =?us-ascii?Q?KbGVK+d4ddUW7z7s97vcNijr0ipuoOv/+WhljVIQook4mHIuF8dg90XszK9l?=
 =?us-ascii?Q?0pOlrUD5X0SlD+cx7+ZYAOBccFAAQgJhtWVnpedYJRSCGeaiao+wx7Iz5/Tm?=
 =?us-ascii?Q?MALvfLhePUfPJgNbWn4rbwM+m0AcWO+PNx/qXAbRXHYF3tx7T0kZIPIJ2qmv?=
 =?us-ascii?Q?UPIT62litDIqjj4Hyr4xLXuFMzF6vKkog7XyPrpBR9iCk2cCsnHPvhXeVhmE?=
 =?us-ascii?Q?x98Yh2j7hiws6YDsuBR+ANFk8cB3YQ00yBHdKvt2EMI1ewVqZTcOQ2wVEysS?=
 =?us-ascii?Q?2mkmJptZGTwksgvPYXPbCoyL8MlFyaNO9qTfrRh1pXIwQTwYyxNliDhu/IZw?=
 =?us-ascii?Q?iN5eZXMgse7XqP8fMSFHO1juaMJj/8arsQzdZErtRxTuArNX4kip3gnjW3Md?=
 =?us-ascii?Q?yOdJL29gvMDOj1s1ec2+WOrdYcEv0YD2cZ74XZnlig+hiH3uOqai6sa5H/E1?=
 =?us-ascii?Q?kqnn8BvBCKRM3ybxdpC+t4Y+0WiQBnD16bDqR8k1lw20XXO8gxLikOMCqdcV?=
 =?us-ascii?Q?hzAl5y6/PB+Rw1IYDpz9baLrc/IIWY+VPlRawWpiWRlyJ3b/dtXEC1V5BiQ9?=
 =?us-ascii?Q?4dNDqPN5EsLi56Z3tgBXs4FLiaVf/bBF2z2yX4ElKGehuPhElzpCwiE1dHI6?=
 =?us-ascii?Q?MCIHjawGalQX0YvmSWPwQ/dEaSWVa+lAgruxa+A8U1P97z4LT5WxvgZ+gx7w?=
 =?us-ascii?Q?3uEZ8v+IJM4lli5GZEvurlA/z9qQbThcCkB0k+JQPkil5K9IamBg2SDg68G0?=
 =?us-ascii?Q?CG1Gw3a9g+35WONHQrpJx/kSTFcetjIrfPb1U2klTMTMnJxiRNEOrkNDnmLg?=
 =?us-ascii?Q?Qa5cgAO2+QlPGa3LjBsSVI/ol07EiW2CrglHphqp2Cctryhi9IXPhSdVJBlF?=
 =?us-ascii?Q?yako2L63jEnofF72GoG3HmZKzu1VX/OjF3yONmDd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde6ca75-b463-44e1-c199-08db7d3ccdbb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 09:47:10.7790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSMxa0wnxcDdssy5RBZZ/foWOk67HYbj4nGVb07Z2bKpNq5sQwYJK9pqmkVnMsu2NaFvzaY2uhCsB8qzIEkkCA==
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
 drivers/fpga/socfpga-a10.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index ac8e89b8a5cc..b7b6e0bdb3d9 100644
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
 
@@ -494,7 +491,7 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
 	priv->regmap = devm_regmap_init_mmio(dev, reg_base,
 					     &socfpga_a10_fpga_regmap_config);
 	if (IS_ERR(priv->regmap))
-		return -ENODEV;
+		return PTR_ERR(priv->regmap);
 
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk)) {
-- 
2.39.0

