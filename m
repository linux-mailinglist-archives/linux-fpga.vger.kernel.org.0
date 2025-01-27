Return-Path: <linux-fpga+bounces-1021-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EA4A1DD40
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Jan 2025 21:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F92016587A
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Jan 2025 20:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8824185B76;
	Mon, 27 Jan 2025 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="NGHmTixB"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7876B64A;
	Mon, 27 Jan 2025 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738009014; cv=fail; b=nnfwlGSa30msS2XZQqGW5s+auqFt7x8f0qotZ0rvKOr1WBSFHCvPSdJMwgjPrMqiGwJy1ZKP8V2uBBwIMW5hj9o1O8L6fCEExlYItlP7I/jWC8hyQ9lUKYZD+ycJMCp7xp8LhpRqDZkk6duT8rsxTywgqHzew84VoQlGfphAU0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738009014; c=relaxed/simple;
	bh=yqaBm6kFw3wytTdRzW4ZSTZofz1ub8F17qhouEXKedg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=icp13Cipx6mffDwrC0qXM4RWqJFkIeN5njgen8ynXc1ks0um21vTBhoNwZ8OJEXtM6x4c8XY57tl05PheOSDGSXEc8l6v5oyFUXoRm17nI2MsqOTKUgDzW7KfOmgXIhJsRStaHpSy9xqd5+I4DTo5nHFF1G1uP/83lntRdZM/SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=NGHmTixB; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSvuDaGKcClVp+pbmq4DGwfj3Zgygll/T770DKoReUp24I71UkyiNhMuQdaKwTXGDK5XMBVtJjg7AjLEtV+polatbuNiZF0Dq1d0SpU5WpL2i4MzDtO+zDDeWBp4b8RTz+IHos6qLpK+vR+Ia+lk+2F73RTc+sDFSDT1cWT2dIlgIGY8p1VtLRMt0FSfHSW6E9Sjr84NHxMiPzRCkh5HV7jaybgfGuPHFbGAL0QbJxuvIN/plnv2afeF8Cpe9aqJlfsmztC5FYGh05ru3omRxqQKAXIrRH+5nTCJH4Ybhjo6yU5Asm3Fv8AweiuMFli7elhopwwHjjApzKW8SF/4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG3WFNhb1l6gCqwSJQEHpPGmbN/p/Ge9BJAC9ZsrNhE=;
 b=TZS7yAPw8QWAPKVFl45SRyafEuGWRu4cHMklaXKrICuOH3WGZ6U/r9NS8YDiY5AGf3u6VLpW9/7kQDY9wM7T3n+QQyxpHKKK0tSibPf3txKUWQWsjGl4oCnat+/R9SvdZjkYrL+akdpbGGodSvZE87nDUReKvfMobfc+HHOu/KAeTUDDo9HMFcLwn86t+X4baGnUNBEVqZ3WtOzI1SM8rS135fwGjGgUCU5NQY9f5nT3ewFIgjumRs+KC1jNnkHJhTX4Oeo6V1RGqLv3TW99nJJAXN99m6JmKe727lVLDZgwLbDVJJa7kUtZgMuwBrCTy/Zstx7UiggyOvmG9DU47A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG3WFNhb1l6gCqwSJQEHpPGmbN/p/Ge9BJAC9ZsrNhE=;
 b=NGHmTixBwHS36qempgK2iBf8haBZfwI0dPOAZ9BhMKZdC4jcHrBu+ljs24bVvarEItzHTxyZVeuVVpWpc+HQJwAukO5lLnbHFS+O/j+VgzHsBpiJ4GWgdfr8A25+WnfXhiqcqchzUUOQ5IEj6hGPv1Y7NbqJWyv6PJ0XXdRqRVouOiaXILZRaFBmpID1/0nO4zJOk9VWGxv+Adg3bV21NieZxy1FG1PqSyjSpO+0VBZzL9zQGUzkyZfTIJr9K329mhbmGTUpoNviXUm83qwH0HS+y+cqK/XcociAiWu8FumfC7x1H6FuomxUiMiMRfpleTLRL+6L6nUkatv4zfugng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH0PR03MB6220.namprd03.prod.outlook.com (2603:10b6:510:ef::12)
 by SA3PR03MB7372.namprd03.prod.outlook.com (2603:10b6:806:37d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Mon, 27 Jan
 2025 20:16:48 +0000
Received: from PH0PR03MB6220.namprd03.prod.outlook.com
 ([fe80::6f4a:f9df:de2a:2921]) by PH0PR03MB6220.namprd03.prod.outlook.com
 ([fe80::6f4a:f9df:de2a:2921%3]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 20:16:48 +0000
From: Peter Colberg <peter.colberg@altera.com>
To: Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Cc: Peter Colberg <peter.colberg@intel.com>,
	Peter Colberg <peter.colberg@altera.com>
Subject: [PATCH] fpga: m10bmc-sec: update email address for Peter Colberg
Date: Mon, 27 Jan 2025 15:16:34 -0500
Message-ID: <20250127201634.17097-1-peter.colberg@altera.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:a03:114::33) To PH0PR03MB6220.namprd03.prod.outlook.com
 (2603:10b6:510:ef::12)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB6220:EE_|SA3PR03MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 8470113f-f32f-4cea-6e11-08dd3f0f877a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RE39FQga35NvxEjrOaMC+mDiTITl0NAvN1QBfZa2NVL7b8+kIgt137bFy/0G?=
 =?us-ascii?Q?5MNlCiRnVI8zDUdHq3lDnMQ9utMk+Z4HBSSIqOs7/LG89NS4Rt4IL+jPZ4MF?=
 =?us-ascii?Q?Nh/K+Sv/kmskNqDzc+g1qLCxcq2Q5P6BAE01OnliFwmTUC5kRUcSbkTuTNvH?=
 =?us-ascii?Q?8l+H4hTKwsSNnnFzPo2bmOFp7NQWTorBrtLv1yoDarClfAJbVPl7B40NK+tE?=
 =?us-ascii?Q?Ae35tiOFDbBfAALrjOjAHPbCIssvmbixwc2RoGlgqVSZ+u3dInliKigE+QTD?=
 =?us-ascii?Q?gNtrx+lDbw1+bONXIa+bU0S42aw68Z0xvv05DaWxFB1iTwjd4cej6fFC9GDE?=
 =?us-ascii?Q?xlXlXLjfxfNdxl26urQyYXo08OBrALDNwLyYD8BLlqySb+dtkvsveXkhh4a7?=
 =?us-ascii?Q?RhFRro44f0MukivRh0S/+B6h5hbVBebZIfV/c9SofeuI1Cv3xWOMzs7OdyUN?=
 =?us-ascii?Q?IWsmEgmg73cQP3mrdHY92rqNdnaK/MhmlFfxSByd/8Ii3MKGOowYCeTM87lE?=
 =?us-ascii?Q?J3wwgNRRSR6+TdRp9/CxzWbzAkXlqgpQno2UC8XkqT6PBZ//Tg4GrajqhSJf?=
 =?us-ascii?Q?9lt5WQhnOURJ46Caz1qcSuT+d0FIA3yjtLkS5+enbUynKPs6ZXjvuey/cWAZ?=
 =?us-ascii?Q?TGgn9/yMPKDhGLkWj7ch8ItmjBjnBBmAgbbB1K1tiSIylKM/QMj744ihEReJ?=
 =?us-ascii?Q?5HBp/vcTpaaoFxHWM/A3RNczi5vI/5KWa1VO09XNZSeBOfD1MqvOaxvqCE9G?=
 =?us-ascii?Q?6D9J/8bu0wKT76/55OqKQuJn5v2Z/5fBGbAbHsIqyd2nBXzwyO/71cVfU9Dz?=
 =?us-ascii?Q?GUefBxAsJDIgf3SVjzeoY/a4J+EUjW31GzLcQEqUzsR6pydTgX032/B9SAoW?=
 =?us-ascii?Q?eydUB2kisdRj06fTmRPXHYsvE9pkwihXyieoDKLen9VgqBNvKDNW4tgcmbqk?=
 =?us-ascii?Q?jRzAwEwL5Gt+bm44fMoV4Ex2c+c/m9XKfSighzACia0C9BY4m/jkZMDqjlRy?=
 =?us-ascii?Q?kv3HQTO2zMW/vWx+P2m20h3XhL0wftittAENfMc4S6drytMCOd2iSWtJNd+B?=
 =?us-ascii?Q?wUO4P0IfupySL4K7NDzUGU5Lqaim7fMmp6VqtLON73UxlUOEkRKjuLvU1CRz?=
 =?us-ascii?Q?d30bZbn7LNSrjg2n3BO0JQmRSJ2MIpcYXc91rqxv4zzpQJWr9ujdm21dlnta?=
 =?us-ascii?Q?hx84+yxw3pmZKBrEsbafSS958cJ7BU9tjUsFQ7BI1WiecFQKsT+/+BFHwPDu?=
 =?us-ascii?Q?66MPEbTrpT8/0A4byCQlk5s6WdEuq0kvjHIaLbOcg1rSxTDMSMyLa+lLkeyB?=
 =?us-ascii?Q?l/SieX1zLtHwIf5JsYM0+kPsHWH1sN6RawMRQqHZr5m2Is4aB5mSMrY7uJ8I?=
 =?us-ascii?Q?Py5n9oDg0OxlDrYP8HXJ4FgnRW3N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6220.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SMNJWOEDJ3JbBlS1Ac2EXCzKYeYl7Hg2hlFy6aPrVzhBlIoguBzxSUFjcGKN?=
 =?us-ascii?Q?yn1lt4q+k9Zrlf+dtoL8X31r8nkrlBopwVWG6ae1V7Q/a3SJ2dvtz5PD+aHV?=
 =?us-ascii?Q?u1dqXfZ1Qf3SsRfVgcsuEJZu+ltWzARGnYXelPoJVlujbizJsjPsvjS65mOk?=
 =?us-ascii?Q?6Vc0dwnliaRZkKM2i9FmCkZt3XPzsIxW7CYj0J+bHkowv4W4abXFJwMF8o8I?=
 =?us-ascii?Q?xa/2OD5JYaeDJWLg7qfKjc+0nVvGr9d8qaceQRGQH+yowqZ6aJp+j+7bLLF3?=
 =?us-ascii?Q?qcSaq7IoXTmYPeEqjAmjF8eV2FYxIQNnGWGri5y9Cp2hR9GUV8NrYikp5q16?=
 =?us-ascii?Q?nZ3Ndl+1dqRUdX5mXfS4hV0XNDkInSLwXlsxnS4nlvq7QzN5ew3j4joWiyQy?=
 =?us-ascii?Q?o3dePHmNNTSIRCjI5tetFGSxkhC3BQqJ+ZQ8K1LdgG0K6KpQATOhgM8obcar?=
 =?us-ascii?Q?zegFgwa11VNrVgDmY+/fsztd9Uimkz4VFc19fIgQrTofWeXDaX4vVcuXUsNB?=
 =?us-ascii?Q?cT0yZ1cXGZXsfJfRBAxp140X/UCB+qQXKd+3xY3MNjr8B6kf7lZKXqbEhmkV?=
 =?us-ascii?Q?tTn7Kttn3RpZilMGXwvO+0Ebd5JYJ3z99ya+ore6QnUxMd26fk02ynE8QDXD?=
 =?us-ascii?Q?4p4iKhFV/Tlyyw6Rsv6S/VXTQXNWKBuW3qVxphNN5Bc4fH3msGB6pvFSwotN?=
 =?us-ascii?Q?CKY0/rOM0l04UyWrmuyxeA2vAhu4wTM93Rppj6pXwoiVrg4ZQwqybHpbkFPJ?=
 =?us-ascii?Q?/KWQwHTOjWb8USSbtXT2X6RNfEztvak/RkdunjIyHUZCRwnrlfsdmGxdsw09?=
 =?us-ascii?Q?LP43c/3k1dKaQxtZ+0awJjfxR0itL1mUS0ZJtmUs60CBm8LfGWJnHuS8FPFE?=
 =?us-ascii?Q?il7FG+2gEtSO03KuQlwp6i4FpD/y5lrMBTGJWfl8ZdRQMt9/utofP4BYRWqw?=
 =?us-ascii?Q?VeMZArRoSpxZnBqIi2/mUt6N4OcZxvfo+MopFhSDq9qit+sBnmKyY8p0VvkM?=
 =?us-ascii?Q?F21ZfgbSNaGxZNhyYtHkExqQJkFXYdiqa74uxeTse0pGADSdeLLOk5fBUK94?=
 =?us-ascii?Q?JEgWEyV0y2K+8775yX9szq5zW4F/i37MzdovPq5OSK9//XADmrsIaT5x6eWY?=
 =?us-ascii?Q?GPqJrJ2ZiI+f1PJMqfJDH3yswcjxtUQigbkyyvzxGVhUnex7PE9ZWoODDiLh?=
 =?us-ascii?Q?nAV4D4WvXcWW2ZioC1vhuITZ1UmwzVovuFFHO4PcOztPviAdd1YCAEgy+w2n?=
 =?us-ascii?Q?wXxDq/Uz3ecUNDAJAcHvtV6NWYJhwkfsUpc1efePYJ6H3gOx4dv6Ad7x+je3?=
 =?us-ascii?Q?mrfvW193+LbZTnFdxqiUaiilvdbOsOqJ+JHxOg3d/6Yt/pALQ3PguFztflR5?=
 =?us-ascii?Q?jXEVxHIztE93B9UppSs6ZkC2p9zww93JJLgZg8s+Z8zYFtrNN+l4GZy5l4q+?=
 =?us-ascii?Q?twXa81tf/WbiDB2phw6OrmAG2I9szWF3VUjtkpxPXaZK3VCuW048YQwG4yDF?=
 =?us-ascii?Q?BxN8tbpNmGDgnQcg2vW8nkHiUqxjRvjgUBKBjJKKfFZO6axo9bYwq9/lAHO/?=
 =?us-ascii?Q?uqjZvq0SJX2EJud4j6BS5RH5ElRS1dkuSrBXs1XapL2Cq5Iboq9vMYVi+Blf?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8470113f-f32f-4cea-6e11-08dd3f0f877a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6220.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 20:16:48.8166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goQ+RfRrFHhPiFf9ov1BstFp+MsaeU8+ZuBKOsiIGEK+bUpie4Bbv6W7PuFujZH1SgVKZhG+mCG2emjBTDWu7rQJhcfZE3l1nJC7DdNPmnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7372

Update my email address after Altera became a subsidiary of Intel on
January 1, 2025.

Signed-off-by: Peter Colberg <peter.colberg@altera.com>
---
 .../ABI/testing/sysfs-driver-intel-m10-bmc         |  4 ++--
 .../testing/sysfs-driver-intel-m10-bmc-sec-update  | 14 +++++++-------
 MAINTAINERS                                        |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
index c12316dfd973..a6e400364932 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
@@ -17,7 +17,7 @@ Description:	Read only. Returns the firmware version of Intel MAX10
 What:		/sys/bus/.../drivers/intel-m10-bmc/.../mac_address
 Date:		January 2021
 KernelVersion:  5.12
-Contact:	Peter Colberg <peter.colberg@intel.com>
+Contact:	Peter Colberg <peter.colberg@altera.com>
 Description:	Read only. Returns the first MAC address in a block
 		of sequential MAC addresses assigned to the board
 		that is managed by the Intel MAX10 BMC. It is stored in
@@ -28,7 +28,7 @@ Description:	Read only. Returns the first MAC address in a block
 What:		/sys/bus/.../drivers/intel-m10-bmc/.../mac_count
 Date:		January 2021
 KernelVersion:  5.12
-Contact:	Peter Colberg <peter.colberg@intel.com>
+Contact:	Peter Colberg <peter.colberg@altera.com>
 Description:	Read only. Returns the number of sequential MAC
 		addresses assigned to the board managed by the Intel
 		MAX10 BMC. This value is stored in FLASH and is mirrored
diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
index 9051695d2211..c69fd3894eb4 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
@@ -1,7 +1,7 @@
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/sr_root_entry_hash
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Peter Colberg <peter.colberg@intel.com>
+Contact:	Peter Colberg <peter.colberg@altera.com>
 Description:	Read only. Returns the root entry hash for the static
 		region if one is programmed, else it returns the
 		string: "hash not programmed".  This file is only
@@ -11,7 +11,7 @@ Description:	Read only. Returns the root entry hash for the static
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/pr_root_entry_hash
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Peter Colberg <peter.colberg@intel.com>
+Contact:	Peter Colberg <peter.colberg@altera.com>
 Description:	Read only. Returns the root entry hash for the partial
 		reconfiguration region if one is programmed, else it
 		returns the string: "hash not programmed".  This file
@@ -21,7 +21,7 @@ Description:	Read only. Returns the root entry hash for the partial
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/bmc_root_entry_hash
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Peter Colberg <peter.colberg@intel.com>
+Contact:	Peter Colberg <peter.colberg@altera.com>
 Description:	Read only. Returns the root entry hash for the BMC image
 		if one is programmed, else it returns the string:
 		"hash not programmed".  This file is only visible if the
@@ -31,7 +31,7 @@ Description:	Read only. Returns the root entry hash for the BMC image
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/sr_canceled_csks
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Peter Colberg <peter.colberg@intel.com>
+Contact:	Peter Colberg <peter.colberg@altera.com>
 Description:	Read only. Returns a list of indices for canceled code
 		signing keys for the static region. The standard bitmap
 		list format is used (e.g. "1,2-6,9").
@@ -39,7 +39,7 @@ Description:	Read only. Returns a list of indices for canceled code
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/pr_canceled_csks
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Peter Colberg <peter.colberg@intel.com>
+Contact:	Peter Colberg <peter.colberg@altera.com>
 Description:	Read only. Returns a list of indices for canceled code
 		signing keys for the partial reconfiguration region. The
 		standard bitmap list format is used (e.g. "1,2-6,9").
@@ -47,7 +47,7 @@ Description:	Read only. Returns a list of indices for canceled code
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/bmc_canceled_csks
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Peter Colberg <peter.colberg@intel.com>
+Contact:	Peter Colberg <peter.colberg@altera.com>
 Description:	Read only. Returns a list of indices for canceled code
 		signing keys for the BMC.  The standard bitmap list format
 		is used (e.g. "1,2-6,9").
@@ -55,7 +55,7 @@ Description:	Read only. Returns a list of indices for canceled code
 What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/flash_count
 Date:		Sep 2022
 KernelVersion:	5.20
-Contact:	Peter Colberg <peter.colberg@intel.com>
+Contact:	Peter Colberg <peter.colberg@altera.com>
 Description:	Read only. Returns number of times the secure update
 		staging area has been flashed.
 		Format: "%u".
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..9ace999bee62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11729,7 +11729,7 @@ F:	drivers/mfd/intel-m10-bmc*
 F:	include/linux/mfd/intel-m10-bmc.h
 
 INTEL MAX10 BMC SECURE UPDATES
-M:	Peter Colberg <peter.colberg@intel.com>
+M:	Peter Colberg <peter.colberg@altera.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
-- 
2.48.1


