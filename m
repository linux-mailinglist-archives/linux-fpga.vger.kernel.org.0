Return-Path: <linux-fpga+bounces-1121-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBBDA66015
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Mar 2025 22:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716B03B276F
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Mar 2025 21:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A5D1FA85A;
	Mon, 17 Mar 2025 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ZWRgbhs1"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D791A238A;
	Mon, 17 Mar 2025 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245311; cv=fail; b=QImJX/2Qc+Poy3Xz0n6OpKV9UvFFT0ek3K1UweubrFxEwmL+8VsllKfoRxf2T74/3/j/kZmxmqh4D2S+/U+r1p/KgsMVVtYxyWd37QKC7KptoZiCaiZPny7CcExToh4xqcgqC4RI2reGO3I4nkRFiuar/oiQLTqR6+5r1y7DpsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245311; c=relaxed/simple;
	bh=th0Ryoch3aJ4G0ayFDvUFq2VWB9rEdN0zd3AjFqWc8s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ag34jdY1oZzpiySyGGC9oNymkGy6pF7+OOexG5SdYjxtuRsGtfl9075KfXCnjipoz6w5arX1FRR+f0UfwA/a+aZz3kGS74Fga8GYEQXu8GqyI8W9BAEeRJtk44D7cbAaMeIgdEmmZgoY3aLp/W+uZlSUCXTYzyDdNpXIAWSrnyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ZWRgbhs1; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVq3n66pjKdXtD+S1lOY3gUltR+7aY4TNh/grMGQny7HM2Ox3hlKT0bo/QlS/THcjm8Wld0TMdrkEM7gAd+0d+70A2ZkdhnTQ+kcbTYXJvzTz+UuQij+TzlXmEpu06vA4lvvEPshdPtW10SfAhjCkCX+s95VC8MLVMRKpNeuh9jmjmwbP8q7C/PhcRb4Ze6LJwu+o7duXPhCiZ7c4EsQrXm7xBR3/+MTTfugX40RuHcyvmYkWQbtxLNDvjV+vcfwOKv8XWPGDaefch2chRl18dS6MfTXgtNit8CAsjMsnASAsxU86rxsOzxkMWbqK69gvRrhq28YRdKMWDZSuba9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqOd4riF3AuvQpsKue6GbamCJ4ZBwE6wb7rtvvuPXkM=;
 b=fnKsDk7xZrUdWdnA/1x7TxuWBlL1rZT5AyeMce0o9UsLTys2GB99dvu2RIiXkERAJpt+UtqKejZsKDBMuJZ9ET8UZUIE37SDybuCzAkBvAuKY8gk8lNV7juFAAnef1WYdhxzPoBBDcbzIM3Yt2OHWELlyPCfp1BIcCgMS6ruHkj7JuzcMKDfbNAunvPwImoFJvresPIuU8FoYQbek9z+CVP0z5CgLLaCMXCLlFXI2r2qr/fDn3mgIBmiJtlOGmucGBee/LX864oQmt3CT2U5mQVEaBk2H3R/AjHU3liAEyPzXOZYnyjA7UAvy6xUwWfzmtLi9LRZ3WVX2QD6d/hKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqOd4riF3AuvQpsKue6GbamCJ4ZBwE6wb7rtvvuPXkM=;
 b=ZWRgbhs1piWzeTjXzIai0ckpwIJOzxMb5IpwzU3/ZQ+n3DQ+PrDdEFrSECSoJ7Zu5HbtQKSxJpBnOXnqTS6V26FQnl2Ron2DssS31iREnnhqmdY5BHyDytn/KwnNEGJef2vrEgb62Z2fVRXPnAQx8GhbEJ1L9g8tTqH+3ny65kCW/oDanjaPROaKsdfX+tGv/fUiCtAVcGtqf9Z1c5ds7zyVLrldpzWiCU69LHHH2VgfKmuAwbd00fpJZ5WS2OxCeP3c+6fDjX1YiWuF9/pOwhG2dMot9i1VsgBMey9ayeSeZEHxtXRtF+OxcZ5PisL9jVraoUMl48REOHRLpcMTRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH0PR03MB6220.namprd03.prod.outlook.com (2603:10b6:510:ef::12)
 by LV3PR03MB7477.namprd03.prod.outlook.com (2603:10b6:408:199::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 21:01:46 +0000
Received: from PH0PR03MB6220.namprd03.prod.outlook.com
 ([fe80::6f4a:f9df:de2a:2921]) by PH0PR03MB6220.namprd03.prod.outlook.com
 ([fe80::6f4a:f9df:de2a:2921%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 21:01:46 +0000
From: Peter Colberg <peter.colberg@altera.com>
To: Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>,
	Peter Colberg <peter@colberg.org>,
	Peter Colberg <peter.colberg@altera.com>
Subject: [PATCH] fpga: m10bmc-sec: change contact for secure update driver
Date: Mon, 17 Mar 2025 17:01:36 -0400
Message-ID: <20250317210136.72816-1-peter.colberg@altera.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0377.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::22) To PH0PR03MB6220.namprd03.prod.outlook.com
 (2603:10b6:510:ef::12)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB6220:EE_|LV3PR03MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a53a55-a726-456a-63ab-08dd6596edb1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?phecoB8exvpIskxd2Gruptn5qNeMaEHTKYSEeqspPacVC3TnLAhzP2iDxTiw?=
 =?us-ascii?Q?V3on6yvrcQZ586X8O92blmuF3KaMUNeP5mc9UHNLkWqOLNiFtGcLTOtgox6T?=
 =?us-ascii?Q?NTkZK0rc8XuglQvpClMl8eIwvytovtyVZ1JWJ/5h001PFtMF1KeSFansBCcL?=
 =?us-ascii?Q?ZeyjgK6dZLS+kvxLrL8kdrFBi88XK6Ab58DUPfiTIKq6UcXnvVwTtO3TRBTr?=
 =?us-ascii?Q?3gbB8fUlx0zl+M1CKXY9LTcb0a8XE+AZ7i81yrN8C84vVfRLu0ktF1+e2qU/?=
 =?us-ascii?Q?qXSzi5DQL1wVCyqIlDroYC3yVfRHdQbvxFQ0xZnt2aB+Ld89gkG7MKC2pqx1?=
 =?us-ascii?Q?zvIaDWMpszUIpSQ08PKa2zANhdEI9YeiHmB8Qg1na5GUdUfuQQx6kjUKLdDk?=
 =?us-ascii?Q?lgQ0sR/Xud5VG/vId+MDcvPvaLauXrkfhl+c1xSZA49IBwW7/XbfmUKUa0RZ?=
 =?us-ascii?Q?qJlgu1QeZU/9FyUIjyqSCV+44msQk848zf5DzbMdw60sCIIUszxH0fi3Q1WK?=
 =?us-ascii?Q?kpuO9VOlYMPGqfWS70uqsMduk/kyEWDZ6x+mncZTGjTuXes58S2BF8XxWgls?=
 =?us-ascii?Q?541OY4hqbqLa0nzplvqP0fx8z1r2dhzrk3i0l5AAw6GW/utVfcRZnFWVykVl?=
 =?us-ascii?Q?yYp6EkQ/8M6W6sr+4w6K27Vp6+Qu8gk+Br0n+xud8mwaNj1U4AX9SH2enATi?=
 =?us-ascii?Q?+5KxDnD+teeOFh/vh1J8ltAa5j1MckBtFUgzkp5JHAnalyIF6vr91kPoYKFM?=
 =?us-ascii?Q?fa1IGmxSl5xLUQpGcmCogXNhBnj28l35/tIWAwqPew/1ZIdREJmU9e1T6sQW?=
 =?us-ascii?Q?0SBbq1PGaFxRBhZn0TcfTntEI0fuIzKp+mavOuLScre3s+LopHVgby0wo+BX?=
 =?us-ascii?Q?F0JkUWxGjvkXP4ZvIaN0XIlmsFRBRW1gOPPFwywUWK3bm/oC5Au497487byL?=
 =?us-ascii?Q?bGyoq6fcrByXqAB5Xa16rlf7AvZHf1XyeQQpqYPDYffr7xsatqUibJ+Vbwrq?=
 =?us-ascii?Q?IWVfwwBQf44jCfuBZ7gjtWvpSG9egfA7CfT0z1sMqqXj8wJWLOoOF9F+arsY?=
 =?us-ascii?Q?0czSR+tclTBzsHEvqvP8lz5k2tcGvvrR+VVqwvDER1hf5oq5Ot/qxpqzUoQf?=
 =?us-ascii?Q?Dg1MDR0fP6mN2LrHf/HA3zd9LhBFU80io4lJkBYiLgmXckZfnbldtzVf2pH0?=
 =?us-ascii?Q?lwtoddv+P2Yic3AD0zTUdxHlDMT+z8sXzCsnGBi1P62zfRey8CBQgnX6nSCk?=
 =?us-ascii?Q?Bgrbr/r2x3ML4AoACjcHI5X1z8GclIsy64iTUTRIyVPClMnTruqHhOViD0f3?=
 =?us-ascii?Q?r3FpBCCZvK/DHnWfXMso6lNArVpsxnnzcPOBGB0chXW+yYVB9S/gzil1y8IO?=
 =?us-ascii?Q?6Uz+P3XHwoY7+bHSl9ZuSD9iRgzq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6220.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vFxqmnEuIp3s3sM8kZtq5FToUSHYiUtfl5X16RNy7sPZuXa3tpUxDmvTNuEE?=
 =?us-ascii?Q?ULd+7shrjlrxgpfQ4gONHN0GOGpTRGDM+RdDu5kewv62NU+6CwE7rrkwiUeR?=
 =?us-ascii?Q?NVXk7HiRGBeA560ZZ9AEshjAZfjjBRkCWl6MwXZRy/5UeXgcjcLIXFCRcHYv?=
 =?us-ascii?Q?5lWIhOH4OIbphEGRReslzic8wfzWbWZjjhxIhwTzKfLHKsYQaPCi7OwfIzm3?=
 =?us-ascii?Q?t7sXIUS8VE8wipDMAWwLE8QhvH8C2hRzMH3pmWwJKy4zrGkgHLmIopnIo2vq?=
 =?us-ascii?Q?/qu+LEqQY0VhOfBpKQuT6/1m01b5DzxwYLwapzjx4tzVFE0/Smpa03O5LDDg?=
 =?us-ascii?Q?wE2HKAhxjOgwYowQgufGtyNcxu813wTmX70uXdZ7CK5G4C3WPvh/annYtqdD?=
 =?us-ascii?Q?QlvofytfntIIO7diiZKud+kKZltq/w6zH99RggzVbuD/U+lgoymapXI6Gvtb?=
 =?us-ascii?Q?NYJeczFShIgNZs5N5laPtffFljiOpsB2CGeIb//t74m5Ockx3r23mEolRtvJ?=
 =?us-ascii?Q?xnKBwBSkHpLlXMfUeb5vHd0fQqKFoARFKZjSY6lzVPgX7Ml3byxRVOQV6zDF?=
 =?us-ascii?Q?kfzbYTfHj3uh7nUiPTDcnBthsOvnM3UQBF7Ncmpy4lr2CJZlE6UGOVtUXqqm?=
 =?us-ascii?Q?ktTuMyfRKpB4DW5uspiDVHtn/uKgU6f8hyOrCR+BBvKgOlH6zzo8JU+72KAv?=
 =?us-ascii?Q?AYxFmGm1ObMdCf0RJTKxDIzUp1n0VTzT+g4DmdVrEkPGrRy7px0HicMY234M?=
 =?us-ascii?Q?VOsXXl6E9wukTjD8rEpIv1BGPCZI3nrN5/H/+2lVpXxbuYDbcaPEF4khh4L5?=
 =?us-ascii?Q?IYlDx8sESzH87sccnzYFJPBFKGrdkT0IkpQo457AP/5E6jjeJU4v6mA8FuIU?=
 =?us-ascii?Q?1sanygJqmgj0DoxYQeORbD4P+RxyUUDvmVXwOTWwx1II8m/9oY9kshzAQ9yi?=
 =?us-ascii?Q?+JCG5f+RL2wigK1Om6mMeC1k39RBLRQQE8q79Q9ZmKf9VjPUs+y2H5b+Uw26?=
 =?us-ascii?Q?QV/tpIhayL/EUUqXH4MBg59ZPT8eNXL3H+NJ+J9fRIhGJKfCsMD6fQmfh+E6?=
 =?us-ascii?Q?IkX31CiJWqyJi50xbxQ0zIku+ByTKk4fg8uhli/GDZpRcV9xeVgjF/zMqple?=
 =?us-ascii?Q?1qStNVMec+WGpRIPic/aaDT6y6nBpSqhHEFYR49rf12RBASrPU9mSnahAW2l?=
 =?us-ascii?Q?RWP0mgojUkLqwPdk+U2+dleeFQxe/kCXhVflblbVo7FxjDwG9TdB6xJAAExP?=
 =?us-ascii?Q?rf2vonEHLK0rvGEPEDJb4/tHZ8BqeX215cMNJ9DUeAhrINUtSycOBCkkewCF?=
 =?us-ascii?Q?eCyeR1GpcXKetDfO8uYwT9AYIeXSp53yfrRF55JHHQt0+MCLdQHhsdO9aiGs?=
 =?us-ascii?Q?wPzwN0RZGBNJaZyqgMF8xHfm2pEBJH15Qe0rrydh+g0KNsGhr7H8bS1bCOPK?=
 =?us-ascii?Q?cigS/nL1jtgxLqWpRLcTFve2vzdFandgHc8/y+lqdonx8pGR5lA1N2Qlwr1D?=
 =?us-ascii?Q?/3s4QkMwEVFa4C9fdt46kkD3azu627o3N9XU69tBgEfJqHI+pZQDf6jevneD?=
 =?us-ascii?Q?G0jmA7XV9/vxaCSOseM4OzGdVC9kp48xpOPFq0m7UXtOrM94RTvbLiLUfBN1?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a53a55-a726-456a-63ab-08dd6596edb1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6220.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 21:01:46.5544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UX7/K+5YA+OtfFOJBTXND/HRD0PDM2GBFntFxjgNAO6bKHDzToHeFeNLne5rNeXfIMVXlXeMUvxN3vpzpAcoexL1vdk+kdRIvNpXB+enK0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7477

Change the maintainer for the Intel MAX10 BMC Secure Update driver from
Peter Colberg to Matthew Gerlach and update the ABI documentation.

Signed-off-by: Peter Colberg <peter.colberg@altera.com>
---
 .../ABI/testing/sysfs-driver-intel-m10-bmc         |  4 ++--
 .../testing/sysfs-driver-intel-m10-bmc-sec-update  | 14 +++++++-------
 MAINTAINERS                                        |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
index a6e400364932..faeae8fedb14 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
@@ -17,7 +17,7 @@ Description:	Read only. Returns the firmware version of Intel MAX10
 What:		/sys/bus/.../drivers/intel-m10-bmc/.../mac_address
 Date:		January 2021
 KernelVersion:  5.12
-Contact:	Peter Colberg <peter.colberg@altera.com>
+Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
 Description:	Read only. Returns the first MAC address in a block
 		of sequential MAC addresses assigned to the board
 		that is managed by the Intel MAX10 BMC. It is stored in
@@ -28,7 +28,7 @@ Description:	Read only. Returns the first MAC address in a block
 What:		/sys/bus/.../drivers/intel-m10-bmc/.../mac_count
 Date:		January 2021
 KernelVersion:  5.12
-Contact:	Peter Colberg <peter.colberg@altera.com>
+Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
 Description:	Read only. Returns the number of sequential MAC
 		addresses assigned to the board managed by the Intel
 		MAX10 BMC. This value is stored in FLASH and is mirrored
diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
index c69fd3894eb4..3a6ca780c75c 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
@@ -1,7 +1,7 @@
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/sr_root_entry_hash
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Peter Colberg <peter.colberg@altera.com>
+Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
 Description:	Read only. Returns the root entry hash for the static
 		region if one is programmed, else it returns the
 		string: "hash not programmed".  This file is only
@@ -11,7 +11,7 @@ Description:	Read only. Returns the root entry hash for the static
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/pr_root_entry_hash
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Peter Colberg <peter.colberg@altera.com>
+Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
 Description:	Read only. Returns the root entry hash for the partial
 		reconfiguration region if one is programmed, else it
 		returns the string: "hash not programmed".  This file
@@ -21,7 +21,7 @@ Description:	Read only. Returns the root entry hash for the partial
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/bmc_root_entry_hash
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Peter Colberg <peter.colberg@altera.com>
+Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
 Description:	Read only. Returns the root entry hash for the BMC image
 		if one is programmed, else it returns the string:
 		"hash not programmed".  This file is only visible if the
@@ -31,7 +31,7 @@ Description:	Read only. Returns the root entry hash for the BMC image
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/sr_canceled_csks
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Peter Colberg <peter.colberg@altera.com>
+Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
 Description:	Read only. Returns a list of indices for canceled code
 		signing keys for the static region. The standard bitmap
 		list format is used (e.g. "1,2-6,9").
@@ -39,7 +39,7 @@ Description:	Read only. Returns a list of indices for canceled code
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/pr_canceled_csks
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Peter Colberg <peter.colberg@altera.com>
+Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
 Description:	Read only. Returns a list of indices for canceled code
 		signing keys for the partial reconfiguration region. The
 		standard bitmap list format is used (e.g. "1,2-6,9").
@@ -47,7 +47,7 @@ Description:	Read only. Returns a list of indices for canceled code
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/bmc_canceled_csks
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Peter Colberg <peter.colberg@altera.com>
+Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
 Description:	Read only. Returns a list of indices for canceled code
 		signing keys for the BMC.  The standard bitmap list format
 		is used (e.g. "1,2-6,9").
@@ -55,7 +55,7 @@ Description:	Read only. Returns a list of indices for canceled code
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/flash_count
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Peter Colberg <peter.colberg@altera.com>
+Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
 Description:	Read only. Returns number of times the secure update
 		staging area has been flashed.
 		Format: "%u".
diff --git a/MAINTAINERS b/MAINTAINERS
index 3f60ff1957b0..9d22c4015e67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11833,7 +11833,7 @@ F:	drivers/mfd/intel-m10-bmc*
 F:	include/linux/mfd/intel-m10-bmc.h
 
 INTEL MAX10 BMC SECURE UPDATES
-M:	Peter Colberg <peter.colberg@altera.com>
+M:	Matthew Gerlach <matthew.gerlach@altera.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
-- 
2.48.1


