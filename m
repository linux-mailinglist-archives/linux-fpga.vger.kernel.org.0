Return-Path: <linux-fpga+bounces-1441-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22784C4C2A9
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Nov 2025 08:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB893BF3C4
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Nov 2025 07:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCE82D6E55;
	Tue, 11 Nov 2025 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="HDI76nnO"
X-Original-To: linux-fpga@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40562D24BA;
	Tue, 11 Nov 2025 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847334; cv=fail; b=oWrOgYi2o4sEQtI9HTmVHWj7g88dyJARvnWYYZvF7ikNiaaOKsTrRxlMDkxl1eqppyfASo2GLGrm8DaUvO4OvDOY6WYvjbPtFOerFFLhD9+6NT/PC4UbGa/Lc7I7bCtKWARLRsyeraZNcd69Nan4e1MdMBXUdAYdFknnzBg5sNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847334; c=relaxed/simple;
	bh=13fe2ubUYowuy8ALFATw3DxgXu/W4bfmGjtE9KIWVUg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y8yzyJJU1PVXCegLrJHe8B/pk9lHcbsna9fwbVS6rgH178+4ZnVELrT3R2OoeGEK/zbssUV61K/IupEJoEL9bZ8siskBENEwrEXef17qeUEiq9zH0+STWU4UDg8+S0lFn5hJu/V74NnZapvzY1F6ys0mPPcQ9kC6PubgjxRljp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=HDI76nnO; arc=fail smtp.client-ip=40.107.208.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnsP87sJfLsbRAEaX+it0Z5eLptKMdc55w7I5TYdcLZJneaOjg4bRivhiRPP2TjXUYufqxAgaVP1QaOAvDTyYH7Ab6Rya6fXzCJRIm9bKpvIiFZvCNzO3StDeWimOP/xX/Z0yfViUHEvK/bVh44h77lxIwk3hFfqH7JJN38HgxqPYXRzoQm8wRiIVpUY3raNDzNSPgVwwAkJ1vybfsVzlrlZ18H+lJkhU+dfR7akWB+WCOOhPNplUB9CHn2ScB5ZAf0GfM5xr/jcjmiF8K6AwArXxgaxuzBxJQD4yP7i+vDFBMZZBBfXG4fNdVqM+nAY7YLFwDcrUGUhGKhQ/LEPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8xk7sgFZ1iDOvn8kfCNQXFDSLl0Ii/U+lpx+Na8YUg=;
 b=cyKA3c2SlWeDBDcu1AOH+NNF/Eoe3lTRy0YDeoie1wieEULNvoaJpRPRotfa+w4Tyle+aNfhsSpcRKe2NBWGDEHGsbIXseONbRtCUhtJRrcjq0b7qEDNAW1fjYDcmHrATI33tuf31vcs6xoqMZGaM/ql84rP6l4ptVfQ3zJs2cIDIImDBGy7EvFnrX2F27yiepfLicjLVwrry6hZ711EWPHmWqb8jcJXf2llE7Pz6kBjgASiSiYKxjB1zJoTsf3BVMXPaMsM6C6PF4eNz/cR4vAPgf+h2m+G6MSgELYbz558375TREm9RRUEaARpU7jxGkpu8FhfBEFCHvfdwkcWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8xk7sgFZ1iDOvn8kfCNQXFDSLl0Ii/U+lpx+Na8YUg=;
 b=HDI76nnOSMHyJIRV1k5uvcR3pjswTb6cm4RZmmyxs6DJ8C/z0zGIdKbi8UG6wXK0X8ss1O93qpJ8eGuYFfAjN53Z4JanqB/qSjBJI3rMXcYa4+34NSx0N7Knb8HGYfX3faoMno7Yq7nhSMLESDsYPQXI/gXoclo1pLY73AYrL2y8p6yr+qgE3uPyjqM/709WWlpXjtqd3vVpP6lfEqsFmGEI+pvtuvQhEcBTXtTjI2pMk/6I89G0xwMzc3w+f4+edGF7dAi+CC2jH60NOvwcvp9GYKp8EJ3S93FpLew8JK+M+9xHOPselhFEfx8f/DQCP0GEeaOA+e3oq5On6ov/8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by CY1PR03MB8124.namprd03.prod.outlook.com (2603:10b6:930:105::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:48:51 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9298.012; Tue, 11 Nov 2025
 07:48:51 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	Ho Yin <adrian.ho.yin.ng@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 2/3] fpga: stratix10-soc: Add support for Agilex5
