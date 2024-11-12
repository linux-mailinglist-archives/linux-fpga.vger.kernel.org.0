Return-Path: <linux-fpga+bounces-931-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F689C4BBE
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Nov 2024 02:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D6EB26308
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Nov 2024 01:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D606204F6C;
	Tue, 12 Nov 2024 01:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hFEACH5H"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714720494B;
	Tue, 12 Nov 2024 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374976; cv=fail; b=Syt9LwF4wOZ9yTSqDgRyj6gTH2ryurIpmxgA3fKRbIjiAnF+gBgSFaj+k9Vampd1TEKPW75VovnxCx6fkznQKHf2IWAkF2JNTct6yFRB8rdhgQwfNzSA9WjsEfvvAlFBzm4y+LtH/ywcBXQ6rBRpoQSE5n2rSDBIoLMd66I4eto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374976; c=relaxed/simple;
	bh=7rlu1Mi/QJMrI2YuhhzoSBfa7pv7qCFoTuHXznCzCmw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=YOj+OsFfEEZHQZUn67DwVqz0bsLYqzw7wUWNkjBQtn8mBqbFvnB+rhWftkAA5dxkglg/STkffHUiRukLgqmRGK3OwiMq0dkeW3KQad3RgPP0Zp++sMaWNv6TJdhbSnsVauhHXbHsHWNfccBfz33eK3hvTm09HQq2gJIqlIhxPzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hFEACH5H; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9j1xXE0Kh5nKz8gxPnXyMZiwdYoC6F8Z7kT09l7bFqoHHkfSuNWigDoG4xYva/Vff59rQ5NhoagQNo+WnjHPF/2oSC7ealsTZ2t7FGEYlZrfFSDrp+JNiGKuEV8moxNMxHRHHRPekS4phJ2SdzrucNk3lzA0YMgCE22HP9SxQ7NDMpubvs0YfyiFPIRxg7B1u/LoQrwHLPpFllh9jD8J46YqvgtQYf5OyyqN83X2SBQUx9oqJSZ4G1jup7LJkAUVHX92BngDxRwjkXl6TeptsR1YmNXsP1W3VyExpvF9aTWsq8xilQ+mhGU2iPNjX7A7ffrfwCSapkvSwAOIZFMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRQXWaVm5zhLzvKyb/HConRXKKWu+ZUX5GYeB/QxXk0=;
 b=Ug2uwYwY+TDwxckM9kA+Lrl/+alL+ApZeGaPzNPEZoW4DnftDEOrrqhVwZLPySnlxMltKsE7c0ZpgYP0Mt23Ax1PCWczmUyzPu4bNH4JDrCtX6TlHN0m3oa5pZaVmoifRKdq2PquqooLbNMj4AwOEVoUUdiUWhPd7hye4JH7cg7fIdng3eFY0GcvG319Y0EVJiRZU4oi2GFBPuyOIHoerF/BMEaitVHiQv20Wi9vyxUUy7Ntrro1vJlRRPNSVA01zPrxUdtYRwdWGopbh4WUT1MGlhsUgoNvzSvezv/ALPfGwf8Q3NQYM6o9VRyN+6mKIfs9fWmcZvYP2pMynKMOcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRQXWaVm5zhLzvKyb/HConRXKKWu+ZUX5GYeB/QxXk0=;
 b=hFEACH5Hdr8KQhaOtO42cKZ70wGTJ7k4x/HYFZ4meCA1lWuMhI9mGRKen/0tgo0Bx+pxUS8iI/02UKl7cCDoteWO792VnmazUzC2sywuxxujw5oMG2a8v4sB6IUd40W78kgrxLp2Wlm+tS0bcvUWrdDUUOfcw2LMVdeGnGOZius=
