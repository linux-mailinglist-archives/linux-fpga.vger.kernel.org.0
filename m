Return-Path: <linux-fpga+bounces-1395-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227FBC1CD8D
	for <lists+linux-fpga@lfdr.de>; Wed, 29 Oct 2025 19:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1E91886312
	for <lists+linux-fpga@lfdr.de>; Wed, 29 Oct 2025 18:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BB1357A47;
	Wed, 29 Oct 2025 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="wik6Rjzf"
X-Original-To: linux-fpga@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C06E357738;
	Wed, 29 Oct 2025 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764167; cv=fail; b=fz93+B6kC/fg/H1JwC568Uo2/H+r1YKFLexlT+oZZ+0WhaA0XCqFKMIoIm12UBve56xAs+VsFcH1O6NtZ2iGDVNv6bzNp5GEw6IdjgFYfQXlAUJQtCYI/Dk+F0hTzNZwhX+Y3qbrrazdneH/sTSUrNL8OsNXZ8mhl/H1R9ftDpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764167; c=relaxed/simple;
	bh=ZWtsT6XrgnfdkqUAk60oDi+7PnG6fv11BhpcjlPhal8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n7KHJfEBoCygvZBSX4cS6lcnF2D4BYNuZJfgUjzxul4azUSVeeGfO01Uo193k2POIgvLp3v4sEiYXk+tsy9IeTem+RgtYIjQZfm/yiDby7bx8poIaS2+wfc9TkxDqqrZP9MMqOGtE9ARtJZBAaQpldItTCKMAMi1Rv2C4rHTTow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=wik6Rjzf; arc=fail smtp.client-ip=40.107.208.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSqg0bJL4imZ22gWNaSi/F5i5Cdnzn8U7fcQk2X/iOBBqYEUsm0GMaqNDOV/DrZTyhDorPv/lBJ7MM2H0GE0RTDVrt7LvTSBfizCq57s49sHgyuxETaGRF/Vqp3ZZpn97Nb12PvWPbZ17O52nEyD2y8nJ4uBtMM5tycKlOxgTo/lAc1tfmPzH9qUXHV31mFvFYnZR6piFG+PRL/LQvxeYmWD3mu6etmfDusuEFknQgGWPC+CbuaJVDdRzUhVO5I0xVwBB0B4hzwEWf7xIWXU1rGsjeYpU1Dx2fpfwUbU+Lg9GB8Di1SN3aTi/CVV/g3ZxoStLy94Ot3vAjW1kukuCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dgSKI8yEg0n2Fa9dYg3cp72XL2ReQlw8zfkKAcQdB0=;
 b=hSluh3jC6eQbT2XwZESQeyuUk7lewdFLZ0LUSq2GP7eDvRs5eacApFYxfXe/uAq1r50UGJiR+KylR4Idw1sYZqgOEsqdPqAqDjXMNzzj5OhDW1ER+JgYX6BGOYq2+cfq6UvbbY5gkII1PmJ/3lV8hAQov1idFTx7xLkB4ONTwt3D4mbdMlrURthMbKvDYFnMVU5/zwISLzk/qFqxVRk0Sq+Wd5mS9kOs+THV0TXF0XUqmsR496E91Vrgk3G1rQkZpncAkiUcHAMBTD2mMs4IqfOzitK+ZmhmM1OD24t68hOI1ECQPLPHaKW7dSvJ6VI5qnieiNoV3IQa9pTF3scOrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dgSKI8yEg0n2Fa9dYg3cp72XL2ReQlw8zfkKAcQdB0=;
 b=wik6RjzfAbBXFwfGowGL9kQjQKWCUniJroKgaiRRGwqz7eaX7xEkY8vIPU1kw3PppFE0vsoGtkhNZxA/Av8ZSwcRolV3e9Y7DmRPG4yPlvUr4wua534ximyKSiiiKL2EwoJ8aHffsGOkYRIlGPvl6x73Bbd1uOZitI/N0QQLlQcR3vG/axPvp3S8/QJS/4CQcG04xQUcJxiRRsADn7/ZixiifUUWBTNQq8Bg7Inl8z9vmdLGpds8v89gasOL35UA6q/JFo1M/EXDwBnnFSHZjQ3M3bFMuW1lB8cmLXferOXesR9iMp5sJOr4HVjvJQFsIM6T9o7FPldYfFSnxePysA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH0PR03MB5893.namprd03.prod.outlook.com (2603:10b6:510:32::6)
 by SN7PR03MB7155.namprd03.prod.outlook.com (2603:10b6:806:359::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 18:56:02 +0000
Received: from PH0PR03MB5893.namprd03.prod.outlook.com
 ([fe80::d003:bc08:7968:c605]) by PH0PR03MB5893.namprd03.prod.outlook.com
 ([fe80::d003:bc08:7968:c605%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 18:56:02 +0000
From: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@altera.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@altera.com>
Subject: [PATCH 1/1] fpga: altera-cvp: Limit driver registration to specific device ID
Date: Thu, 30 Oct 2025 02:53:54 +0800
Message-Id: <5a309582f52f1a8bb193b1a2fcf7a7d0ad9b3b27.1761722521.git.kuhanh.murugasen.krishnan@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1761722521.git.kuhanh.murugasen.krishnan@altera.com>
References: <cover.1761722521.git.kuhanh.murugasen.krishnan@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:820::22) To PH0PR03MB5893.namprd03.prod.outlook.com
 (2603:10b6:510:32::6)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB5893:EE_|SN7PR03MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: ead4b587-ec38-4023-eb3e-08de171ccdfd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r0i2NGq8jq+CGkAK+NHCZBjR0UmSsl3Sd5+Nx05e/qiGvsBSUDzSmFKYFVSj?=
 =?us-ascii?Q?NTa9ypxHqKL6u6XA5Pa9zv6AyrcjTCFaVXilNzMxGkjm2m/tVLRqUS2J96ZS?=
 =?us-ascii?Q?Ymf3DpaBW4KGzZhHLAtMIVz/x4gC4ecWbr9eSfwcuOPoJoDFnj0m+NFu1X1X?=
 =?us-ascii?Q?pccqxTHINgNGgfqhREVasDPRo/P3MHVCX0t0abBUEA3coPLtwTyM3jXvK1Pt?=
 =?us-ascii?Q?kiuP+qmgAaYWbldbHTyumvUsgugbTywSW5Lv3kSXrg7lA9RWG7Ckfx6dEOYN?=
 =?us-ascii?Q?P720nZCeFz5P2TJtiQ4Z2Sn64q+MG1Bb8d3WsqKXP/LmOfkX2Rsfd/Wwg/Jd?=
 =?us-ascii?Q?v5tXj3GcwnbD4sJW0AxGJcqW8eKIJo8cySHs+NWrzGfVWDzS7lWHinxXdpIq?=
 =?us-ascii?Q?gaqFU6nGoX2YuslrqgeDuOaLbiQtDCId/ftB98cx8p8/KTHt2xjFWMmt75qv?=
 =?us-ascii?Q?WkmCZqcyhwSRaS2/9TJs3IIsghoT2HVeWAjccuBPLtMIerqrK0bwtAqnDtSD?=
 =?us-ascii?Q?A4aP65whR+eP7hayZ4HZnIEazfdulfqC60GAmnk+BEenyB69ACoH6Lu11FZA?=
 =?us-ascii?Q?3kCD8qn/ymfE7zaRCA/tl/8rP4rmnLu9s/0q7TintmnxB2calBnloxIOE/HE?=
 =?us-ascii?Q?BRRoYf03Ojo9J74p2SDKCKcoCBgfdJw7MmTi8vawfYDW282Ui1AuqBIEAu2Z?=
 =?us-ascii?Q?V0GYLrjpwzCpr6tn7btM4fl+/fXBxSwbqa/R1hJJTbpJHkzDnFMHVj9FLrQK?=
 =?us-ascii?Q?6CeXvw2ToAEIjHvTC8LCf4HkVUGtej9Bgg7EqB1qVgJiFq4DUCG4cK4QkUg8?=
 =?us-ascii?Q?YpKgLg78BZt86uAtKpl7vmgcCgiqaLdC+F1jiR9YtWiQrRFfcqX8dV5JF552?=
 =?us-ascii?Q?LfEKV/+7AxkWwRLwW94jDAvgdEEZVyMBSZsXmjt0+TYcpimHe74PhTq/+zhF?=
 =?us-ascii?Q?lZ5L/Jno57LVsQgPLWbq0HgacdoCmLnSEkP/sl14LLWo4TJaYWqVnTGpPPuU?=
 =?us-ascii?Q?lRlt40xiicPiikx2P1M4tp1JwBYGPNO83jRLCVCP2UidYEhp2WJF4m8MFg5Q?=
 =?us-ascii?Q?rLL/oDbHkhGtsMsmn87L/B7hJo9YTv346x188kOCUAjrPKkoxGBLcAbzV54D?=
 =?us-ascii?Q?vzP64jg9xI6Ru2a6ArKi68fdpZcPo1za9ihJAeXgqrrM9/Tu0NG3iBgoFfz+?=
 =?us-ascii?Q?KAlFi5HUwc33pbfmM6zXWDbTaupVqP4qcnchFhADkX2pf5ufa0oi14rNcDRW?=
 =?us-ascii?Q?8ysiY2V1vDX0dn5JKXrkIaXLu2T3U9AybvAjvvSwwv1IZR9mOzmTtu3NnKTR?=
 =?us-ascii?Q?MjsMeFvJRGfaNt83zvLgPCCW4sBmm8+FjpW0MN7MNGe+lNN8aowhZ2eS/CL7?=
 =?us-ascii?Q?7wJzBN7tpaP9Y0XeCnzXYtIK4NSpUShb/Q8/usIZqyqLVxEpU6wnNNt0U3P5?=
 =?us-ascii?Q?wCJ/mvDZxe90MjgJL/HAByMlwYrjoXlZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB5893.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x87hIMw5mMChv7kuwINXNYwDKeErmq0QvwTaAELz+joGkgE8NPcjnKIZiZYf?=
 =?us-ascii?Q?WKjgRM2JZt425XwblFGLBGV8FRW5J/5gVtM3eISNdtPyVYSnXSqC7LOnwsHP?=
 =?us-ascii?Q?LNaIVW2ytzTh67KRO1qJZAdwRgamfCFSFiQC1y+62XCI98N6O7BBRfURv/9O?=
 =?us-ascii?Q?ztY+EF9zMihKYkpN2qqmHQalx4NN5zjJ1SKkakXlnvprKUkQLVKVHJGZ19rp?=
 =?us-ascii?Q?WESwC+prP07NcA+ksVaVpQ8AMBEa3f3qH/V7DModkX8iVZ/TpGAOuZlP6I4R?=
 =?us-ascii?Q?qiBXiHKlbD0Y/5fAuDM+XkIf+I28Hhz1KvKpw9Tk/3tu7ZFlJl73GJYyKYjN?=
 =?us-ascii?Q?rKTe0nhaHKvpWPtod6+95wg3pa9CobAxNQwa2txPvYGyXalEk2SdxGNPblPc?=
 =?us-ascii?Q?H6ISYnFVCQazoV9bagcGWIH7kyjBkpxC/UA3QFFVFH1bKScyBZN7yi2gvduV?=
 =?us-ascii?Q?F9x0ccM3/kmXLdBFc9wDDihlG1Sq9QcHFp0AbfLKGFpH5ZbhefT5YFJ8S6nl?=
 =?us-ascii?Q?mSNqPELdzczjRx6UML44QX4BzMkTqk4yNTIYe6s4G2GuDqFZmPUAphIFz3hc?=
 =?us-ascii?Q?IH2qNDuKizVnVY5gBV5di7gewNbo8ojF3HY/gTaJrYTw+4prSCSJJgyOKBhg?=
 =?us-ascii?Q?/k3GM8XS4cDGrkeayLjKq4YWL38cVUZFrmpgr40LJoHdlwBOfhAubRH91JSK?=
 =?us-ascii?Q?cQyfJTtHzcfE41jG6FaiUkzYvKsMsUSkMU4xz8QH2vTmDYNAJ626Gv7ZAvoQ?=
 =?us-ascii?Q?c2jkopgJ51DnEHSAExWhz8q91JnsixO0I5UshJ7mr5v0FxhPdXnYKFUT32Ee?=
 =?us-ascii?Q?ImXIxcuyLSss2Eb8d3mWVdDP3784EoV3kuiPz6FAPJxJZrkVp31uF9r+DPHr?=
 =?us-ascii?Q?PdlJxq/J/DzPfeldcLqfPpaOLvQTbXlmcDxSx2a/BrDERZcmprl5me5l1YG5?=
 =?us-ascii?Q?eYRmdbluYCIXgEbmbQpwHOdQ1OYGlLic/7HuarQt98wJHOP1L2YRnli1RdHv?=
 =?us-ascii?Q?E/iS0nqZq8uizgx9jOS0ewMbNrRPzo83GiQ6Fz54TqKkpekSgDthh2FWhxS8?=
 =?us-ascii?Q?WJeDff4zHlWAjnhvJ9HnqpYMPRE7NRTeyT6IgYNNdvk42ftUO/FwQW3Jbg0Q?=
 =?us-ascii?Q?vMtC46sxd6zSaO1oVncgafhhAQefltzcwLTLc5mm5zbJkQR9r8qYuGO1pqrY?=
 =?us-ascii?Q?EOVfH0TUU2Pr6Y41AwtVbztqAGdu6sGqhhQW/Uwe4wThU3EJQCc3ikoaq4PE?=
 =?us-ascii?Q?LLIVTW8rRll1pTUA6wjdzu8m7QiCO5D+x5IL1TZFZ/vgyKou1aP3l+P2/ohL?=
 =?us-ascii?Q?8/wkU8iBNGEcpoOpu1JCCI4yeXjTFZICUdPYZsjYzX0A1YYhxaoboWCQ8FaR?=
 =?us-ascii?Q?3sLBwXUDFQA8MGfD94uFb652H+mBTT3AK/2GHm7K6tj5lim4yuYwqQo8CXyK?=
 =?us-ascii?Q?0MdzlmOJ9QJTwiLq/y1FSzvTozXFxoAOBihs3IB9FgSw+XcVrvE88vh92/fr?=
 =?us-ascii?Q?sODFx/DhVvUZWf7gWJdDFCCjRVEJJy1LPGtLRSGBUdFYq3CLO3lorNSPhZUl?=
 =?us-ascii?Q?rmmivvl9D5idn3rtp9T6xSk2jq5VeaiayNCRgpN/YSfUaaiOOjYr0YAvgtmr?=
 =?us-ascii?Q?NvHunrjGFznB9zkdN2GOBXw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead4b587-ec38-4023-eb3e-08de171ccdfd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB5893.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 18:56:02.1113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e50A43v6HUkg4LGsx+FWuPRHcCL8Y1CJ4IUqXf63AfsG/+t8eolcSKDCCxgxmCPxJQpuwAWtf4eaU2ckVQceyONvdiAttdoBl9DmpTHZNMvVsfeggUagVKlO6SZpDDVp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7155

From: "Murugasen Krishnan, Kuhanh" <kuhanh.murugasen.krishnan@altera.com>

The Altera CvP driver previously used PCI_ANY_ID, which caused it to
bind to all PCIe devices with the Altera vendor ID. This led to
incorrect driver association when multiple PCIe devices with different
device IDs were present on the same platform.

Update the device ID table to use 0x00 instead of PCI_ANY_ID so that
the driver only attaches to the intended device.

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


