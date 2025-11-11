Return-Path: <linux-fpga+bounces-1439-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD461C4C294
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Nov 2025 08:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 025B74E88D8
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Nov 2025 07:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CB4238C0B;
	Tue, 11 Nov 2025 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="S/g6l9WG"
X-Original-To: linux-fpga@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2681D79BE;
	Tue, 11 Nov 2025 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847326; cv=fail; b=qgQsbBlmnGq7QzN1TLgqDpUCA1TJw4t4diFF2Hv8t0nCpdUg/ZmiAVaiKBSrRGIwPZbEMOqrbGknKngSLg+4mNTYp2cZOnSkYu8n0FrLmqAjsCknlbb0v6jGSo1xjgJ1zCgu/dNH+6zULA2IaTxdD/WzJOM66Jz0M6h+86h8MPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847326; c=relaxed/simple;
	bh=52W3bfoZxd7ScFmbDzXNGLMwRdsbOud0EpMTaLlRnRA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iolwI2YipyI36/L0iKdaxCMxfEb9EgK2ap4XbrsW7BXDwnGP5wyFi1vKWEoO373by2b92DFVltxgE4/z6dlMomNYhgvgOV/ZjhzQhfweI6v4I4gjLJLAIcK+H/2MdAyYfLbsoDFzu5oca9HTfNgeEn1wv91M7ZBVlg0Y6DSaixY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=S/g6l9WG; arc=fail smtp.client-ip=40.107.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNaWUGH1CGKxPHrdlZLL9Tbxf2QYXNRPO3B0sDtuS/LS10Djn0XIwn/ffsCyXKEzNVefExMLfvaFhWjb2a5uaiDpcooAJBE8Gf1PRjZPHN8mlvZvCpeXVDrQMti3SOLZ1FflwU6x/JGdtFKHCpdmbJKZNZAgaWcinvZEx2Bc/VnAZhjuFw0cv/Oq/15ibb1Xtc8EovexL2vG06URVVrdm4bp1MUuZMOmEZQYJShTKtyxgk33AP35016YUT1QQXuRUVWiBDQS2+w6eSTC8tM7RZV7GovNcm5DQpb/5tF5LlZ8CPf+r78dZ58qUN3cacLD4D5q269MoFi/bVc8Ry8cQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvxszyie9Iifbjgfi/WiuZbcl8KZjpU8Iluxhbvh1zw=;
 b=Ly76kTw47j/ZT1HlHcIigfdnETDyFQtXTCMXBzWOY9wSea/pf6N00+WArtA/a2nT9x5AKF4ZsL8PUnIXRM6mAvhcFq7oiqJ1KTNzcCkcBCoVyBVHhs3ttrBWleuTxSzmKHt6Z/FRWpFzZhAy0iFdYhSaOfGq99GrPTUe5PNHNgW2SzAiAk4yHVGIbLbs8A/7wheeud9mosugL8baTMz9SEfRu1zNKY7xqGfOoFocDGKp4/zqFan1oNvZE4tHGsD+z+MKOttSpDpFPRP/DTpswFgp0bhXZxkj3yMyoU11FIJOdnF5w4gS8pqA5VUZW+c0A1MmWZsOlpQO84WTS2LYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvxszyie9Iifbjgfi/WiuZbcl8KZjpU8Iluxhbvh1zw=;
 b=S/g6l9WGhvMziPKsgRJHiq1rqITezNiILYHQtldpjsHFdck1ZJwGo8H4OROgS3A1k5JUVXlmqfUhSoMoXRZopQhIaKKw1s2Ezy8yseLZ69QZDITNVBm70m+ohIMgD0CsPdXAcL3lkEhQbLesyOWAwOHn6NcFDv+twUgIdYaqBaKvzIpM6OvkFQzA+hppHVQBuo1fvAj92NbVB+/8RdavcKdSBtU9NO+SNoIV5Hzc/M4YKxXityZYsIK4NwXtp45Yf16Me5RixNRVmvLiLV09b0e2Hm08P8zKPKHpg8WC6HY7vNU6dKZr/zYmLfqjV/bm5kjWWV5UQk8Z36HRYRckvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by CY1PR03MB8124.namprd03.prod.outlook.com (2603:10b6:930:105::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:48:41 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9298.012; Tue, 11 Nov 2025
 07:48:41 +0000
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
Subject: [PATCH 0/3] Enable FPGA Manager support for Agilex5
Date: Tue, 11 Nov 2025 15:48:30 +0800
Message-ID: <cover.1762843803.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
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
X-MS-Office365-Filtering-Correlation-Id: 4551b9a4-3158-44a2-eb22-08de20f6bb1a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sawh7Zwve3o8sUg/cywwSLhVuHjnXdZ05IXTfZy5nLXQcmZguNC3MvUGEeGi?=
 =?us-ascii?Q?sjFMKhTD0k9tqRXMYtjoWIWWSSshme3rt2QSS/3eYbefudmNAU1XbaYs81dD?=
 =?us-ascii?Q?XEfx3RTBnMTU+85O6W/jnoJ0dOsppeHKWFPxtAjsrekJNYL9sm7KVwtXLlpY?=
 =?us-ascii?Q?i2u0ZEwawSDmowJnaRzvMQ3QaSQ+Ym2/3vQoU3ByF+P+tqx/tPGbTc6C43Ua?=
 =?us-ascii?Q?QvPLfPJMJlz0IIjPxv8oZ3NhIa4buYv1DZ5x86obVJ48TqSGAxhV8KRBTeFo?=
 =?us-ascii?Q?2UHMZoc3w7x61hf0aems2PE1H54vDoKifSXaWO+jYh4b+S8J0PGpKB8WX6qU?=
 =?us-ascii?Q?Cky1kjzfS5MrDyoX17twA/+2Cz27Qewl9FG+HOpCEvhbu2v+RW/KGNYHPz7e?=
 =?us-ascii?Q?ITz5yoNw27XpfnTEWZAtOjDN5Ju1Kn237pgEe/fF90+I5jb+9vsuC5uC0SB3?=
 =?us-ascii?Q?Xfn0H5ES3JRf52UsM0lbFI3OuX7LP5F+/9C6n2EHHybHjVrXg9oEZJiZtPlc?=
 =?us-ascii?Q?J8FuXgfIoKOZB1BFfinq/7YhxbOrqcAJJACpHpwqVGeJVd4s013KPG+xuH6I?=
 =?us-ascii?Q?BsSY4UszkExWJTKq+l3OpkKD7JhQd5zbD1qP4gxVl3sN2ZA13zAVcOHpSTZS?=
 =?us-ascii?Q?CffBYeWMM1jcrygC0qejUN8Zrfpx9/FEJbNbtyjwA/u+6xbqaWqR92aOxbmT?=
 =?us-ascii?Q?NW3C19jKlHUvGLPwCFSVxmSE6XE6ow3Yreylfq1NR23t6E570VxO2NsE/fxb?=
 =?us-ascii?Q?IdyJclwY17wkiBuTdcT38Fc27OZ4w4zPnj5JMvi9jNGXWpXY+Bb369tEwyCf?=
 =?us-ascii?Q?mrGRsrO0GXiX+vID7R2sm0vgoCz+iIzp6CXZbZGB6nLHn78b8mZDGsIvuXZ+?=
 =?us-ascii?Q?AMyzhFBleWPqtnJkLdo/j2nZQ0Fsi53X7JGy9Gm750JVGDqB+qVaJiceCtIG?=
 =?us-ascii?Q?lG/KRBk511l9rwRXpPtdgjUsHcT+kaurZzBDe/DxwmvRO5GrtT4glzwQod6f?=
 =?us-ascii?Q?DpEtSMrmYXjIrwWVTIUiPcE/qCjQ33uCNIRyu5vqwS/6DFI0QEQH9HvQ+A6R?=
 =?us-ascii?Q?kfnTw2T1YzJK49np0aEHuFewg2eJLOpe4Efwwx3mzM9TetQvk9QRM2kio33/?=
 =?us-ascii?Q?DbVZIIiXmA2F9dLAL9boED/ub/uF15YKw3ExWpFLoUDGivnoDq/Kdj/h3wdM?=
 =?us-ascii?Q?Y0fjT/uDIFOcanMO4gRLBOvDBj6Ry1Mrb1MX5I3nLzkUg8biiLUWsWeDK0lz?=
 =?us-ascii?Q?mAHl/d4DbGPUJOsSdZf1klEj0BopxTAZbpnISxpYdDDLKiOauvJJ79ii+knZ?=
 =?us-ascii?Q?V8G+QW8J/D/Jw2hhYTKYeMpP/KOHk4TJAM56yUu51ymg2atdwKjIAtC0miu6?=
 =?us-ascii?Q?NmTQPIpRCbb41XCc5FDgvthwigTDAKQyy3cBOfnYAB5YSvDSHrcfHSDz7gkT?=
 =?us-ascii?Q?KiDFUwAMjM5kwHwgyG46rRj3iBupcVedJp4r0YSicgo21H/zTA/WqGn8r0yb?=
 =?us-ascii?Q?UAL0I943bBu90/rA8q8rcN3/l6UjSr9L4tIf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IZepB/byLK+GSu4KpZsEaie79SbyFlpCbM/MjW7jUiCw+XJP3izK3CeypPwb?=
 =?us-ascii?Q?U5FV8/EGmnlKqqurnXFe3F31kBVdozeDJ4l8pl8M/by3EEXU4rmy9RrbpuD4?=
 =?us-ascii?Q?I15SJN3VAblEMMa4a6AgjZnpp5wVgTZjiFk1czjfR/7PRjfWRq1EABpd8feJ?=
 =?us-ascii?Q?4oTSY4MVqgyvnEwYJeE1J+ZEpmciW0VnsfEGAJnddWVek58Bga6TUd7hnehx?=
 =?us-ascii?Q?DaS2BGR1CZP/HSqpUj+s0CD0uUt4lPtiBJV7HybfAgubDbPu2JnoPAxYN+8d?=
 =?us-ascii?Q?vme8sALIf0BaDNKSP9f6mS04OijOQJ+QCIQyGXKa2fpHIThDdWnxbsfpRWxk?=
 =?us-ascii?Q?OBlDwHT393qRFlAB4SNt6hUkIM/Kx/YP4NjKdBH2ISZ1btvIhVqrRJ9RjG0f?=
 =?us-ascii?Q?HrqN/ss0PlV4fbB/d4qLRYkT7zSuEj7ddUVg0uL4Wnp0IJ/fJT7acDVvKbA8?=
 =?us-ascii?Q?ASzIrkrIDSLs+It4PBr1j2nWH2aJFR/7mvSAQPXicDTl4nF6CceYlZBoUt6Q?=
 =?us-ascii?Q?evcPj2syr0YJjIumL0/MtseqmlKozi7Mt+0abCIZrFeRy7rIV8nIUB9/WXoA?=
 =?us-ascii?Q?QCpInSOsCGCoDczYMfHbwq19JbLdA35wJtRQLgAt9Y0FNNPUHOEJ9fFIXpEF?=
 =?us-ascii?Q?sNs8XTo3pHlC5u+WfB4LVbPxfG71ozQ8i3CNOC1pPKhis1OKusPmUjd4AoeJ?=
 =?us-ascii?Q?vHSCVnfAUTpl124a7PM/2h79Iw2UCJQiJwgp9nBfXmPE9eWx0WhTyldLAdp+?=
 =?us-ascii?Q?GmW2IUvT48bBtdw8SFBt61GzbYsJyL9gDsa25HNoFzqewKqsZ5qy4MCtZinl?=
 =?us-ascii?Q?kL6gUxh3oEcIb+L4x2dKbX6rplczLF75nE3BHDS3/Ddl2JTADnPyEenYyRdn?=
 =?us-ascii?Q?gtA7QNxjgeGMqr+KjVLlCbUDuB7rYMXnZ/+3lrG5BfQh1rYaRNzc4Dx7mhJT?=
 =?us-ascii?Q?BWnx1+n8whB9T0usj1my4oTKT1bEjCgUgR6ntpLzXLCjCC3G1G8d4AO3ANHh?=
 =?us-ascii?Q?bSzAOAwfBI9Sy00P0AxVtgGFTg+AUs8eWHkoNJ5KjOVR03ytBHcTrbVu/Se8?=
 =?us-ascii?Q?BG0w+kpx1qg0G7qJ8WSVgIAsuUvuZFMo0e1n3q9JtrCj/VuB9Sbk22Lx3BkK?=
 =?us-ascii?Q?Cit+wOdKDuws9KlRSPYY/RQ0CiJaPp1LtSCb2XPcNRWHAIG9bmr01E2yyPQQ?=
 =?us-ascii?Q?2segW0/KXIg5T3JxmBZ7zLH0s8ALPHGbpqabwua9lTRHkRSgk8yxV+7QJ0FA?=
 =?us-ascii?Q?nrtlYD7Gb1jPjvt9ZQTcZ5ZaFarMhTghdu7GfVL8/kXYhB7GW1lSHIYKyguE?=
 =?us-ascii?Q?GQKydiLV+wBmP5krgMFn7Ty0DSldF22ritzA4bemWUiNSWvDrLe+14fvtvr6?=
 =?us-ascii?Q?O8/bBpU3x6Tb2E/lEfYscWCxhKw37J9cuhjEivrnRgpcJtCTpmRJgqLDTgTT?=
 =?us-ascii?Q?O95K2olM/9dx0ZkDZNXO4OQ4kCiuVPvNnQMEATlzsR2DoZlTkzjUb7AoYcuQ?=
 =?us-ascii?Q?HBjbCYMUs4NGn1GO8GzvRWSEvv2bJvqTcWCRfWY8QoZSJrgkxR+grRyzlvr4?=
 =?us-ascii?Q?Qjfxf2zHfVkaFZlCno6hEm1zuXuZqrsIehmFrkNjB9tJ2/f6XZF+c1VhiKOs?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4551b9a4-3158-44a2-eb22-08de20f6bb1a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:48:41.1467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+WPmw+ARPeFw8jx/kK143mtZGbwt3ZqPW/vG6KD+BLqBMCJcRvgMYrfn9RTrydtKEY0EjD2+Jza3k8KC01XnCL/GoyFA+ih4JpD6hpK7mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB8124

This patch series adds device tree bindings, driver support, and DTS
updates to enable FPGA Manager functionality for Intel Agilex5 SoC.

These changes are intended to enable FPGA programming and management
capabilities on Agilex5-based platforms.

---
Notes:
Patch #3 depends on  "arm64: dts: intel: Add Agilex5 SVC node with memory
region" from
https://lore.kernel.org/all/3381ef56c1ff34a0b54cf76010889b5523ead825.1762387665.git.khairul.anuar.romli@altera.com/

This patch series is applied on socfpga maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19
---
Khairul Anuar Romli (3):
  dt-bindings: fpga: stratix10: add support for Agilex5
  fpga: stratix10-soc: Add support for Agilex5
  arm64: dts: agilex5: add fpga-region and fpga-mgr nodes

 .../bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml   |  1 +
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi        | 11 +++++++++++
 drivers/fpga/stratix10-soc.c                          |  1 +
 3 files changed, 13 insertions(+)

-- 
2.43.7