Date: Tue, 11 Nov 2025 15:48:32 +0800
Message-ID: <bc45697d22e5a03a1c2d1850841259ea05ae6c4b.1762843803.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1762843803.git.khairul.anuar.romli@altera.com>
References: <cover.1762843803.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0051.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::28) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|CY1PR03MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5275e8-24e9-4c64-de90-08de20f6c11b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7O3HptID+tZqy4F2Iwzh+9Ff9NpmVlQ95eGoGdVx2Vba64ge7v+nIg0U4XhJ?=
 =?us-ascii?Q?OzIzjgLeXH8prarn0Ozzmqza2p9CndQCilVtw8Nf06DcKQ4vEVR2ynucqW9t?=
 =?us-ascii?Q?IfvPmCfxLEYLzL20BX8NtPbq+cxO2AlpJRnzSZNEgDYkcM0sz0206AsswFQO?=
 =?us-ascii?Q?IBIuGiu9ol1QdJv62sbWU7/IVwuPYMAicSXJjQvd50UAkjBC/D5DDjcILCXq?=
 =?us-ascii?Q?FzeHcOaBUCXfvdw/0mu0wLAc3PtpGUVTKzpCdBbFyed7NcRi2cUvAgkm+rc8?=
 =?us-ascii?Q?c36MEUYZMYzHRQ0mOjDpFZZ4lDaAiiIyXLRzHPP0YJjr2kVJGC+CdWufnjV4?=
 =?us-ascii?Q?Gto8dDjVTf02rnO824pm51Sww96iUXRhfguQ0qxZTQ6AQNiZ0TcgPWqcYU+M?=
 =?us-ascii?Q?v7DwKwQ3QvvDoIEMd43p/Bq6IxzaOhM8iDxux1mx9Fw1KWqc6OTjqowrzBKd?=
 =?us-ascii?Q?AEtS2/yrdHe49EnGq7oOGQ5zB4uAyt/udJJUCjAGsrY3Icx3G+xyYMEpzFgT?=
 =?us-ascii?Q?V8UcCRQ5om+GRAhsRIZfbwzNx/isu435Aex0uWh+CMflBPgqGfQOQkqWYliu?=
 =?us-ascii?Q?BjXpIm+rBzE1ld/OEiofj/7/E0JivPK/lsZSM5SwnQNp91H3rP4N5x+bOk2A?=
 =?us-ascii?Q?b+F6ocVCqiUdGv1xr0zhtMYv4czJjT0aARetw37HcrinfjB7A/4yhqU5bKWD?=
 =?us-ascii?Q?Va3EWEIfTMsjVq0hUDTqsu0LcQqHovXk6ssKL5Khs+DeHhpiaC6EdUvMID2c?=
 =?us-ascii?Q?M5P7zFuyZt/KeCTrdkVyX8/EbFHmZNuurdgM6fP4dPjm5Mm6OaFJn2LHD2mr?=
 =?us-ascii?Q?Hcym/+dyoUTnwCA9VKMbi3z+hUt4MP250m1UJ1gYE7nbEvX9UFF/ExB8AVTl?=
 =?us-ascii?Q?aifuXwanvFF5xgFaTwEKFAq53FVrlknIp44pEjGHzgdOQYmRrXspcvS8EbrV?=
 =?us-ascii?Q?X2bNjzud/GW76kHDkk6VqK1sByyqFW2c1N8XT3DqQtC1NYoBFd4I2J+54UQo?=
 =?us-ascii?Q?n86YS13ibjgfV1DluWcFLE0w4kx1+0HXVPAydrYJYzT64DWuUt552OM3kNHH?=
 =?us-ascii?Q?FR0CSBBd2l1UvXwUEs5hPgitRVio2+HIUvgATI9iYEL2H7zoZsy4FAzbXqHh?=
 =?us-ascii?Q?97dmK/k0uqHkr0LruiVpbt4UHR/rVqLrOMN5ItSdO8R3P0sdJ0hV8w0kmX0E?=
 =?us-ascii?Q?R5Cv54tKXaWXVPb3ElQDorZFp8n8WXEj9mWbf0X7DNBM1yPbs/nAWtRUTEsX?=
 =?us-ascii?Q?Tm2a73UwS6Pza3R5IoFuX47BW1IKJNiED4O2Ny3hymdLQyleoZgbeaLoMJRh?=
 =?us-ascii?Q?UV0xIaRZSuAEVWZ70PlZ2Qe9u9tmNdiXq89/DQvfscQBqpO9fJ0+CcSEGR3T?=
 =?us-ascii?Q?D/SH3q4VX/Lun46LRv0fhbB0Ma9PSKPB7/Tu+TjCVuQ/jI9RgOPag7PVYT7G?=
 =?us-ascii?Q?mvcm636rQ0IbGgNDh378B5GbIoYw5cia5QBK+AOZrxfjRqefhav8O3VZREyf?=
 =?us-ascii?Q?HfkRR1jbwFbncxo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RHepCq7pLod2J0bWG4ZWDo4B/EPr0WgoGVD+39XeAdgSLhqsRWDccUJOv73X?=
 =?us-ascii?Q?xMVrdVbKoB3Bmu16wB1wQawIB+Aqk/rmSgpCIHigh7X2ZG41StAA7ptfG1MT?=
 =?us-ascii?Q?o9acfOjREoiqBEKJhIrmxrwy6xVojqkAywzRLiL2UbCRaxOC++A1W7GOXF2y?=
 =?us-ascii?Q?TpmKC3aOf9SuqkbsuFAw8Agoz0LFtmnqkwe5dBBqxkQ6YcctUlkkrjTkzXJw?=
 =?us-ascii?Q?EJrUzqQB53GcxXP1AmItyiFBIsEGuqWWM6r9LcOVsjrxjF7ahXx/jCwJSeJJ?=
 =?us-ascii?Q?d6FxYi5Ec+eO1AmTwvFDpM1yrjs8+KkTyzLP6pZn+jLMEwGdXO3QGWItD99G?=
 =?us-ascii?Q?6JJlpq0HHTkwUCQd6+Sqig+xKyAuJjyiqLlWqiyyFbUDQSMDa/DDwk6byd31?=
 =?us-ascii?Q?GcMNe7XigVh/fTDmD54AaBHaGH9Q6TsgocAZqzQUvueo+SgMqPuq/vf34Rkc?=
 =?us-ascii?Q?qYd9vBi4ftYeVO5+UvGqn3Z3pRyoSJxCsWsGIGsA3tYGrwxjBRyE1qk8yWoh?=
 =?us-ascii?Q?On3XBmOryKM7hFN3mgeDr02iiwvt89WOZFF8Ae4hsUPxrJCt1z7WHD4xi10v?=
 =?us-ascii?Q?7bqKF+xDQmKgaDOzlbXB5aejfWJT8PYzhiwY76nulLu3LjfoANpzOf4sbgex?=
 =?us-ascii?Q?Y6sP672BPf5NfUxtl0epDiW0LgdVqSvRhl02rZMaE4VYf1QEVTOEOBOIPOkn?=
 =?us-ascii?Q?Of9mBGVqYm8lSL66O+mDvOOomPDm9km3HSg+WDWqWtWomZG9Ya6XC4ZKkpcI?=
 =?us-ascii?Q?7+1/Axwah+gJmfKUNYY00Kifhe6yalAFJ4Q4w05EdbjBBR+duHLYkA6AgL4J?=
 =?us-ascii?Q?dbKI+9FqNojmdoRjdzAOWA5dMcQY8JugV72AE0j/CNei3v+83hnXbtcoL80L?=
 =?us-ascii?Q?Wm/ZrmdcEXBHUcZXqcBjEvRNSwbonJzol2cK9Y0/hh6vsbTDW/MAkQMsBbdS?=
 =?us-ascii?Q?fOboJ4b7ZXb1rD0PqJ1pLyiFCYnkt5BUC8kNJKlg9AiauJMlhu6q+3Y6fC45?=
 =?us-ascii?Q?JodGQyLXNdLaa9pa2qsgfRy6+VCMMpVNtAshZYTWbvvVXYriW6NvMd4bulkn?=
 =?us-ascii?Q?1u6+DP87DiyfYOBFXczJuZhr75CBWlOKXlxFOqKlcMYcWndN9zIytzcapRLx?=
 =?us-ascii?Q?JUljB8sgGj3y50npuDkJLxM2V74ZB5iE6v271u5MosasdAg2p8LBZvHihY9o?=
 =?us-ascii?Q?pO48Y6eaAhnNJUI2LnHkDVKTOQsDPIdDn1krMcreECAKxH9COUB47uhBfRWD?=
 =?us-ascii?Q?tnAGSy1rJCsKCyBkB436ECdjiJQqf1IXPP7IjCIULHtU9D13AJshifM3mbry?=
 =?us-ascii?Q?cFGx7nf25AYhPYlXu04B5f+zcgznYSTu+6aR/hg+ZqM69iwHqTLEh3FOmO+p?=
 =?us-ascii?Q?GiBNqJsv2iE5lz0e8R203ECNVVmhlTChZK3GC20oM6Mvs12w18akohBiov2p?=
 =?us-ascii?Q?IrwDlzihGlcqId3HWiB+s2kJxTRtgGOE2AliilCygF5gozUVBkhnga/J5nM6?=
 =?us-ascii?Q?rVX1YBzwDHumjWkARxB8Rq4CPtxTzXUddRSsBxcBmvMpapOVeWF+LPi+6XDL?=
 =?us-ascii?Q?vE80JYfv6fwl+iIkTVIA4IGOfp4fIRPburLQL7kM6I5dhB9RPvVvwrRxLMhE?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5275e8-24e9-4c64-de90-08de20f6c11b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:48:51.1471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIP3vk8P5zX5uEHKrVXvDM7WSJC2gNPWpgksYJ93f1zP73SISXVnk5Jk+s+Xe22xZDJ3d0xiGPaEWqrROKnfhHKnhlipvybEKefCnKuL9kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB8124

Agilex5 device tree now use a dedicated compatible string for FPGA manager
node. The driver relies on matching both the device tree compatible string
and the s10_of_match table during s10_init().

Without this change, the s10_init() function would fail to initialize the
FPGA manager on Agilex5 platforms because the required compatible string is
missing, preventing the driver from loading.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 drivers/fpga/stratix10-soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 0a295ccf1644..4ac368b55754 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -448,6 +448,7 @@ static void s10_remove(struct platform_device *pdev)
 static const struct of_device_id s10_of_match[] = {
 	{.compatible = "intel,stratix10-soc-fpga-mgr"},
 	{.compatible = "intel,agilex-soc-fpga-mgr"},
+	{.compatible = "intel,agilex5-soc-fpga-mgr"},
 	{},
 };
 
-- 
2.43.7