Received: from SJ0PR03CA0199.namprd03.prod.outlook.com (2603:10b6:a03:2ef::24)
 by SJ1PR12MB6122.namprd12.prod.outlook.com (2603:10b6:a03:45b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Tue, 12 Nov
 2024 01:29:29 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::55) by SJ0PR03CA0199.outlook.office365.com
 (2603:10b6:a03:2ef::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 01:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 01:29:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 19:29:27 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 19:29:27 -0600
Received: from [172.19.74.143] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Nov 2024 19:29:26 -0600
Message-ID: <eb794a9b-3b79-44f5-80b3-cc4db84450b2@amd.com>
Date: Mon, 11 Nov 2024 17:29:26 -0800
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yidong Zhang <yidong.zhang@amd.com>
Subject: Re: [PATCH V1 2/3] drivers/fpga/amd: Add communication with firmware
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
	<lizhi.hou@amd.com>, Nishad Saraf <nishads@amd.com>, Prapul Krishnamurthy
	<prapulk@amd.com>, <yidong.zhang@amd.com>
References: <20241007220128.3023169-1-yidong.zhang@amd.com>
 <20241007220128.3023169-2-yidong.zhang@amd.com>
 <ZxIYMJ3uwHwvxmh+@yilunxu-OptiPlex-7050>
Content-Language: en-US
In-Reply-To: <ZxIYMJ3uwHwvxmh+@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: yidong.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|SJ1PR12MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: b117cea6-66ff-452c-66c3-08dd02b97387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2lyTlVIL3FVV2RIbUI0bksxcG9jc2lwN3NhMTBzd0V0VVJCK2FrUHREZk9X?=
 =?utf-8?B?MzZQVG1ibFQ3d2RCRVFmWUl1Y0crQVBBYS9HdnhhUzI5amNBSjFIZE42ck1P?=
 =?utf-8?B?MWM3Y25xV2ZRbGZucEZxWUxReVl0SXNTNkNUOEt5bEJBbVBabFpGcktqRXRP?=
 =?utf-8?B?ajBPcXZISXRWS0JGamMvc3QzS3FIa210bGRiZFR1RFdsT3hvVm5xazI0by9j?=
 =?utf-8?B?aE5rZ204NzJxS0FGU1hwRGxneUtIM01MZndLYnhIeTcxNjBCc2JKYXFocHl5?=
 =?utf-8?B?UkpNa01qalpyUHZkTjlrZjJwSWFoN3pWcUNkaUQ5VWMya0xNWUl5NjV3TGta?=
 =?utf-8?B?NC9CejRYeXBIdjdTRGtTTm5UOVR4eUViSllvQ0FWdjRudjRjcEZ6YjJqTmty?=
 =?utf-8?B?eFozd0Q2L0I5NWhxLzFicTFlNkZWc1gwMWREQWUxZHpKV2x0aU1TajNvREJS?=
 =?utf-8?B?endZcGJzNlM2OGNtNTV4Y2IxVmlQcGtBODlYbzF1UHQ1bGhJQmsvUlFZaTRB?=
 =?utf-8?B?d0tvWlE4bmlmMGE1MUltMkZlQ05tNDhmMC9VWGF4a2dQWWZMc0JHU1RGWW4z?=
 =?utf-8?B?Qy9NMDR1YU9KSE5vamw4WXp0eHNPYmswR0E4Uy9EWmlBMWxoMUhIWGhocklZ?=
 =?utf-8?B?NWtCL2dmSW85TXVDVXhTV3BmaUZ3V2FBbUhFZXRmVWtOL3VudUM2elF1MzAv?=
 =?utf-8?B?TjhtRjN4Y1FhNXJVWW05OU1wbHE5Q1ZXSmV2akIrTVRGaDdwRytvZU05WGVI?=
 =?utf-8?B?bTJRWCswVFpiMklNdHBnL0ZDSFI1NHM5SnQrL0xwaURyem1mQUNUVklaMnBu?=
 =?utf-8?B?ZjZjL1lsTGpZU1pMM1hoYXNOZE4xWDloTkxNWnFkdzNKVFFTeGw2TmFOTHVh?=
 =?utf-8?B?WCtHV1lOSmNibGZLa2lkalJ5ZXpWN3Eydmx0T1ZpR3lDVWlOTW5pSjFsQU56?=
 =?utf-8?B?eU5BOTNuaU1xcHA1VnQrdFVZTEg0ak9oc0lmSzdXTVdTY3owQXdXNFpHYVlC?=
 =?utf-8?B?dzlveFFTQXBOM2VXaXJYUWhNKzlkL3J3c2d3d2lHbFFjbXlqZWpqZElwWnpl?=
 =?utf-8?B?eFRaNmovVlhydHlQaTU2Q0lFaEZFaG95cHYrTkE1VFVqTGR3dG1WRDhJZUM1?=
 =?utf-8?B?ZStEWEV6UkQ1S1RmTkZNUVNGUWxybkhxdjNYK2twbldQSnA4aGVSM291OGcz?=
 =?utf-8?B?VHVrTWphWFBsZk5aRDdHdG9pdDBkRHVlNUR4Tm5MNUkwSnJYQllzaFFlcnBQ?=
 =?utf-8?B?L0FIU1h6N25yVm1YYXdBY2ZXSjlPOVVIRjJ1NmVXanpyK0owMWNXd3Q4b0pD?=
 =?utf-8?B?NFFkRXhLaGpXVGR4Z0pHa1phOEpDUDJjelpMV1NuRFNVRFJxbG9WUW51anpX?=
 =?utf-8?B?NFdNSEkraWVvT292TjZZdEpPL1NRY2Z0UlVsR0Z3ZVVZRUVRNExpeU50bm1U?=
 =?utf-8?B?Z2ZKSExNUjZLcCtUNmlEYXpaWUZlNTBnZm5FUEhyNEMrVUFNcmxialpxZFF3?=
 =?utf-8?B?N211Rkg0TWV4bEFCVWFnNldzSk41OTVTNUZPMVl1eHNUV2ZxWmIvelpoc0hU?=
 =?utf-8?B?R0h5VTM3SnhCcUZXNDhXbFNYUkc0aXJWNWE3Rnl2S0h4TXJtU1k1LytVT2Vp?=
 =?utf-8?B?MkcwRHNROHBkbWlwUHRtNWFQdDY0WDJSS1l6MzFNTXpwdjJOQkpwb2ljU3lH?=
 =?utf-8?B?L2VwbTM1WlRlUXd1aFE1clVqMURSeVpWUDBackJnMDIreSthbWpDbEJrL2RP?=
 =?utf-8?B?azEzaEhXUm45KzBEWGhyZ0VWcE0zRjlIWFpvdDV6K3Nod0JRSHdCbGQveGVH?=
 =?utf-8?B?SUU1dGIyYjllckFrS1R0WXpKbmFVcWErTk9kWTlwekQ2UElpWEIzb0prTGpX?=
 =?utf-8?B?YjRSSHd1bmVXVGdyL1k3SW00UGk5OWVQODV1QTdkOUhuZ2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 01:29:28.5374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b117cea6-66ff-452c-66c3-08dd02b97387
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6122



On 10/18/24 01:11, Xu Yilun wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Mon, Oct 07, 2024 at 03:01:27PM -0700, David Zhang wrote:
>> From: Yidong Zhang <yidong.zhang@amd.com>
>>
>> Add queue based communication between host driver and firmware on the
>> card. The remote queue (rm) can send/receive messages and providing
> 
> Abbrevate 'remote queue' to 'rm', or 'remote' to 'rm'. I see you use
> rm_queue in the code.

I will fix it.

> 
>> firmware downloading services.
>>
>> Co-developed-by: Nishad Saraf <nishads@amd.com>
>> Signed-off-by: Nishad Saraf <nishads@amd.com>
>> Co-developed-by: Prapul Krishnamurthy <prapulk@amd.com>
>> Signed-off-by: Prapul Krishnamurthy <prapulk@amd.com>
>> Signed-off-by: Yidong Zhang <yidong.zhang@amd.com>
>> ---
>>   drivers/fpga/amd/Makefile         |   6 +-
>>   drivers/fpga/amd/vmgmt-rm-queue.c |  38 +++
>>   drivers/fpga/amd/vmgmt-rm-queue.h |  15 +
>>   drivers/fpga/amd/vmgmt-rm.c       | 543 ++++++++++++++++++++++++++++++
>>   drivers/fpga/amd/vmgmt-rm.h       | 222 ++++++++++++
>>   drivers/fpga/amd/vmgmt.c          | 305 ++++++++++++++++-
>>   drivers/fpga/amd/vmgmt.h          |   7 +-
>>   7 files changed, 1130 insertions(+), 6 deletions(-)
>>   create mode 100644 drivers/fpga/amd/vmgmt-rm-queue.c
>>   create mode 100644 drivers/fpga/amd/vmgmt-rm-queue.h
>>   create mode 100644 drivers/fpga/amd/vmgmt-rm.c
>>   create mode 100644 drivers/fpga/amd/vmgmt-rm.h
>>
>> diff --git a/drivers/fpga/amd/Makefile b/drivers/fpga/amd/Makefile
>> index 3e4c6dd3b787..97cfff6be204 100644
>> --- a/drivers/fpga/amd/Makefile
>> +++ b/drivers/fpga/amd/Makefile
>> @@ -2,5 +2,7 @@
>>
>>   obj-$(CONFIG_AMD_VERSAL_MGMT)                        += amd-vmgmt.o
>>
>> -amd-vmgmt-$(CONFIG_AMD_VERSAL_MGMT)          := vmgmt.o      \
>> -                                                vmgmt-comms.o
>> +amd-vmgmt-$(CONFIG_AMD_VERSAL_MGMT)          := vmgmt.o              \
>> +                                                vmgmt-comms.o        \
>> +                                                vmgmt-rm.o           \
>> +                                                vmgmt-rm-queue.o
>> diff --git a/drivers/fpga/amd/vmgmt-rm-queue.c b/drivers/fpga/amd/vmgmt-rm-queue.c
>> new file mode 100644
>> index 000000000000..fe805373ea32
>> --- /dev/null
>> +++ b/drivers/fpga/amd/vmgmt-rm-queue.c
>> @@ -0,0 +1,38 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for Versal PCIe device
>> + *
>> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/completion.h>
>> +#include <linux/err.h>
>> +#include <linux/firmware.h>
>> +#include <linux/idr.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/list.h>
>> +#include <linux/mutex.h>
>> +#include <linux/pci.h>
>> +#include <linux/semaphore.h>
>> +#include <linux/timer.h>
>> +#include <linux/uuid.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include "vmgmt.h"
>> +#include "vmgmt-rm.h"
>> +#include "vmgmt-rm-queue.h"
>> +
>> +int rm_queue_send_cmd(struct rm_cmd *cmd, unsigned long timeout)
>> +{
>> +     return 0;
>> +}
>> +
>> +void rm_queue_fini(struct rm_device *rdev)
>> +{
>> +}
>> +
>> +int rm_queue_init(struct rm_device *rdev)
>> +{
>> +     return 0;
>> +}
>> diff --git a/drivers/fpga/amd/vmgmt-rm-queue.h b/drivers/fpga/amd/vmgmt-rm-queue.h
>> new file mode 100644
>> index 000000000000..6fd0e0026a13
>> --- /dev/null
>> +++ b/drivers/fpga/amd/vmgmt-rm-queue.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Driver for Versal PCIe device
>> + *
>> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef __VMGMT_RM_QUEUE_H
>> +#define __VMGMT_RM_QUEUE_H
>> +
>> +int rm_queue_init(struct rm_device *rdev);
>> +void rm_queue_fini(struct rm_device *rdev);
>> +int rm_queue_send_cmd(struct rm_cmd *cmd, unsigned long timeout);
>> +
>> +#endif       /* __VMGMT_RM_QUEUE_H */
>> diff --git a/drivers/fpga/amd/vmgmt-rm.c b/drivers/fpga/amd/vmgmt-rm.c
>> new file mode 100644
>> index 000000000000..856d5af52c8d
>> --- /dev/null
>> +++ b/drivers/fpga/amd/vmgmt-rm.c
>> @@ -0,0 +1,543 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for Versal PCIe device
>> + *
>> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/completion.h>
>> +#include <linux/err.h>
>> +#include <linux/firmware.h>
>> +#include <linux/idr.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/list.h>
>> +#include <linux/mutex.h>
>> +#include <linux/pci.h>
>> +#include <linux/semaphore.h>
>> +#include <linux/timer.h>
>> +#include <linux/uuid.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include "vmgmt.h"
>> +#include "vmgmt-rm.h"
>> +#include "vmgmt-rm-queue.h"
>> +
>> +static DEFINE_IDA(rm_cmd_ids);
>> +
>> +static const struct regmap_config rm_shmem_regmap_config = {
>> +     .name = "rm_shmem_config",
>> +     .reg_bits = 32,
>> +     .reg_stride = 4,
>> +     .val_bits = 32,
>> +};
>> +
>> +static const struct regmap_config rm_io_regmap_config = {
>> +     .name = "rm_io_config",
>> +     .reg_bits = 32,
>> +     .reg_stride = 4,
>> +     .val_bits = 32,
>> +};
>> +
>> +static void rm_uninstall_health_monitor(struct rm_device *rdev);
>> +
>> +static inline struct rm_device *to_rdev_health_monitor(struct work_struct *w)
>> +{
>> +     return container_of(w, struct rm_device, health_monitor);
>> +}
>> +
>> +static inline struct rm_device *to_rdev_health_timer(struct timer_list *t)
>> +{
>> +     return container_of(t, struct rm_device, health_timer);
>> +}
>> +
>> +static inline int rm_shmem_read(struct rm_device *rdev, u32 offset, u32 *value)
>> +{
>> +     return regmap_read(rdev->shmem_regmap, offset, value);
>> +}
>> +
>> +static inline int rm_shmem_bulk_read(struct rm_device *rdev, u32 offset,
>> +                                  u32 *value, u32 size)
>> +{
>> +     return regmap_bulk_read(rdev->shmem_regmap, offset, value,
>> +                             DIV_ROUND_UP(size, 4));
>> +}
>> +
>> +static inline int rm_shmem_bulk_write(struct rm_device *rdev, u32 offset,
>> +                                   u32 *value, u32 size)
>> +{
>> +     return regmap_bulk_write(rdev->shmem_regmap, offset, value,
>> +                             DIV_ROUND_UP(size, 4));
>> +}
>> +
>> +void rm_queue_destory_cmd(struct rm_cmd *cmd)
>> +{
>> +     ida_free(&rm_cmd_ids, cmd->sq_msg.hdr.id);
>> +     kfree(cmd);
>> +}
>> +
>> +int rm_queue_copy_response(struct rm_cmd *cmd, void *buffer, ssize_t len)
>> +{
>> +     struct rm_cmd_cq_log_page *result = &cmd->cq_msg.data.page;
>> +     u64 off = cmd->sq_msg.data.page.address;
>> +
>> +     if (!result->len || len < result->len) {
>> +             vmgmt_err(cmd->rdev->vdev, "Invalid response or buffer size");
>> +             return -EINVAL;
>> +     }
>> +
>> +     return rm_shmem_bulk_read(cmd->rdev, off, (u32 *)buffer, result->len);
>> +}
>> +
>> +static void rm_queue_payload_fini(struct rm_cmd *cmd)
>> +{
>> +     up(&cmd->rdev->cq.data_lock);
>> +}
>> +
>> +static int rm_queue_payload_init(struct rm_cmd *cmd,
>> +                              enum rm_cmd_log_page_type type)
>> +{
>> +     struct rm_device *rdev = cmd->rdev;
>> +     int ret;
>> +
>> +     ret = down_interruptible(&rdev->cq.data_lock);
>> +     if (ret)
>> +             return ret;
>> +
>> +     cmd->sq_msg.data.page.address = rdev->cq.data_offset;
>> +     cmd->sq_msg.data.page.size = rdev->cq.data_size;
>> +     cmd->sq_msg.data.page.reserved1 = 0;
>> +     cmd->sq_msg.data.page.type = FIELD_PREP(RM_CMD_LOG_PAGE_TYPE_MASK,
>> +                                             type);
>> +     return 0;
>> +}
>> +
>> +void rm_queue_data_fini(struct rm_cmd *cmd)
>> +{
>> +     up(&cmd->rdev->sq.data_lock);
>> +}
>> +
>> +int rm_queue_data_init(struct rm_cmd *cmd, const char *buffer, ssize_t size)
>> +{
>> +     struct rm_device *rdev = cmd->rdev;
>> +     int ret;
>> +
>> +     if (!size || size > rdev->sq.data_size) {
>> +             vmgmt_err(rdev->vdev, "Unsupported file size");
>> +             return -ENOMEM;
>> +     }
>> +
>> +     ret = down_interruptible(&rdev->sq.data_lock);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = rm_shmem_bulk_write(cmd->rdev, rdev->sq.data_offset,
>> +                               (u32 *)buffer, size);
>> +     if (ret) {
>> +             vmgmt_err(rdev->vdev, "Failed to copy binary to SQ buffer");
>> +             up(&cmd->rdev->sq.data_lock);
>> +             return ret;
>> +     }
>> +
>> +     cmd->sq_msg.data.bin.address = rdev->sq.data_offset;
>> +     cmd->sq_msg.data.bin.size = size;
>> +     return 0;
>> +}
>> +
>> +int rm_queue_create_cmd(struct rm_device *rdev, enum rm_queue_opcode opcode,
>> +                     struct rm_cmd **cmd_ptr)
>> +{
>> +     struct rm_cmd *cmd = NULL;
>> +     int ret, id;
>> +     u16 size;
>> +
>> +     if (rdev->firewall_tripped)
>> +             return -ENODEV;
>> +
>> +     cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
>> +     if (!cmd)
>> +             return -ENOMEM;
>> +     cmd->rdev = rdev;
>> +
>> +     switch (opcode) {
>> +     case RM_QUEUE_OP_LOAD_XCLBIN:
>> +             fallthrough;
>> +     case RM_QUEUE_OP_LOAD_FW:
>> +             fallthrough;
>> +     case RM_QUEUE_OP_LOAD_APU_FW:
>> +             size = sizeof(struct rm_cmd_sq_bin);
>> +             break;
>> +     case RM_QUEUE_OP_GET_LOG_PAGE:
>> +             size = sizeof(struct rm_cmd_sq_log_page);
>> +             break;
>> +     case RM_QUEUE_OP_IDENTIFY:
>> +             size = 0;
>> +             break;
>> +     case RM_QUEUE_OP_VMR_CONTROL:
>> +             size = sizeof(struct rm_cmd_sq_ctrl);
>> +             break;
>> +     default:
>> +             vmgmt_err(rdev->vdev, "Invalid cmd opcode %d", opcode);
>> +             ret = -EINVAL;
>> +             goto error;
>> +     };
>> +
>> +     cmd->opcode = opcode;
>> +     cmd->sq_msg.hdr.opcode = FIELD_PREP(RM_CMD_SQ_HDR_OPS_MSK, opcode);
>> +     cmd->sq_msg.hdr.msg_size = FIELD_PREP(RM_CMD_SQ_HDR_SIZE_MSK, size);
>> +
>> +     id = ida_alloc_range(&rm_cmd_ids, RM_CMD_ID_MIN, RM_CMD_ID_MAX, GFP_KERNEL);
>> +     if (id < 0) {
>> +             vmgmt_err(rdev->vdev, "Failed to alloc cmd ID: %d", id);
>> +             ret = id;
>> +             goto error;
>> +     }
>> +     cmd->sq_msg.hdr.id = id;
>> +
>> +     init_completion(&cmd->executed);
>> +
>> +     *cmd_ptr = cmd;
>> +     return 0;
>> +error:
>> +     kfree(cmd);
>> +     return ret;
>> +}
>> +
>> +static int rm_queue_verify(struct rm_device *rdev)
>> +{
>> +     struct vmgmt_device *vdev = rdev->vdev;
>> +     struct rm_cmd_cq_identify *result;
>> +     struct rm_cmd *cmd;
>> +     u32 major, minor;
>> +     int ret;
>> +
>> +     ret = rm_queue_create_cmd(rdev, RM_QUEUE_OP_IDENTIFY, &cmd);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = rm_queue_send_cmd(cmd, RM_CMD_WAIT_CONFIG_TIMEOUT);
>> +     if (ret)
>> +             goto error;
>> +
>> +     result = &cmd->cq_msg.data.identify;
>> +     major = result->major;
>> +     minor = result->minor;
>> +     vmgmt_dbg(vdev, "VMR version %d.%d", major, minor);
>> +     if (!major) {
>> +             vmgmt_err(vdev, "VMR version is unsupported");
>> +             ret = -EOPNOTSUPP;
>> +     }
>> +
>> +error:
>> +     rm_queue_destory_cmd(cmd);
>> +     return ret;
>> +}
>> +
>> +static int rm_check_apu_status(struct rm_device *rdev, bool *status)
>> +{
>> +     struct rm_cmd_cq_control *result;
>> +     struct rm_cmd *cmd;
>> +     int ret;
>> +
>> +     ret = rm_queue_create_cmd(rdev, RM_QUEUE_OP_VMR_CONTROL, &cmd);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = rm_queue_send_cmd(cmd, RM_CMD_WAIT_CONFIG_TIMEOUT);
>> +     if (ret)
>> +             goto error;
>> +
>> +     result = &cmd->cq_msg.data.ctrl;
>> +     *status = FIELD_GET(RM_CMD_VMR_CONTROL_PS_MASK, result->status);
>> +
>> +     rm_queue_destory_cmd(cmd);
>> +     return 0;
>> +
>> +error:
>> +     rm_queue_destory_cmd(cmd);
>> +     return ret;
>> +}
>> +
>> +static int rm_download_apu_fw(struct rm_device *rdev, char *data, ssize_t size)
>> +{
>> +     struct rm_cmd *cmd;
>> +     int ret;
>> +
>> +     ret = rm_queue_create_cmd(rdev, RM_QUEUE_OP_LOAD_APU_FW, &cmd);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = rm_queue_data_init(cmd, data, size);
>> +     if (ret)
>> +             goto done;
>> +
>> +     ret = rm_queue_send_cmd(cmd, RM_CMD_WAIT_DOWNLOAD_TIMEOUT);
>> +
>> +done:
>> +     rm_queue_destory_cmd(cmd);
>> +     return ret;
>> +}
>> +
>> +int rm_boot_apu(struct rm_device *rdev)
>> +{
>> +     char *bin = "xilinx/xrt-versal-apu.xsabin";
> 
> So apu fw never changes, is it?

The APU FW does not change when the card is in service.
It works with the base shell FW together.

The location of the "*bin" does not change too.
The binary xsabin can be changed by installing a deb pkg

> 
>> +     const struct firmware *fw = NULL;
>> +     bool status;
>> +     int ret;
>> +
>> +     ret = rm_check_apu_status(rdev, &status);
>> +     if (ret) {
>> +             vmgmt_err(rdev->vdev, "Failed to get APU status");
>> +             return ret;
>> +     }
>> +
>> +     if (status) {
>> +             vmgmt_dbg(rdev->vdev, "APU online. Skipping APU FW download");
>> +             return 0;
>> +     }
>> +
>> +     ret = request_firmware(&fw, bin, &rdev->vdev->pdev->dev);
>> +     if (ret) {
>> +             vmgmt_warn(rdev->vdev, "Request APU FW %s failed %d", bin, ret);
>> +             return ret;
>> +     }
>> +
>> +     vmgmt_dbg(rdev->vdev, "Starting... APU FW download");
>> +     ret = rm_download_apu_fw(rdev, (char *)fw->data, fw->size);
>> +     vmgmt_dbg(rdev->vdev, "Finished... APU FW download %d", ret);
>> +
>> +     if (ret)
>> +             vmgmt_err(rdev->vdev, "Failed to download APU FW, ret:%d", ret);
>> +
>> +     release_firmware(fw);
>> +
>> +     return ret;
>> +}
>> +
>> +static void rm_check_health(struct work_struct *w)
>> +{
>> +     struct rm_device *rdev = to_rdev_health_monitor(w);
>> +     ssize_t len = PAGE_SIZE;
>> +     char *buffer = NULL;
>> +     struct rm_cmd *cmd;
>> +     int ret;
>> +
>> +     buffer = vzalloc(len);
>> +     if (!buffer)
>> +             return;
>> +
>> +     ret = rm_queue_create_cmd(rdev, RM_QUEUE_OP_GET_LOG_PAGE, &cmd);
>> +     if (ret)
>> +             return;
> 
> Memory Leak!

I will fix it.

> 
>> +
>> +     ret = rm_queue_payload_init(cmd, RM_CMD_LOG_PAGE_AXI_TRIP_STATUS);
>> +     if (ret)
>> +             goto error;
>> +
>> +     ret = rm_queue_send_cmd(cmd, RM_CMD_WAIT_CONFIG_TIMEOUT);
>> +     if (ret == -ETIME || ret == -EINVAL)
>> +             goto payload_fini;
>> +
>> +     if (cmd->cq_msg.data.page.len) {
> 
> If no data, the heath is good?

If not data and ret value is not ZERO, the health is not good.
The current FW guarrents that there will be always some data in this 
situation. I can add code like:
if (ret) {
   if (has data)
     printk(data);
   else
     printk(readable info based on ret value);
}

> 
>> +             ret = rm_queue_copy_response(cmd, buffer, len);
>> +             if (ret)
>> +                     goto payload_fini;
>> +
>> +             vmgmt_err(rdev->vdev, "%s", buffer);
> 
> Any concern reading out of bound.
> 
> If the buffer is only used in this block, put its allocation/free here.

Yes, I will move the buffer here.

> 
>> +             rdev->firewall_tripped = 1;
>> +     }
>> +
>> +     vfree(buffer);
>> +
>> +     rm_queue_payload_fini(cmd);
>> +     rm_queue_destory_cmd(cmd);
>> +
>> +     return;
>> +
>> +payload_fini:
>> +     rm_queue_payload_fini(cmd);
>> +error:
>> +     rm_queue_destory_cmd(cmd);
>> +     vfree(buffer);
>> +}
>> +
>> +static void rm_sched_health_check(struct timer_list *t)
>> +{
>> +     struct rm_device *rdev = to_rdev_health_timer(t);
>> +
>> +     if (rdev->firewall_tripped) {
>> +             vmgmt_err(rdev->vdev, "Firewall tripped, health check paused. Please reset card");
>> +             return;
>> +     }
>> +     /* Schedule a work in the general workqueue */
>> +     schedule_work(&rdev->health_monitor);
>> +     /* Periodic timer */
>> +     mod_timer(&rdev->health_timer, jiffies + RM_HEALTH_CHECK_TIMER);
> 
> Again, is it necessary we endless poll. Coundn't we check on cmd create?

The remote queue hardware only support polling mode.

> 
>> +}
>> +
>> +static void rm_uninstall_health_monitor(struct rm_device *rdev)
>> +{
>> +     del_timer_sync(&rdev->health_timer);
>> +     cancel_work_sync(&rdev->health_monitor);
>> +}
>> +
>> +static void rm_install_health_monitor(struct rm_device *rdev)
>> +{
>> +     INIT_WORK(&rdev->health_monitor, &rm_check_health);
>> +     timer_setup(&rdev->health_timer, &rm_sched_health_check, 0);
>> +     mod_timer(&rdev->health_timer, jiffies + RM_HEALTH_CHECK_TIMER);
>> +}
>> +
>> +void vmgmt_rm_fini(struct rm_device *rdev)
>> +{
>> +     rm_uninstall_health_monitor(rdev);
>> +     rm_queue_fini(rdev);
>> +}
>> +
>> +struct rm_device *vmgmt_rm_init(struct vmgmt_device *vdev)
>> +{
>> +     struct rm_header *header;
>> +     struct rm_device *rdev;
>> +     u32 status;
>> +     int ret;
>> +
>> +     rdev = devm_kzalloc(&vdev->pdev->dev, sizeof(*rdev), GFP_KERNEL);
>> +     if (!rdev)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     rdev->vdev = vdev;
>> +     header = &rdev->rm_metadata;
>> +
>> +     rdev->shmem_regmap = devm_regmap_init_mmio(&vdev->pdev->dev,
>> +                                                vdev->tbl + RM_PCI_SHMEM_BAR_OFF,
>> +                                                &rm_shmem_regmap_config);
>> +     if (IS_ERR(rdev->shmem_regmap)) {
>> +             vmgmt_err(vdev, "Failed to init RM shared memory regmap");
>> +             return ERR_CAST(rdev->shmem_regmap);
>> +     }
>> +
>> +     ret = rm_shmem_bulk_read(rdev, RM_HDR_OFF, (u32 *)header,
>> +                              sizeof(*header));
>> +     if (ret) {
>> +             vmgmt_err(vdev, "Failed to read RM shared mem, ret %d", ret);
>> +             ret = -ENODEV;
>> +             goto err;
>> +     }
>> +
>> +     if (header->magic != RM_HDR_MAGIC_NUM) {
>> +             vmgmt_err(vdev, "Invalid RM header 0x%x", header->magic);
>> +             ret = -ENODEV;
>> +             goto err;
>> +     }
>> +
>> +     ret = rm_shmem_read(rdev, header->status_off, &status);
>> +     if (ret) {
>> +             vmgmt_err(vdev, "Failed to read RM shared mem, ret %d", ret);
>> +             ret = -ENODEV;
>> +             goto err;
>> +     }
>> +
>> +     if (!status) {
>> +             vmgmt_err(vdev, "RM status %d is not ready", status);
>> +             ret = -ENODEV;
>> +             goto err;
>> +     }
>> +
>> +     rdev->queue_buffer_size = header->data_end - header->data_start + 1;
>> +     rdev->queue_buffer_start = header->data_start;
>> +     rdev->queue_base = header->queue_base;
>> +
>> +     rdev->io_regmap = devm_regmap_init_mmio(&vdev->pdev->dev,
>> +                                             vdev->tbl + RM_PCI_IO_BAR_OFF,
>> +                                             &rm_io_regmap_config);
>> +     if (IS_ERR(rdev->io_regmap)) {
>> +             vmgmt_err(vdev, "Failed to init RM IO regmap");
>> +             ret = PTR_ERR(rdev->io_regmap);
>> +             goto err;
>> +     }
>> +
>> +     ret = rm_queue_init(rdev);
>> +     if (ret) {
>> +             vmgmt_err(vdev, "Failed to init cmd queue, ret %d", ret);
>> +             ret = -ENODEV;
>> +             goto err;
>> +     }
>> +
>> +     ret = rm_queue_verify(rdev);
>> +     if (ret) {
>> +             vmgmt_err(vdev, "Failed to verify cmd queue, ret %d", ret);
>> +             ret = -ENODEV;
>> +             goto queue_fini;
>> +     }
>> +
>> +     ret = rm_boot_apu(rdev);
>> +     if (ret) {
>> +             vmgmt_err(vdev, "Failed to bringup APU, ret %d", ret);
>> +             ret = -ENODEV;
>> +             goto queue_fini;
>> +     }
>> +
>> +     rm_install_health_monitor(rdev);
>> +
>> +     return rdev;
>> +queue_fini:
>> +     rm_queue_fini(rdev);
>> +err:
>> +     return ERR_PTR(ret);
>> +}
>> +
>> +int vmgmt_rm_get_fw_id(struct rm_device *rdev, uuid_t *uuid)
>> +{
>> +     char str[UUID_STRING_LEN];
>> +     ssize_t len = PAGE_SIZE;
>> +     char *buffer = NULL;
>> +     struct rm_cmd *cmd;
>> +     u8 i, j;
>> +     int ret;
>> +
>> +     buffer = vmalloc(len);
>> +     if (!buffer)
>> +             return -ENOMEM;
>> +
>> +     memset(buffer, 0, len);
> 
> vzalloc()?

Yes, I will fix it.

> 
>> +
>> +     ret = rm_queue_create_cmd(rdev, RM_QUEUE_OP_GET_LOG_PAGE, &cmd);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = rm_queue_payload_init(cmd, RM_CMD_LOG_PAGE_FW_ID);
>> +     if (ret)
>> +             goto error;
>> +
>> +     ret = rm_queue_send_cmd(cmd, RM_CMD_WAIT_CONFIG_TIMEOUT);
>> +     if (ret)
>> +             goto payload;
>> +
>> +     ret = rm_queue_copy_response(cmd, buffer, len);
>> +     if (ret)
>> +             goto payload;
>> +
>> +     /* parse uuid into a valid uuid string format */
>> +     for (i  = 0, j = 0; i < strlen(buffer); i++) {
>> +             str[j++] = buffer[i];
>> +             if (j == 8 || j == 13 || j == 18 || j == 23)
>> +                     str[j++] = '-';
>> +     }
>> +
>> +     uuid_parse(str, uuid);
>> +     vmgmt_dbg(rdev->vdev, "Interface uuid %pU", uuid);
>> +
>> +     vfree(buffer);
>> +
>> +     rm_queue_payload_fini(cmd);
>> +     rm_queue_destory_cmd(cmd);
>> +
>> +     return 0;
>> +
>> +payload:
>> +     rm_queue_payload_fini(cmd);
>> +error:
>> +     rm_queue_destory_cmd(cmd);
>> +     vfree(buffer);
>> +     return ret;
>> +}
>> diff --git a/drivers/fpga/amd/vmgmt-rm.h b/drivers/fpga/amd/vmgmt-rm.h
>> new file mode 100644
>> index 000000000000..a74f93cefbe8
>> --- /dev/null
>> +++ b/drivers/fpga/amd/vmgmt-rm.h
>> @@ -0,0 +1,222 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Driver for Versal PCIe device
>> + *
>> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef __VMGMT_RM_H
>> +#define __VMGMT_RM_H
>> +
>> +#define RM_HDR_OFF                   0x0
>> +#define RM_HDR_MAGIC_NUM             0x564D5230
>> +#define RM_QUEUE_HDR_MAGIC_NUM               0x5847513F
>> +#define RM_PCI_IO_BAR_OFF            0x2010000
>> +#define RM_PCI_IO_SIZE                       0x1000
>> +#define RM_PCI_SHMEM_BAR_OFF         0x8000000
>> +#define RM_PCI_SHMEM_SIZE            0x8000000 /* 128 MB */
>> +#define RM_PCI_SHMEM_HDR_SIZE                0x28
>> +
>> +#define RM_QUEUE_HDR_MAGIC_NUM_OFF   0x0
>> +#define RM_IO_SQ_PIDX_OFF            0x0
>> +#define RM_IO_CQ_PIDX_OFF            0x100
>> +
>> +#define RM_CMD_ID_MIN                        1
>> +#define RM_CMD_ID_MAX                        (BIT(17) - 1)
>> +#define RM_CMD_SQ_HDR_OPS_MSK                GENMASK(15, 0)
>> +#define RM_CMD_SQ_HDR_SIZE_MSK               GENMASK(14, 0)
>> +#define RM_CMD_SQ_SLOT_SIZE          512
>> +#define RM_CMD_CQ_SLOT_SIZE          16
>> +#define RM_CMD_CQ_BUFFER_SIZE                (1024 * 1024)
>> +#define RM_CMD_CQ_BUFFER_OFFSET              0x0
>> +#define RM_CMD_LOG_PAGE_TYPE_MASK    GENMASK(15, 0)
>> +#define RM_CMD_VMR_CONTROL_MSK               GENMASK(10, 8)
>> +#define RM_CMD_VMR_CONTROL_PS_MASK   BIT(9)
>> +
>> +#define RM_CMD_WAIT_CONFIG_TIMEOUT   msecs_to_jiffies(10 * 1000)
>> +#define RM_CMD_WAIT_DOWNLOAD_TIMEOUT msecs_to_jiffies(300 * 1000)
>> +
>> +#define RM_COMPLETION_TIMER          (HZ / 10)
>> +#define RM_HEALTH_CHECK_TIMER                (HZ)
>> +
>> +#define RM_INVALID_SLOT                      0
>> +
>> +enum rm_queue_opcode {
>> +     RM_QUEUE_OP_LOAD_XCLBIN         = 0x0,
>> +     RM_QUEUE_OP_GET_LOG_PAGE        = 0x8,
>> +     RM_QUEUE_OP_LOAD_FW             = 0xA,
>> +     RM_QUEUE_OP_LOAD_APU_FW         = 0xD,
>> +     RM_QUEUE_OP_VMR_CONTROL         = 0xE,
>> +     RM_QUEUE_OP_IDENTIFY            = 0x202,
>> +};
>> +
>> +struct rm_cmd_sq_hdr {
>> +     u16 opcode;
>> +     u16 msg_size;
>> +     u16 id;
>> +     u16 reserved;
>> +} __packed;
>> +
>> +struct rm_cmd_cq_hdr {
>> +     u16 id;
>> +     u16 reserved;
>> +} __packed;
>> +
>> +struct rm_cmd_sq_bin {
>> +     u64                     address;
>> +     u32                     size;
>> +     u32                     reserved1;
>> +     u32                     reserved2;
>> +     u32                     reserved3;
>> +     u64                     reserved4;
>> +} __packed;
>> +
>> +struct rm_cmd_sq_log_page {
>> +     u64                     address;
>> +     u32                     size;
>> +     u32                     reserved1;
>> +     u32                     type;
>> +     u32                     reserved2;
>> +} __packed;
>> +
>> +struct rm_cmd_sq_ctrl {
>> +     u32                     status;
>> +} __packed;
>> +
>> +struct rm_cmd_sq_data {
>> +     union {
>> +             struct rm_cmd_sq_log_page       page;
>> +             struct rm_cmd_sq_bin            bin;
>> +             struct rm_cmd_sq_ctrl           ctrl;
>> +     };
>> +} __packed;
>> +
>> +struct rm_cmd_cq_identify {
>> +     u16                     major;
>> +     u16                     minor;
>> +     u32                     reserved;
>> +} __packed;
>> +
>> +struct rm_cmd_cq_log_page {
>> +     u32                     len;
>> +     u32                     reserved;
>> +} __packed;
>> +
>> +struct rm_cmd_cq_control {
>> +     u16                     status;
>> +     u16                     reserved1;
>> +     u32                     reserved2;
>> +} __packed;
>> +
>> +struct rm_cmd_cq_data {
>> +     union {
>> +             struct rm_cmd_cq_identify       identify;
>> +             struct rm_cmd_cq_log_page       page;
>> +             struct rm_cmd_cq_control        ctrl;
>> +             u32                             reserved[2];
>> +     };
>> +     u32                     rcode;
>> +} __packed;
>> +
>> +struct rm_cmd_sq_msg {
>> +     struct rm_cmd_sq_hdr    hdr;
>> +     struct rm_cmd_sq_data   data;
>> +} __packed;
>> +
>> +struct rm_cmd_cq_msg {
>> +     struct rm_cmd_cq_hdr    hdr;
>> +     struct rm_cmd_cq_data   data;
>> +} __packed;
>> +
>> +struct rm_cmd {
>> +     struct rm_device        *rdev;
>> +     struct list_head        list;
>> +     struct completion       executed;
>> +     struct rm_cmd_sq_msg    sq_msg;
>> +     struct rm_cmd_cq_msg    cq_msg;
>> +     enum rm_queue_opcode    opcode;
>> +     void                    *buffer;
>> +     ssize_t                 size;
>> +};
>> +
>> +enum rm_queue_type {
>> +     RM_QUEUE_SQ,
>> +     RM_QUEUE_CQ
>> +};
>> +
>> +enum rm_cmd_log_page_type {
>> +     RM_CMD_LOG_PAGE_AXI_TRIP_STATUS = 0x0,
>> +     RM_CMD_LOG_PAGE_FW_ID           = 0xA,
>> +};
>> +
>> +struct rm_queue {
>> +     enum rm_queue_type      type;
>> +     u32                     pidx;
>> +     u32                     cidx;
>> +     u32                     offset;
>> +     u32                     data_offset;
>> +     u32                     data_size;
>> +     struct semaphore        data_lock;
>> +};
>> +
>> +struct rm_queue_header {
>> +     u32                     magic;
>> +     u32                     version;
>> +     u32                     size;
>> +     u32                     sq_off;
>> +     u32                     sq_slot_size;
>> +     u32                     cq_off;
>> +     u32                     sq_cidx;
>> +     u32                     cq_cidx;
>> +};
>> +
>> +struct rm_header {
>> +     u32                     magic;
>> +     u32                     queue_base;
>> +     u32                     queue_size;
>> +     u32                     status_off;
>> +     u32                     status_len;
>> +     u32                     log_index;
>> +     u32                     log_off;
>> +     u32                     log_size;
>> +     u32                     data_start;
>> +     u32                     data_end;
>> +};
>> +
>> +struct rm_device {
>> +     struct vmgmt_device     *vdev;
>> +     struct regmap           *shmem_regmap;
>> +     struct regmap           *io_regmap;
>> +
>> +     struct rm_header        rm_metadata;
>> +     u32                     queue_buffer_start;
>> +     u32                     queue_buffer_size;
>> +     u32                     queue_base;
>> +
>> +     /* Lock to queue access */
>> +     struct mutex            queue;
>> +     struct rm_queue         sq;
>> +     struct rm_queue         cq;
>> +     u32                     queue_size;
>> +
>> +     struct timer_list       msg_timer;
>> +     struct work_struct      msg_monitor;
>> +     struct timer_list       health_timer;
>> +     struct work_struct      health_monitor;
>> +     struct list_head        submitted_cmds;
>> +
>> +     int                     firewall_tripped;
>> +};
>> +
>> +int rm_queue_create_cmd(struct rm_device *rdev, enum rm_queue_opcode opcode,
>> +                     struct rm_cmd **cmd_ptr);
>> +void rm_queue_destory_cmd(struct rm_cmd *cmd);
>> +
>> +int rm_queue_data_init(struct rm_cmd *cmd, const char *buffer, ssize_t size);
>> +void rm_queue_data_fini(struct rm_cmd *cmd);
>> +
>> +int rm_queue_copy_response(struct rm_cmd *cmd, void *buffer, ssize_t len);
>> +
>> +int rm_boot_apu(struct rm_device *rdev);
>> +
>> +#endif       /* __VMGMT_RM_H */
>> diff --git a/drivers/fpga/amd/vmgmt.c b/drivers/fpga/amd/vmgmt.c
>> index b72eff9e8bc0..198213a13c7d 100644
>> --- a/drivers/fpga/amd/vmgmt.c
>> +++ b/drivers/fpga/amd/vmgmt.c
>> @@ -21,6 +21,8 @@
>>
>>   #include "vmgmt.h"
>>   #include "vmgmt-comms.h"
>> +#include "vmgmt-rm.h"
>> +#include "vmgmt-rm-queue.h"
>>
>>   #define DRV_NAME                     "amd-vmgmt"
>>   #define CLASS_NAME                   DRV_NAME
>> @@ -43,6 +45,61 @@ static inline struct vmgmt_device *vmgmt_inode_to_vdev(struct inode *inode)
>>        return (struct vmgmt_device *)container_of(inode->i_cdev, struct vmgmt_device, cdev);
>>   }
>>
>> +static int vmgmt_fpga_write_init(struct fpga_manager *mgr,
>> +                              struct fpga_image_info *info, const char *buf,
>> +                              size_t count)
>> +{
>> +     struct fpga_device *fdev = mgr->priv;
>> +     struct fw_tnx *tnx = &fdev->fw;
>> +     int ret;
>> +
>> +     ret = rm_queue_create_cmd(fdev->vdev->rdev, tnx->opcode, &tnx->cmd);
>> +     if (ret) {
>> +             fdev->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
>> +             return ret;
>> +     }
>> +
>> +     fdev->state = FPGA_MGR_STATE_WRITE_INIT;
>> +     return ret;
>> +}
>> +
>> +static int vmgmt_fpga_write(struct fpga_manager *mgr, const char *buf,
>> +                         size_t count)
>> +{
>> +     struct fpga_device *fdev = mgr->priv;
>> +     int ret;
>> +
>> +     ret = rm_queue_data_init(fdev->fw.cmd, buf, count);
>> +     if (ret) {
>> +             fdev->state = FPGA_MGR_STATE_WRITE_ERR;
>> +             rm_queue_destory_cmd(fdev->fw.cmd);
>> +             return ret;
>> +     }
>> +
>> +     fdev->state = FPGA_MGR_STATE_WRITE;
>> +     return ret;
>> +}
>> +
>> +static int vmgmt_fpga_write_complete(struct fpga_manager *mgr,
>> +                                  struct fpga_image_info *info)
>> +{
>> +     struct fpga_device *fdev = mgr->priv;
>> +     int ret;
>> +
>> +     ret = rm_queue_send_cmd(fdev->fw.cmd, RM_CMD_WAIT_DOWNLOAD_TIMEOUT);
>> +     if (ret) {
>> +             fdev->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
>> +             vmgmt_err(fdev->vdev, "Send cmd failed:%d, cid:%d", ret, fdev->fw.id);
>> +     } else {
>> +             fdev->state = FPGA_MGR_STATE_WRITE_COMPLETE;
>> +     }
>> +
>> +     rm_queue_data_fini(fdev->fw.cmd);
>> +     rm_queue_destory_cmd(fdev->fw.cmd);
>> +     memset(&fdev->fw, 0, sizeof(fdev->fw));
>> +     return ret;
>> +}
>> +
>>   static enum fpga_mgr_states vmgmt_fpga_state(struct fpga_manager *mgr)
>>   {
>>        struct fpga_device *fdev = mgr->priv;
>> @@ -51,6 +108,9 @@ static enum fpga_mgr_states vmgmt_fpga_state(struct fpga_manager *mgr)
>>   }
>>
>>   static const struct fpga_manager_ops vmgmt_fpga_ops = {
>> +     .write_init = vmgmt_fpga_write_init,
>> +     .write = vmgmt_fpga_write,
>> +     .write_complete = vmgmt_fpga_write_complete,
>>        .state = vmgmt_fpga_state,
>>   };
>>
>> @@ -96,6 +156,13 @@ static struct fpga_device *vmgmt_fpga_init(struct vmgmt_device *vdev)
>>                return ERR_PTR(ret);
>>        }
>>
>> +     ret = vmgmt_rm_get_fw_id(vdev->rdev, &vdev->intf_uuid);
>> +     if (ret) {
>> +             vmgmt_warn(vdev, "Failed to get interface uuid");
>> +             ret = -EINVAL;
>> +             goto unregister_fpga_mgr;
>> +     }
>> +
>>        /* create fgpa bridge, region for the base shell */
>>        fdev->bridge = fpga_bridge_register(dev, "AMD Versal FPGA Bridge",
>>                                            &vmgmt_br_ops, fdev);
>> @@ -132,6 +199,149 @@ static struct fpga_device *vmgmt_fpga_init(struct vmgmt_device *vdev)
>>        return ERR_PTR(ret);
>>   }
>>
>> +static int vmgmt_region_program(struct fpga_region *region, const void *data)
>> +{
>> +     struct fpga_device *fdev = region->priv;
>> +     struct vmgmt_device *vdev = fdev->vdev;
>> +     const struct axlf *xclbin = data;
>> +     struct fpga_image_info *info;
>> +     int ret;
>> +
>> +     info = fpga_image_info_alloc(&vdev->pdev->dev);
>> +     if (!info)
>> +             return -ENOMEM;
>> +
>> +     region->info = info;
>> +
>> +     info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
>> +     info->count = xclbin->header.length;
>> +     info->buf = (char *)xclbin;
>> +
>> +     ret = fpga_region_program_fpga(region);
>> +     if (ret) {
>> +             vmgmt_err(vdev, "Programming xclbin failed: %d", ret);
>> +             goto exit;
>> +     }
>> +
>> +     /* free bridges to allow reprogram */
>> +     if (region->get_bridges)
>> +             fpga_bridges_put(&region->bridge_list);
>> +
>> +exit:
>> +     fpga_image_info_free(info);
>> +     return ret;
>> +}
>> +
>> +static int vmgmt_fpga_region_match(struct device *dev, const void *data)
>> +{
>> +     const struct vmgmt_fpga_region *arg = data;
>> +     const struct fpga_region *match_region;
>> +     struct fpga_device *fdev = arg->fdev;
>> +     uuid_t compat_uuid;
>> +
>> +     if (dev->parent != &fdev->vdev->pdev->dev)
>> +             return false;
>> +
>> +     match_region = to_fpga_region(dev);
>> +
>> +     import_uuid(&compat_uuid, (const char *)match_region->compat_id);
>> +     if (uuid_equal(&compat_uuid, arg->uuid)) {
>> +             vmgmt_dbg(fdev->vdev, "Region match found");
>> +             return true;
>> +     }
>> +
>> +     vmgmt_err(fdev->vdev, "download uuid %pUb is not the same as device uuid %pUb",
>> +               arg->uuid, &compat_uuid);
>> +     return false;
>> +}
>> +
>> +static long vmgmt_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>> +{
>> +     struct vmgmt_device *vdev = (struct vmgmt_device *)filep->private_data;
>> +     struct vmgmt_fpga_region reg = { 0 };
>> +     struct fpga_region *region = NULL;
>> +     struct axlf *axlf = NULL;
>> +     void *data = NULL;
>> +     size_t size = 0;
>> +     int ret = 0;
>> +
>> +     axlf = vmalloc(sizeof(*axlf));
>> +     if (!axlf)
>> +             return -ENOMEM;
>> +
>> +     ret = copy_from_user((void *)axlf, (void *)arg, sizeof(*axlf));
>> +     if (ret) {
>> +             vmgmt_err(vdev, "Failed to copy axlf: %d", ret);
>> +             ret = -EFAULT;
>> +             goto exit;
>> +     }
>> +
>> +     ret = memcmp(axlf->magic, VERSAL_XCLBIN_MAGIC_ID,
>> +                  sizeof(VERSAL_XCLBIN_MAGIC_ID));
>> +     if (ret) {
>> +             vmgmt_err(vdev, "unknown axlf magic %s", axlf->magic);
>> +             ret = -EINVAL;
>> +             goto exit;
>> +     }
>> +
>> +     /* axlf should never be over 1G and less than size of struct axlf */
>> +     size = axlf->header.length;
>> +     if (size < sizeof(struct axlf) || size > 1024 * 1024 * 1024) {
>> +             vmgmt_err(vdev, "axlf length %zu is invalid", size);
>> +             ret = -EINVAL;
>> +             goto exit;
>> +     }
>> +
>> +     data = vmalloc(size);
>> +     if (!data) {
>> +             ret = -ENOMEM;
>> +             goto exit;
>> +     }
>> +
>> +     ret = copy_from_user((void *)data, (void *)arg, size);
>> +     if (ret) {
>> +             vmgmt_err(vdev, "Failed to copy data: %d", ret);
>> +             ret = -EFAULT;
>> +             goto exit;
>> +     }
>> +
>> +     switch (cmd) {
>> +     case VERSAL_MGMT_LOAD_XCLBIN_IOCTL:
>> +             vdev->fdev->fw.opcode = RM_QUEUE_OP_LOAD_XCLBIN;
>> +             break;
>> +     default:
>> +             vmgmt_err(vdev, "Invalid IOCTL command: %d", cmd);
>> +             ret = -EINVAL;
>> +             goto exit;
>> +     }
>> +
>> +     reg.uuid = &axlf->header.rom_uuid;
>> +     reg.fdev = vdev->fdev;
>> +
>> +     region = fpga_region_class_find(NULL, &reg, vmgmt_fpga_region_match);
>> +     if (!region) {
>> +             vmgmt_err(vdev, "Failed to find compatible region");
>> +             ret = -ENOENT;
>> +             goto exit;
>> +     }
>> +
>> +     ret = vmgmt_region_program(region, data);
>> +     if (ret) {
>> +             vmgmt_err(vdev, "Failed to program region");
>> +             goto exit;
>> +     }
>> +
>> +     vmgmt_info(vdev, "Downloaded axlf %pUb of size %zu Bytes",
>> +                &axlf->header.uuid, size);
>> +     uuid_copy(&vdev->xclbin_uuid, &axlf->header.uuid);
>> +
>> +exit:
>> +     vfree(data);
>> +     vfree(axlf);
>> +
>> +     return ret;
>> +}
>> +
>>   static int vmgmt_open(struct inode *inode, struct file *filep)
>>   {
>>        struct vmgmt_device *vdev = vmgmt_inode_to_vdev(inode);
>> @@ -155,6 +365,7 @@ static const struct file_operations vmgmt_fops = {
>>        .owner = THIS_MODULE,
>>        .open = vmgmt_open,
>>        .release = vmgmt_release,
>> +     .unlocked_ioctl = vmgmt_ioctl,
>>   };
>>
>>   static void vmgmt_chrdev_destroy(struct vmgmt_device *vdev)
>> @@ -201,6 +412,69 @@ static int vmgmt_chrdev_create(struct vmgmt_device *vdev)
>>        return 0;
>>   }
>>
>> +static enum fw_upload_err vmgmt_fw_prepare(struct fw_upload *fw_upload,
>> +                                        const u8 *data, u32 size)
>> +{
>> +     struct firmware_device *fwdev = fw_upload->dd_handle;
>> +     struct axlf *xsabin = (struct axlf *)data;
>> +     int ret;
>> +
>> +     ret = memcmp(xsabin->magic, VERSAL_XCLBIN_MAGIC_ID,
>> +                  sizeof(VERSAL_XCLBIN_MAGIC_ID));
>> +     if (ret) {
>> +             vmgmt_err(fwdev->vdev, "Invalid device firmware");
>> +             return FW_UPLOAD_ERR_INVALID_SIZE;
>> +     }
>> +
>> +     /* Firmware size should never be over 1G and less than size of struct axlf */
>> +     if (!size || size != xsabin->header.length || size < sizeof(*xsabin) ||
>> +         size > 1024 * 1024 * 1024) {
>> +             vmgmt_err(fwdev->vdev, "Invalid device firmware size");
>> +             return FW_UPLOAD_ERR_INVALID_SIZE;
>> +     }
>> +
>> +     ret = rm_queue_create_cmd(fwdev->vdev->rdev, RM_QUEUE_OP_LOAD_FW,
>> +                               &fwdev->cmd);
>> +     if (ret)
>> +             return FW_UPLOAD_ERR_RW_ERROR;
>> +
>> +     uuid_copy(&fwdev->uuid, &xsabin->header.uuid);
>> +     return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>> +static enum fw_upload_err vmgmt_fw_write(struct fw_upload *fw_upload,
>> +                                      const u8 *data, u32 offset, u32 size,
>> +                                      u32 *written)
>> +{
>> +     struct firmware_device *fwdev = fw_upload->dd_handle;
>> +     int ret;
>> +
>> +     ret = rm_queue_data_init(fwdev->cmd, data, size);
>> +     if (ret)
>> +             return FW_UPLOAD_ERR_RW_ERROR;
>> +
>> +     *written = size;
>> +     return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>> +static enum fw_upload_err vmgmt_fw_poll_complete(struct fw_upload *fw_upload)
>> +{
>> +     struct firmware_device *fwdev = fw_upload->dd_handle;
>> +     int ret;
>> +
>> +     vmgmt_info(fwdev->vdev, "Programming device firmware: %pUb", &fwdev->uuid);
>> +
>> +     ret = rm_queue_send_cmd(fwdev->cmd, RM_CMD_WAIT_DOWNLOAD_TIMEOUT);
>> +     if (ret) {
>> +             vmgmt_err(fwdev->vdev, "Send cmd failedi:%d, cid %d", ret, fwdev->id);
>> +             return FW_UPLOAD_ERR_HW_ERROR;
>> +     }
>> +
> 
> Basically I didn't see any difference on HW operations between FPGA
> reprogram & firmware loading. So why use different SW interfaces?
> 
> My idea is FPGA reprogramming is not just for image loading, but also
> device re-enumeration. As I mentioned before, programing the fpga region
> without notifying the impacted driver makes kernel crash.
> 
> I see there is an effort to introduce a unified FPGA reprograming
> interface that should address the concerns. I think we should stop
> adding vendor interfaces and make effort on the unified one.
> 
> https://lore.kernel.org/linux-fpga/20240726063819.2274324-1-nava.kishore.manne@amd.com/

This Versal card has 3 data images that we need to download.
1) The base FW - that enables the hardware, only take effect with a cold 
reboot.
2) The APU FW - the additional FW that is compatible with the base FW.
3) The PL Data - the (FPGA Bitstream Binary) can change the hardware PL.

