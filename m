Return-Path: <linux-fpga+bounces-1396-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D797C1CEDF
	for <lists+linux-fpga@lfdr.de>; Wed, 29 Oct 2025 20:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0878E582E6C
	for <lists+linux-fpga@lfdr.de>; Wed, 29 Oct 2025 19:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762A93596EB;
	Wed, 29 Oct 2025 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="cz/dFH6R"
X-Original-To: linux-fpga@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B83596E5;
	Wed, 29 Oct 2025 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764874; cv=fail; b=eQ5BPR698qHLheGGwDlqBwgqaAGXCnvQq+d+2VM4RD2WCzCND4CWGWC4UT8ysG+kPgUV5LiBPHmIXF6UDDcpgrSp0bWh6sgM05uyzRyYEyXyYNAKBSZQkyn+NNCkyfBJQgkJbSByIwPrHFyh4mhWGQQwRVDQmKqJdUal1XKLKUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764874; c=relaxed/simple;
	bh=r4UIl/UKl9DHi4g7sXMVNSaBtyekNFPsDYRmLNjsO04=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hlCSwZT8+tuhQeLoUkSaYm8o7X9rWt4a4PNBNID/CljIY9/fzn2QgiVAKLu5XYweOVi1vtSdscpK6yJ6sJnKbEDFUS6SI0SStdxWLLq7bzHn8voEEE8WoWgPGxX/JqGbVCEn2/lltjgXP8rCugIXnNNOleyNZhzAGqfqHLtCcFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=cz/dFH6R; arc=fail smtp.client-ip=52.101.43.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKyXGAmK5FrbUwimr0RSrHmdAvtM3w0Yji0Oywae8QzbJrZndB35eBWt74d4+azE4VHTWrJpRKmIkb4bNyt2XuLZ67DZgje2KpLxgNALPXarL/NYBBBvyEPUHEuS7RTjfJLNGZSZ5aBPeOrOXQn6625yXflsS2Fd5ktaIZX+jOfeGg7aUuoUyCfWghEjT99U8Up5r4xwwrPh60DBqXXDgnI2gfas4uXt8tni9UWk2UgcGESQYVhsFXx7N5vSG0KpM/M7YHR8rhg2GaRAu4feX7+6cnOSTcoDcaPieVsjcebwZdXYiTZK+/qIg0WYpCuX6BtquMMIr7Xo+/hALfbiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKF3aIJDw6pOngsBvz6oUnxUIMFaual0x1to6OhopH4=;
 b=YkWZbpzuzCC4jXyjGoBb1RqFiBPuT2hpAtw1aec1aIl24oNDxFM7L65BYKlyLD35ivJhZkWlg+jPkcEjc1CxnwlWQwkYRNwnvmJikXp0a3eE+RF/mDoTuAujK71JbpoJ6KI054d/1Gvd3n5sUNRT5p+B3xhXA9xSpg2GnRxz4z3RSrG3QBJoEKJewbTDFbpxkn1Lo3p3zhQSVFtBuvah1QlyZI5JShWJyiz5XQe2fJSexwnm5bgMsYOgtHRUemz30JwrPuiTpoi03l6i3L2PAt1aCJ4q1o5IYIafiZ6hohV2U40UVcFuVyxzOyi0yPWWtWNRe2LMRp+2B192T23HIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKF3aIJDw6pOngsBvz6oUnxUIMFaual0x1to6OhopH4=;
 b=cz/dFH6RM6m3RVqnxwaqaKpDVelQ7s9SN2TQuFn/ZeNjKjMSffJS91mZLpg0f0irgjPRoH4SO/DUWXMQq89FBNSW3fP55eSTQBI9I+PPZLKhF3KfkBW1+nYsAva8UU+Vlf8NYE6R/TDwodC66Zb7lJ4PU4Yc78gnzcigk5FCgPMEvNnYSLIlWz8PO2O07llPGpn5dY4hAhWfFjMKez+7z2b1R2rXMctwv4laMXunV167iihctAOgHNjEbgEXOEJOmTU3GUfRdQ25Wb2+dVUdFbGdhBbbFKSJNcV5VIrXLIjXgMHihjWNjZuQ+Q+9U9jaFmzmUGCAVuyhkSf7utfUvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH0PR03MB5893.namprd03.prod.outlook.com (2603:10b6:510:32::6)
 by DS7PR03MB5510.namprd03.prod.outlook.com (2603:10b6:5:2ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 19:07:50 +0000
Received: from PH0PR03MB5893.namprd03.prod.outlook.com
 ([fe80::d003:bc08:7968:c605]) by PH0PR03MB5893.namprd03.prod.outlook.com
 ([fe80::d003:bc08:7968:c605%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 19:07:50 +0000
From: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@altera.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@altera.com>
Subject: [RESEND][PATCH 1/1] fpga: altera-cvp: Limit driver registration to specific device ID
Date: Thu, 30 Oct 2025 03:05:44 +0800
Message-Id: <0b6877dd7422e8c797bb42bf071fd85cf8a0af09.1761764670.git.kuhanh.murugasen.krishnan@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1761764670.git.kuhanh.murugasen.krishnan@altera.com>
References: <cover.1761764670.git.kuhanh.murugasen.krishnan@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0072.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3a::12) To PH0PR03MB5893.namprd03.prod.outlook.com
 (2603:10b6:510:32::6)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB5893:EE_|DS7PR03MB5510:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ccc054c-f3ab-49d0-44bb-08de171e747a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fMgqGb1VFvkKfbAQVvH4d7ZJonlFJ5cnKX1QD1jMZW3IBDbNFL+jSZ2VnsOT?=
 =?us-ascii?Q?R5f0P6JE6xJtomsygIzZ9Y2TakyRUw3j2CzZUzkhMSmZVIE7yInEjCHWvQuv?=
 =?us-ascii?Q?bgeL06GAKgHcRV8+vGmqHdUsP6IIAE3jpVsE22epe99C635F5sqe4Y45eQfq?=
 =?us-ascii?Q?/I22s18JXimheEPqCURnmczu4rAgn/b0T2jKd1II5/aNPGbXxeLu5yn47aqO?=
 =?us-ascii?Q?GPk/e+5crivM3Z1Wg2qdFKQju6h84az91zi7NtIH6wbW7UwzKGmI0J3TMlys?=
 =?us-ascii?Q?kf0O37DSkIm92vM7KwxwhlDin5vmMZ0b0xEOrhHFAJu0ffXdGBIgYMRFecT/?=
 =?us-ascii?Q?+8t+8Etnzk5wspWhfRhEx26NZDiiVdr5lz7UofW5brbfGJq8ZMZc+JMURvoK?=
 =?us-ascii?Q?SyOyzd8wFqpq2eF8lC5EBtr9c4oG1/w+UZ+JsIwrLugTYtMjjgbkSfUiL5bu?=
 =?us-ascii?Q?KrfRuaZVPbhSDnULRoAEo8vVy9dxvzmUI2MSA7MX2AOScUH5Dgg7IJmTry3o?=
 =?us-ascii?Q?mFIRcMjLpuTV9G7/TvMdZaE0954jkbWrv+ZRfxnR8+TQWMuUa1+HXBSLYHk0?=
 =?us-ascii?Q?6Wz0Nq+ofcW2ySzd+pLwfVhDLk3n11bqqvjKFkXiJ7KCgs9nhIBWeYqxtCi6?=
 =?us-ascii?Q?MJmwwwwy4b9GUO694bhzbOhBsHI2Qy5Jx5u0zQQ8Kk3oFavurt0r+xUwt2pe?=
 =?us-ascii?Q?DUOHCpPKQsQUO7PYfy/JoO0WO8eH8qei1Hl0RxdKT7efyIjfFz3H0tNFJIyZ?=
 =?us-ascii?Q?gSD6ARFUeEdFUaWT/zqY0t5dc51zVThQ62D6PHOGAIVWJxadazxty2ifK0zP?=
 =?us-ascii?Q?VOonm5iqlcvNMv+SNqUi5JtSYe74g9LGgjezk+E6ty1j2ZZYPOwEjcAYE3tg?=
 =?us-ascii?Q?+By+3uEUg3vq201UkBjZc/8AyCxIDvQS6t7uyWTxghRI1YD/CTi4VN1Bq55V?=
 =?us-ascii?Q?yQBv+PIwFmM4OaYq88jpcl+Bk01gZGWHtcRmKO73kT4RhuOxHUUYeyDWXguk?=
 =?us-ascii?Q?fB2a2kCp3JwRHmDwwR3gTEUy3wgFbMR4p7Pm+XHAdCbKoS+BAETglVzcdjeQ?=
 =?us-ascii?Q?5205dK6ValwhPHQQoocR2CAgv853nVaFsz5mKwn5+1vId4k2QOdUXoGiCd0Q?=
 =?us-ascii?Q?nRjD7qbrROj3TQuPIplPJlXuB95UYHQEid7e68Ud5pOSeQGrFN7E6NiJsLe2?=
 =?us-ascii?Q?wG3baDFJdjGYvloMEbIyWde+s5ggsJdg2cOviUggv4LQ0d0BLJ82ZfDvLUF+?=
 =?us-ascii?Q?Fa86tjectb7T5IxvAUiNBWFPHkdo7jmVifeCj6zYq4pptgQEHpK0cADqgai3?=
 =?us-ascii?Q?jhSPO0jGiBFhVd8eM1ZXQL11cbcF31mCciZqAubnUEeh1Eb5sg+4v5UK0MIP?=
 =?us-ascii?Q?QijgOTE8W0pPl2EYqcYu1PeoD69Jhbp3qp19RcaSv5/MCi7X49SmcjFmTqqn?=
 =?us-ascii?Q?9ER2VmCQJGXJRrBD3GkaPtxfM7pg8Beo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB5893.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z7e+Q3Zudx3RGMu0WjH1BjgCPbjNAgaTYqRgk5H8IFMPT/E/H1+jgNDFDlFH?=
 =?us-ascii?Q?Tv81xgsb+ywwftN+pHZ+0UXbpUmd7xqSJMsSwFhSe1LjWE38dy8UhrbERf/4?=
 =?us-ascii?Q?CrwNb+ik4IWn7+g4iHY+R/tH0CSWWw3mqNRziINr9uIQFiMobsSigl3kxkw3?=
 =?us-ascii?Q?nWNpOTPQ8VAkD8vd7qLLL0L1cFZ4w9ClajBH6HAPOSIs/oIAY/PvNs1PVkHQ?=
 =?us-ascii?Q?0kCQ9QO7SvizAI8w57sDNtylp69SSHAXmITSuUVDb1pAVfFyGjD6oJtDnRhL?=
 =?us-ascii?Q?B3aFvtDQ/mIMlx6Q1SYVQE/mHTYQ0z6EPOR8n8bFlrorHFMaMmWtxN9+8MEa?=
 =?us-ascii?Q?N1zTRSrpdydfsrFAfSKggJHEtoziHk/N8GBrFMMMsmw1aHspcAosh0R34CF0?=
 =?us-ascii?Q?gnBn22RPwjHAX8kMJb5SGNxC9hGVwOmk155tTE/y0aNCZ4imb76lLMOXovnS?=
 =?us-ascii?Q?XxUQ7RsQ9mKjFbrZTmaro9TcAjAgpzL1hRxVRStr9jzvHbuJnPyoYd1gomjl?=
 =?us-ascii?Q?m+FVsJaZ5upLEWPv2e7hV819AWl1/rST72o+sIdd8bJ6AZXizV9oW+jBsUOn?=
 =?us-ascii?Q?eHBdOYAXiNU7aK9lC/BKXepvIDZ9sSNWwFX+B6KNKpfTbQ/x7UT0aaEUi7Wv?=
 =?us-ascii?Q?0vayEv3B3Ev+17VZGrIGToyDzl1iID0yGbDZNrUPIyfrWERFV9mUKmYraDEi?=
 =?us-ascii?Q?e7O8w8sOpapJeLtBM86nEVA7/YBiVyPZIrynWeDmVdEZJmnAr/QLw09hBnau?=
 =?us-ascii?Q?riIJk3R5gK+PDTsMtXAXoV6vDjXkyvbKlc+sOUflBceZR1YRQm6uqaoecRXf?=
 =?us-ascii?Q?xDD2G4d58rFeVFn+UZ0lXhFBuMJAiUxrjxqdxlTI2M+bJj1Ye65ZFvbIpgp5?=
 =?us-ascii?Q?cP485GseqMLsPLZUTbKI6ubWcYmUe9stBh6+TB5hCfKbWu0No/guGALa5fMH?=
 =?us-ascii?Q?rH7QBHkkk9HyPNlmO/lp8kYYoh2rjulax9dbtphhXDIyagaMCzHTeUc3f2kC?=
 =?us-ascii?Q?nuChqL9raw+h9Rvmhuh59SU9qkL9DPqFpStURkePsUggLF9LLVqW/6agFMUI?=
 =?us-ascii?Q?VWe2q4f5xWmuzPPUfHohiUwv/3Hs+CqU8qyMj4Wv2pv4wo6tNLKKBwoBb2qU?=
 =?us-ascii?Q?YsVL0VXOEgVHxPr8dubQuPkHQt3u2PqVGtnvIIYhmRM0ttJQw1LnUwaN5ADP?=
 =?us-ascii?Q?MCKx37iXIWLLFRdA5rPNf7ZA0eVIWsUxTwdIGSbfVumZCVObG/PaiGop5OMc?=
 =?us-ascii?Q?tnqzd0xc4cQiRAL6IvrskHSfdYLA8AOb19tG41CA7nWYfnHxegU2Bgv3hf2L?=
 =?us-ascii?Q?VMGG8Y+hwHXduVnocHaGL5TN87M7NzHfnabzX53sZDBPDtFdNNbpY68vZCYa?=
 =?us-ascii?Q?Q4oQQL5x1IVpvCyazBoLkDcFxKXtlhK22p+lwqnM8rhLIHke2qoStCjpPUeF?=
 =?us-ascii?Q?YUdc57JDe5elhRSIhZRxjewkCbIgHvXCSNV63Sx9A0HEA0LbrAHt2n+7gGyT?=
 =?us-ascii?Q?fGsfVUT37vmt3xR8bga0hjlR6Pb3gyL15MvmDoeVWcKk7nOePtcA/jOA3kk4?=
 =?us-ascii?Q?IryfTI8C8DxaML2/qMWNyxbeGi24U+ZLQzPkyTX33EklZsBtb8QwBq7Hjfix?=
 =?us-ascii?Q?ExNbEEwoPZJjOApXZewSlEs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccc054c-f3ab-49d0-44bb-08de171e747a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB5893.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:07:50.7563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzcM0+LCVogykWWe3mkxsJvYyO8rsNKWQsG14W+7XI30E9/chrR8mTSSvejZ/dCPL08ORxyeUNzYuaAGeWstTX2PiUn6F/t5iZjjyuj3lt18NH9842rvagga2z3HIoxK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5510

From: "Murugasen Krishnan, Kuhanh" <kuhanh.murugasen.krishnan@altera.com>

The Altera CvP driver previously used PCI_ANY_ID, which caused it to
bind to all PCIe devices with the Altera vendor ID. This led to
incorrect driver association when multiple PCIe devices with different
device IDs were present on the same platform.

Update the device ID table to use 0x00 instead of PCI_ANY_ID so that
the driver only attaches to the intended device.

Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Ang Tien Sung <tien.sung.ang@altera.com>
Signed-off-by: Murugasen Krishnan, Kuhanh <kuhanh.murugasen.krishnan@altera.com>
---
 drivers/fpga/altera-cvp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 5af0bd33890c..97e9d4d981ad 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -560,7 +560,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 static void altera_cvp_remove(struct pci_dev *pdev);
 
 static struct pci_device_id altera_cvp_id_tbl[] = {
-	{ PCI_VDEVICE(ALTERA, PCI_ANY_ID) },
+	{ PCI_VDEVICE(ALTERA, 0x00) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, altera_cvp_id_tbl);
-- 
2.25.1


