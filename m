Return-Path: <linux-fpga+bounces-1442-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0537C4C2B5
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Nov 2025 08:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 233A74F4B08
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Nov 2025 07:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1875E2E973D;
	Tue, 11 Nov 2025 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="R3/HtJ5d"
X-Original-To: linux-fpga@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012028.outbound.protection.outlook.com [40.93.195.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4582E8B71;
	Tue, 11 Nov 2025 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847340; cv=fail; b=tMVeUUs3Y9FBdkPSpMFUvehnfCkmlpEo7Nvv9XSsFQ7UVWL7jYRdaKkgEbC82hGGuAaUeTKTw0fh1i+4/89O53h/QMyGcXOUQI5fIeRXb1qv4qkTgh2LupzWonLsfCbyK63wMm81IXoJfq/8bbO01mxm361+VfuMloCvUm9nhz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847340; c=relaxed/simple;
	bh=rpFZce/4sEzLT21IiIUmh9JL4w4h8PoPU+jFUs+fwus=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uLFzdrycYx7tv8eUv1vxDLKhLkWhm/bE7icpru+hbh6FN3NEOHnmrNWfbFuDf4saz4QCEg6INTuIaT1Q43RNg98QB5Al2kkPea56CcgKyRkG5MgsAunNeTdnE1hRKkPZ/7AfYQ6FQ5ZOdocxjjxK4paMJFEObag5OxmmUdwtieA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=R3/HtJ5d; arc=fail smtp.client-ip=40.93.195.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlmxlmvlP+0ytf48eM68FnrIeKNnuGxTfLzASfSAwxOTGhOTdO9TPf4JCwlilTGgyQmvpjPXPKRUIutcq8OxeMAINomLZhuULn1a47aJquAwQrObLWLBLcDioKzzrSip4vw+q9Shl4lYq3FyBxrUbHWoANq973UUkQEpaVEz4NK4j2OXAz7HaaLlCzdmd5pSC+rx4TBvsvwVs5FL9qxqKEIF09wPpDcVdFjx6uM8NZ2To9OswxqjR3QAq6wMR2HmwZWCvnAJ2EH8iSxJaQu3oo1xHYWXv2qlONRaxZbYwtFCd2jY6GlY0WYqtwrxvHLMLKjre8wv4JzyygCRIkjOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zu/fFjgfXN/zQsqLkZEKHFBiaXRAPG/LL6nkSBtzOR4=;
 b=N8V+1P565xuS0g08OfPIPzVJF5RxCgqPnYz1C22CYwlVJxBXKFISufSArHnbmhdjtO3EsAE2uad1gMwyHQqGyJPdv2nQ1LTE4xZymHzNvBrVV2I68z6rW/4MBfjp+0w8UUcFXHnpyGRkGihwmfa79eWV0UtjB80dOjsk1R6JLPBY5c1aa/1O11qDCK74oTCZf9yeZ+eCGtvhxuR1ioWZHZK7gr7Uk/fGpG99haS9TkoV7NAqebevgQvQIWw5hOZNDlVSQxobdDrqSVJhkD9BT8D0AcLwMv2GSelJAB7q7Q6TNE3fIU8NN8HisycGkw/h50ZEleVFglQgsZTq4F2hLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu/fFjgfXN/zQsqLkZEKHFBiaXRAPG/LL6nkSBtzOR4=;
 b=R3/HtJ5dIBEToYkiW+2g2jJPMiIeBx7ELLNe4DQSdhfSW02hW3IUrtVSWI3gbBQd6AAs1AadpmIM+tCFA312Xoqq7fuwGdudkzS1j45VdMjHGd8rGKF6x3MHpLGlo9QxackavD011vHc8A0tvJhSAe13vZBUFYLDR782a5VLCff974Qwe3zIZRMonNpfblZm7vIcZChg9UI/G+8ZtFqQAVt0Zo9C2fuWuxb/9b2qydARqtZJamfriwTeW4clXu0aHHn5ioo/jNcx+d2LEc33yUT1kS6TYDzPbJDyzOJ+65VXNhgll8UGvNvPFuTDPDVIEG3fgFOUgdUJCRxhGZxPXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by CY1PR03MB8124.namprd03.prod.outlook.com (2603:10b6:930:105::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:48:56 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9298.012; Tue, 11 Nov 2025
 07:48:56 +0000
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
Subject: [PATCH 3/3] arm64: dts: agilex5: add fpga-region and fpga-mgr nodes
Date: Tue, 11 Nov 2025 15:48:33 +0800
Message-ID: <6fc26f2a847a40d070bc1d24d4b7a99450009e67.1762843803.git.khairul.anuar.romli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: e48ad62c-9f50-4775-f575-08de20f6c424
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m2kb9XvFuQ33/M0h8raXtClgqYZOzm4kySJgv8kAsKq9I/wxHi9LlImA68bI?=
 =?us-ascii?Q?Kwf04mS5t7OczgioNndo4F0lvNUdX19H8o+V556qJmnFJoWoDKLxSByzJec6?=
 =?us-ascii?Q?H4tXBb9EWq3Z4qIeA0mXC9D81P4LzKp8cBWkIsLzH6k7QwuQdceOCs1VlbqK?=
 =?us-ascii?Q?l9qO7mouCAsiEpolBvOazbA4hSiT3pV0o4wevwf6yPHp5p5pM5l6YjzgJ0iz?=
 =?us-ascii?Q?OtbmMNNFvLQUwCpAJvqwFeFIRst5NZsq2IEtvBijYFDkOEagD0LM/eE5qZXV?=
 =?us-ascii?Q?1co2BCGwLu7tiR3QQAfrBgc88oWRuKG282YcYcagJgYqtZ8Q9SZpD5yF0cAc?=
 =?us-ascii?Q?aW2qZOJc+TqPjp28zUwuXOCKQUnORPnDengj1OsY/VqRsHLE4cHknFUPj7k1?=
 =?us-ascii?Q?v9PokTwWgcsoTRS3TEgEPafjEFtG59JxE1Xo9vkE0znxpN4HnRB2ZJwtqDwQ?=
 =?us-ascii?Q?q5fxI+sqqiAFA6D4J+YTapplQIRGwt81WlS++//SImuJfrZ28E8pp0mcpHFk?=
 =?us-ascii?Q?vLgu12iRwP3RDi3n9bCUX8PM//PicT17IQzahM0mgfiat33Y/LBPmpp9ns6n?=
 =?us-ascii?Q?Gb5tkk6s9WPdTbvFyJT2NfRryVY+MujorgEpdbz/J444DKVbNAS+Pnn+7oiL?=
 =?us-ascii?Q?wl+M4x41Y/f5UBDUuVf+MbM170SNwc3nmnW5dXPLcWfxFQlJINUMJSlaoh00?=
 =?us-ascii?Q?UxBE1jxrM/CigLWd9T/sPoUKmt22+yMPasIAljyftLR8zBx6bI8zPJWJhMcH?=
 =?us-ascii?Q?u0kJME78Iwgy8vQa+GMFGvJmSVF6L99fnSqrENIkHHI27ampTFGRP3c2j/Um?=
 =?us-ascii?Q?CT0n/6L3lCpizTRJ72DArW/Foi/03PFS7byHIY6fCWLDKmH1Y9BjLMPC0HmB?=
 =?us-ascii?Q?oqic/w0ps71fL/nR1Z/HjROc0jVvnRXMbfuybESMgwHmqd7taOOeVkMmd4c9?=
 =?us-ascii?Q?coYAk9Dwcb7CZzpYenj/wbvC+ikMJMcN2mKRMF4is4475IiNhK3S5udtmDJZ?=
 =?us-ascii?Q?1oTYihFoAhmueQGsAFr5yzvzipRA1jxeZ755+XANeuCLiDHUgZkdWsqqPqFw?=
 =?us-ascii?Q?8TbQ7+FIaEEBOF4aUelEzie91Lg/vdabJjqjLQkdyell0aDtAoBJS9x3oElK?=
 =?us-ascii?Q?+zNN5ZlzbzMMBmuilCbmtCaL+XfnwmAPa0lm+QFa2KUkqjT4StGGtyC3Atj0?=
 =?us-ascii?Q?NpYHsVIBP3Fwz3XPj/qPTAyanioQbApgJFN3CP5ieydxBFKWH9MLVDssaYb/?=
 =?us-ascii?Q?GUAACrfsIpzqx9vBrOs6/h7rQrqlrmIJDiS9tdV5YHvBhQCHl4h++IlcLKkr?=
 =?us-ascii?Q?3lZNo7WgeWYCzLXh9n2s2AO5PAVr/2HaAN6ywRlafnsjsmtRlJc3o6XBtM7I?=
 =?us-ascii?Q?V3QEN514aya5K7mPFvNapuSD0/DkNQUPDyhXM1JW2lI/QgqcI7zGUIITsbzc?=
 =?us-ascii?Q?S8oDpH0ckQWibY4BkTlAg5GZ0vAvtFBS7JO0CobVSVoHl77cXt4EQMaI7GK+?=
 =?us-ascii?Q?3zUhw/raZFGa98c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kJUA7SQxpUcT26gXJ0YeTUIqnQ4WVdciupVM2AX07ZfRjMB5DoLrfEgRq3CU?=
 =?us-ascii?Q?XX/BSpslCSCNIDx3l/YplZ/VB3/PYweNv0faW10Ub6cPCAYM/rC9V+U7AWua?=
 =?us-ascii?Q?XrPCVjDbjWXljdSuZtu9s9rSTPt/ZipZ1xz6ifyc2g49TObsnk+xNnBGzvuq?=
 =?us-ascii?Q?8joVkvMUzrR5iYdZIr+2elmxwzUtD4Gl+3wiLfhMrpVGQZoDJDTQxYLFCJiD?=
 =?us-ascii?Q?sSjYNrbDILHwMxF1jnAyBNyRo/Spwt7VYLvmmqGAfo9IYE9UMeJITBL/y75v?=
 =?us-ascii?Q?k4909SDr6IWv9/htBi86/LcnBuxtD8kfXrnFG8xlA8tvkPCZIyZjXCS3kAaE?=
 =?us-ascii?Q?Qkn3Bv95blyH+0qwdWDR+0BST0aOw4kIKpu9UeJ+5pIP6mh/zIBmwRWDs6NI?=
 =?us-ascii?Q?vKf9gz9wVOkEpFxKnJDY7MHet/xyGwQ/tPq34JNmB2t2QAmYWT6ANmpKa6yR?=
 =?us-ascii?Q?UomRpE0kb0qaJzrTGXc6C12t0h1cx2A+e7Ajw9Dz27LpIdVyYc8+xk3cLQ5w?=
 =?us-ascii?Q?NhOuXYcvRp8jRe2OjnTEka6i1zbwjwB/o6OHRWOZUbucIAR2qjq6BLYJYW7F?=
 =?us-ascii?Q?f/V5vn+8y+rEJOhg1LwELPpUCZl0mR1p5nWa0uoPYc22eYqY0VeBg7omkZED?=
 =?us-ascii?Q?Lq/bTys+wPs2bdHdN4How6E7fC7ynReKejuXvlxBWRd9c9N/4KE5Ss4Gfegg?=
 =?us-ascii?Q?S+HSdFIaeuxkgJN3TA8JcqHLwDBCBzUrH+Vz6/gNt7peiTiPZQuK3xFZXia8?=
 =?us-ascii?Q?tuElEQGA03tytv3SIBSfw1ECi27svqtpXEcttlJfucnXJPOzk/RkfnJ13OIb?=
 =?us-ascii?Q?wwKxRelYCGIpQQDVaqA9wUrYzEQ/+w46Ma7HI3BsRaprmhl0GV9Xh9EntaDV?=
 =?us-ascii?Q?Hb93WqXq3RQWj9UTGKxLBSl2SnTe0P0Xcbj+dI5OycdgloH7ix8NtdTCdkMP?=
 =?us-ascii?Q?EnkXRsrT+SRRQ/jivJMzmgJQRDVaIetUFqqzPkE0SsVeAYaWeE4d2TR0Xgkz?=
 =?us-ascii?Q?oTh4mNFdvh/MS/ibpYLjMQ0MgIhML4NIox2gRNsa6ssXT906Zsl1qyi9EGuJ?=
 =?us-ascii?Q?jn7uWPXaweRd9nlGDl9ALOyURF7ici5KgL0xtjikO/UXyGHVevk4YtaIdTdQ?=
 =?us-ascii?Q?sLJCF7CSVFjW6zypPupxvpAOC2S3rOUwOvbxl5E+BxnkeZ+/8WDdaw1xWZTH?=
 =?us-ascii?Q?K/r5EmunUVu/BoorRIo94cVCjUoeU3silbEo4ALlONG6uHTa9kXTSKAi9wav?=
 =?us-ascii?Q?5jct7XNTHGeSbK+5AwR9mx1YzDsXBqIDcBcHdPbj1r53RGTDgZwI7OO2CTma?=
 =?us-ascii?Q?PHK03KKKV4rC63zQ64d4QjUM1C2qmG7h8JDq/vkGhizLnp8jq9+UNu4qufwa?=
 =?us-ascii?Q?sguM6vIv24916k7DaIoHqB9r0RZerBPZ1kqK80XMok1pQO4qdn67XIWfOaBw?=
 =?us-ascii?Q?hq3J/NuLUWRF4TS+QSfsNvuIPmxSI5WTZ+2nHq4cHSjNvmtg7rlDniDyn9/B?=
 =?us-ascii?Q?AbzJ8399TTG2yazupAIQ74JEOAVx9R2SbhwEjX0rWzODNuC9cETePlNjWVFy?=
 =?us-ascii?Q?8MM77yKrkxuuwGu5zP8a5UpvCijZtleiohy0180711+sJgrUoR0/gM8oEh0d?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48ad62c-9f50-4775-f575-08de20f6c424
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:48:56.1920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHnduYUdHMIySyNSXzWjnivpXhBcT/IHlnJ/khSUQDn1EgNrCXLQaeKi6uxh40/KvIX+cGMh52VN9PtXaFgm75D9xy4Xby7j7A1EU0Bc3wI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB8124

The Intel Agilex 5 SoC contains a programmable FPGA region that requires
proper device tree description to enable FPGA manager support in the
Linux kernel. Without the 'fpga-region' and 'fpga-mgr' nodes, the
kernel cannot detect or manage the FPGA hardware correctly.

This patch adds a 'fpga-region' node with compatible = "fpga-region",
along with appropriate #address-cells and #size-cells properties, to
describe the FPGA region layout.

It also defines the 'fpga_mgr' node with compatible =
"intel,agilex5-soc-fpga-mgr" and links it from the 'fpga-region' node
via the 'fpga-mgr' property.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index bf7128adddde..10dd8ec641cc 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -85,9 +85,20 @@ svc {
 			method = "smc";
 			memory-region = <&service_reserved>;
 			iommus = <&smmu 10>;
+
+			fpga_mgr: fpga-mgr {
+				compatible = "intel,agilex5-soc-fpga-mgr";
+			};
 		};
 	};
 
+	fpga-region {
+		compatible = "fpga-region";
+		#address-cells = <0x2>;
+		#size-cells = <0x2>;
+		fpga-mgr = <&fpga_mgr>;
+	};
+
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
-- 
2.43.7