Our original design was using ioctl to download No.1, and using the 
request_firmware to download the No.2. Both No.1 and No.2 will not be 
dynamically re-programable. We took the existing 
"intel-m10-bmc-sec-update.c" in the fpga as an example. This was why we 
converted the No.1 ioctl to fw_upload.

The No.3 will be initiated by the user PF driver only. Then, the mgmt PF 
driver will use request_firmware to load local saved data and then 
download it onto the FPGA. Thus, in this case, we don't need sysfs or 
ioctl. I will add those code in next patch.

Thus, we don't have to use new IOCTLs to load images for No.1, No.2 and 
No.3. The existing request_firmware API works for all.

I also briefly chatted with "nava.kishore.manne@amd.com". He is going to 
add ioctl and leveraging fpga_region_config_info for OF driver for now.

> 
>> +     vmgmt_info(fwdev->vdev, "Successfully programmed device firmware: %pUb",
>> +                &fwdev->uuid);
>> +     return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>>   static void vmgmt_fw_cancel(struct fw_upload *fw_upload)
>>   {
>>        struct firmware_device *fwdev = fw_upload->dd_handle;
>> @@ -208,8 +482,26 @@ static void vmgmt_fw_cancel(struct fw_upload *fw_upload)
>>        vmgmt_warn(fwdev->vdev, "canceled");
> 
> Nothing to do?
>

The rm_queue_withdraw_cmd should be called. I will fix this.

> 
> I'll stop here, please better organize the patches next time submitting
> to make reviewers easier, even if you know it is an RFC.

Thanks for taking your time reviewing all those patches. I will 
reorganize the patches.

> 
> Thanks,
> Yilun

