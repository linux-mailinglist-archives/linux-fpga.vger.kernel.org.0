Return-Path: <linux-fpga+bounces-1440-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C4FC4C296
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Nov 2025 08:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 717A74F242C
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Nov 2025 07:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EBA2BE059;
	Tue, 11 Nov 2025 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="fW7e3GTO"
X-Original-To: linux-fpga@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3581B2BDC10;
	Tue, 11 Nov 2025 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847331; cv=fail; b=okFd4zKQYRdgvzpLI+UnDoAm+32yrJd8feCS9jjFHAHW5np+mYwUQwaFowfCDyYlVTPJOiOTXqZWPU7NDQ+exS1ORaLkUaQLyXFtQu0w64fAX5it7eAVyNSr/UtNDDIx1ls6Sw767HU1YpDNB7evY/SkuLoUYRyUNADO1JYT1Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847331; c=relaxed/simple;
	bh=1gHCqOCk6yrIuXXsNgZc0Ap1lmbDDWE9Ew+jK+TsA44=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B0X8VsuAACRrNgitiyEGTvjhGieJE0kND8mdBZPzjzMCQPrm9WtUbCBf80xHxAGCdHBBZ8Aqrs9sMkH6tMWmGE2Dcgd+EYFzyk/lEkA/YV18UmpSEwvKL/jPJgyq5ns1Xt+Tijh9ihDucSIrKIVH1NqtWw0IhQGbOnBoz3zhp0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=fW7e3GTO; arc=fail smtp.client-ip=52.101.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xj048gfb8vhdpIn5ByNkwOiEZfWzRVf5VJy4QoHbpBPSOfCrb55bd9Kj5FbS5qQYDFOyhhmqUNGYL+w2hFzPwU1idTBK8C1Bjdj/fiqE/Rio2SKgcUidPu8FebegvHCUQoEWnVFq8EJtpRNPuUuwB5dqG8U5z38vYWoNgqw3jJf8Cq5gdoQ7XG8EkT++vqnrv+OqcX8mbbzs8RWbebJlae41SGGD7Hp28Jw6/AyxUEddXmXepGouliKZeztMonAk91nO3OkH27kufE7AJLsRBSbNmhRTaxESDx+1VdoPJq+l5wc580nNpehN7SJh0Znr6pn578nYcR28CP7Ji2YuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSNHlj4/LliZxsohUoJUDw2x7Sgnr7YiIqT1iDahQvs=;
 b=YjEW9wHFa5xkhrysb34tFJnSlPUb768sxeIswABfEhsD0kWcBtRqIwIdIhip+HKI4GmHN78iNnj/aM4lWYejg16F0E/qhzMYKjpMlkAdJiuZGqgKTz0ZKf/7UngSNwk3SvDywBJiXw2PQFk9+wah87kJuG/7ECv717yR1MQZsyIIyGAGBm8iWOs6x/ug0WLtn+uSKe5zH1Pob1/zRw7/euYnnIu6SmaHVa6VwZHnuh8kj4ZCTqn4xFbKKf5Qyl9+3XGlq0mmkGWX5cZOfA3nboR5aB5QWy1RjovemvKTSmdeNHppFGeEDaE2t8YOXhUERumApQE2RtYNB0Y4Ajz3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSNHlj4/LliZxsohUoJUDw2x7Sgnr7YiIqT1iDahQvs=;
 b=fW7e3GTO/9yvlalMk54M02fSgeP/Bhr24sAcy3HOsOLzw+p98wuuov6jWg6VJCD2wj5DSBG58HJU2hO4vqSEfFPsoz+Ak3f22ZuIRrTFJDlYxs0ugAfbc474u3vDqco2GKnweAV10osawdwunUBuVAgDUK8uYTLJEDuhyWGLKkYw6agOdOPoLgl0iAvdE57AKVfPAluXz2xmhSiedKvku+pyQIpe0an0M24xsdUgXA392fdxQ7W2MhC1hTdd+5HvMXg7c6yVk0SXvlYX6xmi2b6r3clBv9P1rGvJQp05VL86BErsx1NGXzQaIYr2K7ZBf9jmNNOuXZd6GilLiJGPUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by CY1PR03MB8124.namprd03.prod.outlook.com (2603:10b6:930:105::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:48:46 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9298.012; Tue, 11 Nov 2025
 07:48:46 +0000
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
Subject: [PATCH 1/3] dt-bindings: fpga: stratix10: add support for Agilex5
Date: Tue, 11 Nov 2025 15:48:31 +0800
Message-ID: <0e3986dd9a2c4e46466a7430b2573d170d2a718a.1762835252.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1762835252.git.khairul.anuar.romli@altera.com>
References: <cover.1762835252.git.khairul.anuar.romli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 68043def-372d-44b1-d31e-08de20f6be34
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fx7deNuqeSMav1RGL7HMWKKeimeagvjeGYKN7wR4tMWl72SemupNKtJf/T+j?=
 =?us-ascii?Q?5YN1SKRuEi/J3bXyYNm7d+sJRvG1ec1ntcL5MG96evtiIN/i82tW8X41PM/D?=
 =?us-ascii?Q?Ui9Ln4CPoiG3IRRrqqIUl+2sFG6GX+7DghcsbtTt/DK79G8IHPyu1r729QIA?=
 =?us-ascii?Q?fCImd6T5Bem2gLpkP1bIKWzXD+H0AO9fpk3fpLwAnSjlchw4y34kJIb5BmZX?=
 =?us-ascii?Q?3/N7NfcHrgMWloB0729w4i+7nbTiaEBVpTvj/ScDgkk3x9rPSSbABAjYGhvn?=
 =?us-ascii?Q?fAh9MansMWJDBePxnRzH7bfODVhqF/44EBKaXnTUiQrCH57dg9AqUzA+MceQ?=
 =?us-ascii?Q?weBo7nZ9HlMiaoldRUf/Z4C5PSAFhlZymzHHYryBJ6QVQ6iGmdHCZZtFG6ti?=
 =?us-ascii?Q?+z7xevLafCi55YDmch1oKPM2GeZPT5UnL5mk7w65p4OkEz0SEgmAxUHBpKgm?=
 =?us-ascii?Q?qQ/NKlUVFv9ttvsGxsYuSNqjdUVGrSFl/B2sV0Jyic3uODFUYkh/MD/9rWSO?=
 =?us-ascii?Q?g/t4W4u+olLpuRVfczK0itsqlmo/3M2TD80b5rwyHXdkcY6MKQD4nAIuOHkC?=
 =?us-ascii?Q?M1H+pFtR1WqcrzWD0Gf2dq5hQsl6gEcX/143qH6bVRqnwaF64r1bTA6Msdzm?=
 =?us-ascii?Q?YhEwG5hh/bd6wLdwLU+ikPRloRbC3+zp/k/29oaa4e6D1LglUZrkjbbkyI4x?=
 =?us-ascii?Q?bFsPbtyOxeuyl+TRjpPbLNJzh6MfTI46lqO44BovkLJ6UywPEn9fbETcFf9U?=
 =?us-ascii?Q?EKLEYE73dG1dE/cVxRsqJvgjqhNR0ZEKxeyYcQhYLpAkqL3TIzsddwFoxR3r?=
 =?us-ascii?Q?39ib53Q4VxE++GR4E5/VD0+gIQ7gwuOH3C8FAR/qKOKreq8Yu7d6UVJUWHsO?=
 =?us-ascii?Q?qUGP2KFY5j9T8qXubIuAfvsGwy/UHBW/pcluRLd4bnIp5sTofrYyfr5Zwp+K?=
 =?us-ascii?Q?D09lWDAQkta1u5I1XhPya0t0y+Ow5T3kwz6gJKLORy9TIIK9URb7MlteVWpF?=
 =?us-ascii?Q?U7FUcQDYJontiO131g1o3hgbnm5nxzVRJrGyfvCD9m0TmtBEeZPCBjjFzYTM?=
 =?us-ascii?Q?VElrd8cZ2L90aCWeghLG8TmjhcYi45E1X5ATLITxD6J3CwwmH5rZwZskojzt?=
 =?us-ascii?Q?ezJF67qnCj78lMsK007MMxKG38f0lEu9W+LnMKXesrpq9hmwVGEBFQUA3+fN?=
 =?us-ascii?Q?aNIO9F6fjUSfq3vyhjlwTVVP/L7Y67Z817wHtr9WiVGpEusPjof7haVD5CKQ?=
 =?us-ascii?Q?yUduYmcFAwdYmUDhRkjSmUupeyq+SOwu50h+Cy7Y8X/tINBvyVNcH0hHCdgQ?=
 =?us-ascii?Q?PCkg1xBlYb2Jd81fm5db7llEr+WAsTK3rnceg1T3gmzzOzqPJ9WKKZc0pzrY?=
 =?us-ascii?Q?bZ7L9PbUOlcZeOcGiU2cH6QUnNdSLQd0laJrV8eXv9BAObzX0mRFWPSZlkPu?=
 =?us-ascii?Q?+Kvd8MqYIi052sQayIpdAU1IEVJpUaH4rAK0d4yraeO33gtT4n85ECCMuvj3?=
 =?us-ascii?Q?82qupkb6Jtqhgzo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+fY8XOHgxEZ8F3WkSoC4Dh1PXhMKwnyFR7p5C7pvSic2k5DDvdVHOF+UiRcp?=
 =?us-ascii?Q?N+xGLg5BHoFga748hjbxvUrtpOFDHiRjYvjaQzZDfYxSDlGzpqO4odB33UeA?=
 =?us-ascii?Q?msVC6j3Ri24YW7U83ga5spi9f4tOsTVePHABHJTp96e0Ehc9yQn/I6xU8VHE?=
 =?us-ascii?Q?LOogd3PK0YWXNT+LirjAsLRlXtXXxp5Jmr+xYV7El5oSxdTVLsqWYsc29Zu3?=
 =?us-ascii?Q?NZCTMdaNaMLXu7BvsGOzXgJA8uCSR/nl7xlP/qBMNf05xrOgsTqA0mmoLp55?=
 =?us-ascii?Q?qVGhYStecYaM2f3ax/u4yjbQYuMEHaU7NoNt7VNYTlpOWxg5kLxWhmd72Mpz?=
 =?us-ascii?Q?T1cr5MGJgM9wkDBrZTBntABZDRL/TLXY5tLet2yHjz4TxTNQ2Vk8xkTq20gk?=
 =?us-ascii?Q?Qk6EPZedHm0Ah/irIIIv0Fpgh17S01ffKv55kXliLPPgRgZ+IG9qhuh5RsD8?=
 =?us-ascii?Q?UzBDqWzSJKUbRA7AIEoEirbfFX1c48FeQ6ZeNJ6QvtcANV+nTIsKOidP0CBL?=
 =?us-ascii?Q?n6g80NLRg22VcQQ2uYPRE18ULaN4vjukGXyhh/EDOOhgAAcTWRuoTy4Xj6vR?=
 =?us-ascii?Q?OYjzADIhyqcbxUMx0nejOXVfZctx9opsG+11wYn8yrM33T9CxHvHmuW7//Bl?=
 =?us-ascii?Q?Ndx4IXmvuCoFq0gv+GoGjKDn+l/NNM42ZJfVnDbxoEWnK7rso0VQ3+1TtLb2?=
 =?us-ascii?Q?Ep3oODW/8MzcdDGytKb39Djj7zIwDlVCXiIqdW06oLFbU5dvrMWuNBhuolHA?=
 =?us-ascii?Q?MYMYEA+Jx6S6vWPfzodhWEIgqUmD1ybBNMA3Wv80w9buJmOWWiCPotbHJOjA?=
 =?us-ascii?Q?ar4IBE0U6BZkx9yyU8HKKyhy6gT+1xEsgv0KzFaGZI602tZH7QhdHt8ZCahq?=
 =?us-ascii?Q?8IwFnf3MMLT9/hhofcotQYdWoiHM5v1D31Et2I1JXTXQu2vyrO4SlqovFz5n?=
 =?us-ascii?Q?l5CJPhcrmchfitwmX40gaRBO8N38v80zh75qxnywKuf9w6ZI+Q8nUEPjAVbH?=
 =?us-ascii?Q?HYTiSrO1yJfxB2njftryBy1IZv1qzIv0yDtg4T8oTEolncxjxcZmZgfqZqVA?=
 =?us-ascii?Q?7SpIua0AJToNpOU/Hp3jcpPgGMiJivxmXVIxT2/GMGFpEbCdVUuWCl3q0/ZT?=
 =?us-ascii?Q?vV6A9Hkd/9MI5kAho7mPT3yY1pPDIh3XzxlJ1Zp36iVWgJfFNnbTxa0z36co?=
 =?us-ascii?Q?sXnD0ErLj+jzcngRC6L1cq/rB3wY0pyeYhS7tQhGvxAtIU+AuvbcrlmIKJGz?=
 =?us-ascii?Q?PsdhPI/obwUQPmXzrMmgVTNVU9qkd4Y5w8In+pjGxu7U5MGNUP4Azp1Xmcog?=
 =?us-ascii?Q?dJ+EuXk6O+gdymyNBs1C7rDJ1SdaK00chBsJJw7pSNClXQQpKP+DzKJ2wiJy?=
 =?us-ascii?Q?xVTmy6kchNvzffJodOzc0SwQBjgmkkp7nwYxdkH1ZObppxBwifqeGMm7DMjZ?=
 =?us-ascii?Q?7SL2SzOEhKqofidBZt2jYZtgR3U9mNFEeHCKtk2OM4yXYpz6Hy7H8uAg9rW1?=
 =?us-ascii?Q?dCd53J+HQLpeqV0wVde2pBRvC2V+YAk53/vcQo88l9QRlTS09CJPkHdF5bvj?=
 =?us-ascii?Q?i3eMJsSbrMRt8uye1eWpBegb+1bjJu6vOWfG2cknNnNk1YxHCEih+zQZ+CJ/?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68043def-372d-44b1-d31e-08de20f6be34
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:48:46.1479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWCxsAQQm7Q0zK9GZy51/iZGtMaWgZ5pD+Kk+Xj3apNGbayJK56ly9CaKeBsnlHQ1ZVWyqrRyvLS3a9KPWAcstX8TFD6YaFk99A4qjbyRrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB8124

The Agilex 5 SoC FPGA manager introduces updated hardware features and
register maps that require explicit binding support to enable correct
initialization and control through the FPGA manager subsystem.

It allows FPGA manager drivers detect and configure Agilex 5 FPGA managers
properly. This changes also keep device tree bindings up to date with
hardware platforms changes.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 .../devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
index 6e536d6b28a9..b531522cca07 100644
--- a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
+++ b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
@@ -23,6 +23,7 @@ properties:
     enum:
       - intel,stratix10-soc-fpga-mgr
       - intel,agilex-soc-fpga-mgr
+      - intel,agilex5-soc-fpga-mgr
 
 required:
   - compatible
-- 
2.43.7


