Return-Path: <linux-fpga+bounces-1448-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1A3C55AD9
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 05:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36F23B7297
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 04:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD5E303CAF;
	Thu, 13 Nov 2025 04:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="voss/A37"
X-Original-To: linux-fpga@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9A9302CB1;
	Thu, 13 Nov 2025 04:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009067; cv=fail; b=hyr5wPPWHGVRbwHJ9x2iImC92qBDbpRLThpNRErFJzp1UC7lO0MigWAaeou5R3Awo6ZHVv+FQ4H+tGCWlE5A2vJr3ZddYMSErCZ5TMqBALOH3TxGK7trExDWoQr7VUUE9LltO7kvrimUDVqoQygNlPIFbI+vJ+4nZiLqyonuVxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009067; c=relaxed/simple;
	bh=VR/ekySbUI/uGm59nfghVbFuVPkKcW8ex6HvscaiAzk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eYm2IdDF5JfzK/+PXhp3G4RuQo9SoyOeJVnVGhOS7fS0e0K2AD5wxf2pP+w85CakBXrX6MrNfxHXR1KDNCo4gnUFiE+tyaQCKCnpmoXMxv9Rer7PIHUalssFBsJFu9xAclwwFYRJg+rXmui80Gvzr6FySiGPc5Z6NfQsWCtyZZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=voss/A37; arc=fail smtp.client-ip=40.107.209.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9RZvJ0fWKCQV/RHJH4zXZbXhgXg5t051ezzbPK4kOZb/mWIAKBgjG6OkyoR5hNuooBQ15amm844SmyOjDxqpc8Qro1Iq19cYEBopVslhfAJR2X1tS7U8nP3kEJu3GCc4ABuIbPFBYgCZie7OP2gvcmX3d4joABvrPzenZgr3Yvfwy3qOHG5/YIghzXpgbLMYgc/O+tSeVFoB6WGCW4BUZKFZ6AXGNVW6Q8Ucx58U39Eumk4VSWQqU+e6KhoTaUEGpiCK0FhmmhQhe/4F06TnO4zz4Y2JsW8onjY6Sj1randJJoLlAn6HBHKdj2cFqTp5sQ/MP/g9U+AEFS39ot13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvA8x9GcLZVu4/QWU8ObObdnKEXBNZvwyn4MrL1Go1M=;
 b=JrY+ej/mGaVos1edFcI6mYGV8u/aruE0J6fzKjLkrzn1EXdpOhSrIspU86Cd2uwltPJLR69TbgzohfeCOyqcjip2ZqhdTgmcMoFFfygnCBlg0NSeetWTNRDEhl1KPUU1pTsBRsFhK8X4jJHyRra/lBCKPQbWtybkxNiZM7/KAFzxPYPMmBpbJ3XtnTRgbGEN35FA6YsppTf6PGCYaWwTigK+o7UDxvKqwACBlsvpecZZZjEdvCT6MTx72BDmpW1FpYZ4czDO+4/fwOzgeLKSp7ecpM537uhMF/Sv2fkptaBQRMKYFIcIlVjIr0P187kKMfMpDn4DdJ6/k8cRylFm9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvA8x9GcLZVu4/QWU8ObObdnKEXBNZvwyn4MrL1Go1M=;
 b=voss/A37oQEm6jH8FLJ8jC1UeNmdpg700Lt6knR0DTYD+S+AiGj24Qq0cItFr3tuXr8e7rVP4bWoym+ZMx/YSYXUAjwkIOsVLZFfCZ8x92qkMaa354n84oMQyblzIMujTcfw+MLvADD67IrtQRj4mGqeMATUL6f/fD1V0RK6SsEZ0rBYO4puSUugTMi+F0gbEkfp8S1Yb0NysIKmQH8gC2L1QdohiEY86YfxtGTCTB9RLDMoBRyDnoLRJd8WU9wX2VQv07PUb0rQClWalxt/ZnkzDwB5tQvvmP/cNgfAAX1oBJt9DJ9fAouw7LAbY7f8AKtS4u/62CuiSe/VlwpX9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by PH7PR03MB6862.namprd03.prod.outlook.com (2603:10b6:510:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 04:44:24 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 04:44:24 +0000
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
Subject: [PATCH v2 2/2] arm64: dts: agilex5: add fpga-region and fpga-mgr nodes
Date: Thu, 13 Nov 2025 12:43:56 +0800
Message-ID: <9a4ce6b2470328b9326402a2f00ff285be1793c3.1763008269.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1763008269.git.khairul.anuar.romli@altera.com>
References: <cover.1763008269.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::46) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|PH7PR03MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 45101a89-5c8b-47b7-5333-08de226f518f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mYEANvFGUWAERFM9aEm8UZuiauWC29BHzPeXPyiHMbg3po5o1PIrO/aV9Wje?=
 =?us-ascii?Q?rCXvYJqPoEDyj/CSV1FJUIObrarDbXwsICVASz/zDbJt1U6rcykX+xhnS6rC?=
 =?us-ascii?Q?Eb9PwLxRc+dUfBNPxzCXiEmHq8HOTvPPLrMDaph+4O3FlXuUmG9Ntd2gy2/b?=
 =?us-ascii?Q?5HVE2/4y38E0NoZ8ZkUhkudtjIPPukbH5xgugJYUZitVQkgzVQR1iEyTIYDp?=
 =?us-ascii?Q?Xtm1KKTJNM7K4DQCJ/1ZQ1ngU/8J1j8Upakc1qciW8WmB3dwDnj9w7xGAxDQ?=
 =?us-ascii?Q?39QmBWSOZ8A6YAbcKXR/PF4h2upflfY0KUDhDXI0WUlBIGr+PIH8WwWo0TP6?=
 =?us-ascii?Q?h11jvmaB1I1Qb7BDgMeq7SKKuSFvIjMayv4IX6EYh/sbUgPOF6XLnihY9fCA?=
 =?us-ascii?Q?RYeCNK89DaOZtNRpRwAS9uN7osS3rW9rh0df2NCXlWAEo0jVflA65+LT8vpF?=
 =?us-ascii?Q?klleAhqRdjFYwGXFMp6XJoXmroEcrCmhu+nn6LYUQLqgsn/iKVmlvTpdjZRJ?=
 =?us-ascii?Q?DB5uW+f9yPGO9Rx0H22uBODuONvutSA2TRfuxKCZI8Pgwa4pnasYZFV8PZkw?=
 =?us-ascii?Q?u+hgW5R/QmCVAQzU8IXd/la5Z2usBl6MYXnApVhYWYMdTpkaNbgR28Z/GmKS?=
 =?us-ascii?Q?ekjw/adqSMW027LT3I7IhA7lyGIRIQ4hydHN+geNHcGt/w7C7vgr3cg4ClKx?=
 =?us-ascii?Q?yO8Mkk2TWBpRhO1AXUvARFM0A4zyarvJUwaYNJnqWpYYAbh8kXxj7ufLIJle?=
 =?us-ascii?Q?E2QDqF71fC7MzHIGjvTKCLnL5c3C8wddyBiKBy3/UNR0TlLJ7FczPU78urRH?=
 =?us-ascii?Q?KFIYqHBVlI4iUT+EG1Ae1PpyVIyWALS6Z6pgc/Wu+MaeQeA6u7qaPQXuUQvA?=
 =?us-ascii?Q?fQUFuk8D6IIAtTY84WWKokUCCGVSwBPnm7GXVF16ekpn3Eq7d8qkHeD/Ltaj?=
 =?us-ascii?Q?5npSbMgMLr84P41OleyXbmVjNb3PRDP7/ogb9N1E4PmqljTTHf7fT4YhQAQF?=
 =?us-ascii?Q?ShKpboBGldAdg+wBCPEJHuTm8XeUXiVjhJOtS4QQ7xMSPshUrG6acEPdCESF?=
 =?us-ascii?Q?RjE0px2RsBkJoFr5ZnlCdM9k2KOaDMxShoTu+5QQwhOYDKPh58XTSp0v7f3w?=
 =?us-ascii?Q?HFGCF3rVv8pVaclr1xpsBsbx7Rr2243vBJLuqz3ZXuoXI4SM86xRQTuU13XH?=
 =?us-ascii?Q?7WK6FgnQdxqcnpsVX7zXiSseFmjebWBTKQFwmP5QiDfy0LLf8iL4XkJ/3UJX?=
 =?us-ascii?Q?vYV1IpNEwUxcrU9J8wpRyK1N6tj4QPYYE2rAklH2WCurj9IeIpAhMgrxgeyl?=
 =?us-ascii?Q?w/t1fhFz5RMJEDoho77mSrQXpbu0hidIaziXpBQWNdYXI849Rnu8U200IVT6?=
 =?us-ascii?Q?zH8e2ihmmicCbszpH8BTx+74q4q4RQp0SOlczi1UiRNTkfzC/Nm1o2xJqWQv?=
 =?us-ascii?Q?Buc2UAsGUuMv6pzsvRmOojLKhoykv+zg/pwBwi977j6J/TiZuhE88LRDJ2/T?=
 =?us-ascii?Q?4GE9Zs4Dh/bBhwQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oOm3vjDhM2Enl+a4qEW2Tk/QVes2Qj4nj8N6O+H8BxGaX0LrsjwBTge11WXC?=
 =?us-ascii?Q?5ixxe7VAF7BZgDHM6bynJVS8zHpTpshclK2mRiu6bSFUQlYL0l7DInTluzUc?=
 =?us-ascii?Q?UF5etor0hPZYNgTgVYINLE20U3MrV4dflJiuuMYtsDRRt4NB22vIHbdl0ERd?=
 =?us-ascii?Q?KKXmnOO/GHuk2zqWrf5ykQ+Sq2uc0aoc2BpMPp99SRA3b3E0HjiTijzZTyQA?=
 =?us-ascii?Q?eRvcE3FN7wtXIP5kIwFKQ1DYibCp9+a8XtxI2PV0OprgN9BoxkAkb0SfOGQu?=
 =?us-ascii?Q?dtYqIZ2edwzZUMAC9pXF5q6LlMC/CZESKWnBXsA72DNs95LTdFBLCZVm8/ck?=
 =?us-ascii?Q?ySUShvczEuYxs3ZJ0JMSZDD6u6pIheMYJa3xGmZBt73iQK6n/IKWbrdpnqI6?=
 =?us-ascii?Q?Afz8iT3pNGYUWVZV1LlvlToUS64GaEtlvoi4qMZ9ohZYJDnPpq7Zljg4MOBc?=
 =?us-ascii?Q?eFeCu11FE0aYq8qwJVGkqkgmqXjO7OMNazgF8Il8Mn1pFwgDkNO48ArZwdkB?=
 =?us-ascii?Q?/K8jkfEqTOz0sWre9iKmJNvy/6EASsGboRPfqJOMCFZAqrixwSLR/Ge4aBz1?=
 =?us-ascii?Q?HAZwkGpA5LdiVjACpnphBaJOG60rBy9kz4C5G+Gyu2/ec8tNwZ9h9bvszhGB?=
 =?us-ascii?Q?70jkK8lOfqZ+yevQa2eRhdEky1htFyV6vrc6HQsfJvz1lFoN7nd7n1Zh0xr1?=
 =?us-ascii?Q?++WZg6k9BYJv2A3TZ7EJ3rlHNJIO9zvuMxF0wNr3cxU1rc3BHFhOnwh1H0Ve?=
 =?us-ascii?Q?bdYthseddXiFjJrloivh8nHcw9I/MOF8MaR9VXrb+U2eZETdKYcgNWtv0V1q?=
 =?us-ascii?Q?Ni9/oXS7JuzyeY0ZKF0q39dh0hVRy29sl66X4VoQiP3JlHf9TsFwCZFGuFpv?=
 =?us-ascii?Q?fP9/AZh8RH+XIw93vSpzn0sJRgJj+L9IHv/sNjV6i2fdb+7yky/ztSXKbWE/?=
 =?us-ascii?Q?J7E+NG3fx4By3PCvjcNkVaqG9lgRibj/7ctcke+LhNU0P3ANW2xZYXtTFPoc?=
 =?us-ascii?Q?8ijeR7bh+Lk9IKl860pEXUTea/Wip8kFFEeUNqMGuru9ko6d9oYss/3Dlfut?=
 =?us-ascii?Q?TlMx/RU6kUE2qJxq3+4ZGd2P2DKkNq5VaOnYJCB7Yr98ZYu4dUaQY8yuUt11?=
 =?us-ascii?Q?B7PEvhIJfmIKuOj17ymy63HN3Xs+n+oN8ZUuOm0r+/q2owSaUU1zEPBs9nJp?=
 =?us-ascii?Q?Ogrhp0PoGEes5cl6ikUpXCUkuaRzT+3sO4WOiKMyudRwIdhQOcteEAOG9vAf?=
 =?us-ascii?Q?pNLhwQzcBE/cCMnmzZrhgWlzgdRVCVN/Irh+KXYTpJmFOmhtvBW9UhQcpT9t?=
 =?us-ascii?Q?jkGHyGUTkHkd1e+dhdO1d2XoudUAGaXtQU5FL0wWEk4zjKaqcpYk7tc5Vj/e?=
 =?us-ascii?Q?+QR9TsZ2jNzDltcqs2tTpPOt+Oy+d1cirS9wW7tYDVJ3OXtXLRjZZcwxh054?=
 =?us-ascii?Q?pvmEMNt6KtKwOSh0Vu51JcM0tKDjhizIYnCu7qrS61TAmAJ2P4/gUd2RZFMX?=
 =?us-ascii?Q?7qK9cBMmeetlQC6NoIAOiG7u7o8Vtq08V6mWl4nZ2omAuXpFiHKgu4gUtBV8?=
 =?us-ascii?Q?cnPLZNcaclNVfXm23221qUf4Uzj1NgvnaRv4nVzEQX51pKjYvBjfVJbFgCpT?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45101a89-5c8b-47b7-5333-08de226f518f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 04:44:24.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AGpQxH2THnbYEB/OdNd+0mF/ywyV/XOU6G3h/6JecODIVjrjcT0Ifs/WAcQOjjNTP9KnO7M5ykXipWQydEuhaYRbSK6xpoigT+bTQIMb9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6862

The Intel Agilex 5 SoC contains a programmable FPGA region that requires
proper device tree description to enable FPGA manager support in the Linux
kernel. Without the 'fpga-region' and 'fpga-mgr' nodes, the kernel cannot
detect or manage the FPGA hardware correctly.

This patch adds a 'fpga-region' node with compatible = "fpga-region", along
with appropriate #address-cells and #size-cells properties, to describe the
FPGA region layout.

Also defines specific compatible string for Agilex5 and add Agilex string
as fallback for stratix10-soc driver initialization.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v2:
	- All fallback compatible string to ensure driver is still able to
	  initialize without new compatible string added in the driver.
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index bf7128adddde..06be0b8671c0 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -85,9 +85,21 @@ svc {
 			method = "smc";
 			memory-region = <&service_reserved>;
 			iommus = <&smmu 10>;
+
+			fpga_mgr: fpga-mgr {
+				compatible = "intel,agilex5-soc-fpga-mgr",
+					     "intel,agilex-soc-fpga-mgr";
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


