Return-Path: <linux-fpga+bounces-1080-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00794A4AD78
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Mar 2025 20:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0C4188B992
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Mar 2025 19:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7B71E520E;
	Sat,  1 Mar 2025 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bbibzBKm"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB6E1B6CFE;
	Sat,  1 Mar 2025 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740855819; cv=fail; b=DnB8eKQ+G39C29P+mlVqH4pPpv80tv/7uP+q/GzzPgSXa7vJXwRC2818Rs8k3zyY/LwWWhJbYGPPrvrX17Kz0ekhLe6OvNei1RbUrGv3SxqrROBpkODyocFSE27CJKiasvfDoaLo7kj0jzXKqisG1BlKukYlXn3YEgM1hkcLIhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740855819; c=relaxed/simple;
	bh=enLVkT2KXkTKqOx0yncxQDMFn8nJhzYeB/igdKgB42g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=huLV0ykgVM3o2hCCSxU5kxhjNp6o0FUxa09t2Quo4Fx/8I6dXJEQAlbTFiby0TBGuA8+RZGdBTvfp32ZYr4SREHu8MV4zDivZcY7n0mLfiQ5Yc1SJsYEdOnw8sq9YMLh/4tqlH9x+5qGUkJtnwP2K2fzJ5oczY3fW5+VOl/4ytk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bbibzBKm; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jE8QPAUKFRcwf56Rfe29AzUTDOR56CmA5LiG3zBEFlY4S8vRY4+TksA7FBDA1E7R5yYytOsBJPoW7xHxF0hX7cpqSLS4ytf6uRARKXA9JOgwGrYlXgrrjUCf7hCbwBkL4DiSBCbArOtJKBC6csLHQO34ozP1CqHU88fJ78SlheNRZanCgU6g0MrXCKazkQGj2TwkNe3SAN532GA0jgYS3yfngPhj51l4JpEWtRVBmwgkxyAiQWcWM1snrVcl2nuXoUwJfgXrDZpKSxQoEWg4F3BKyAP3CGF9z4OT60dgnTIt42Xt8d/dL5fMgFv2dAN2Y8+4HsTSxct4fNgxFN8+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUmG41KEG0f5aZ6IOSedYl8MleVyMu1eeQ6vXcjhaFk=;
 b=jk+sIGmMjI38vTWIDmwdGMk6Q+EEwmy9UmnpwIySu0LjJBZdpuaWYQFKLwpWsDRENnQalqAgDw3BOuT/y7Qz43wqUGyzBArdvoZ0dFVHkyvTooGEG8kF/SeSs/QjokIl/OoueZTt9L5F7Od3zUQXDYMU3RhhJ6I4qiyZwIb67cnDQiOFDjHcoz3Q6ivYWbpKCGQwlAMc1bS1HjYuZbg57jVqbZGE/Ki/iESFtDpNv1SuNrsqXUAt/NUJWkoK00r9AGjFK9T/lQ5H9XDwUqGCg2Ijwbks/lnOQlDWUiw+bxJ2vS43tIw1OMOWFjBzV64lX/WHNaKZS7+lFcQn4fF37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUmG41KEG0f5aZ6IOSedYl8MleVyMu1eeQ6vXcjhaFk=;
 b=bbibzBKmBUWgE4AK2p5kimwbcsXwV73KOBM5dmMmT+Yqb5ZEy9Kh6eM3vwvmp7pAxcSJMoI8b+A7o2KpQ+ULpnfw89R3rvpJtOczXja2xuK67L7LSk2HJRxPyBbTtK1XwZLRTZ5heYq9zAAtn955LXyecbJ0zneYwtVVIy81Ahw=
Received: from SJ0PR05CA0044.namprd05.prod.outlook.com (2603:10b6:a03:33f::19)
 by CH3PR12MB9021.namprd12.prod.outlook.com (2603:10b6:610:173::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sat, 1 Mar
 2025 19:03:32 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::fe) by SJ0PR05CA0044.outlook.office365.com
 (2603:10b6:a03:33f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16 via Frontend Transport; Sat,
 1 Mar 2025 19:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Sat, 1 Mar 2025 19:03:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 1 Mar
 2025 13:03:30 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 1 Mar
 2025 13:03:30 -0600
Received: from [172.19.74.139] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 1 Mar 2025 13:03:29 -0600
Message-ID: <790910eb-4876-49de-b8eb-0ac50868bc1f@amd.com>
Date: Sat, 1 Mar 2025 11:03:29 -0800
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/4] drivers/fpga/amd: Add new driver amd versal-pci
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
	<lizhi.hou@amd.com>, DMG Karthik <Karthik.DMG@amd.com>, Nishad Saraf
	<nishads@amd.com>, Hayden Laccabue <hayden.laccabue@amd.com>
References: <Z5YPWHVmL29zuQNm@yilunxu-OptiPlex-7050>
 <3b520bab-d948-470a-b06f-5494243ebc1a@amd.com>
 <Z6Q3W2mUw/ZbtnWV@yilunxu-OptiPlex-7050>
 <796e2826-a423-4d0c-977a-105ed236e067@amd.com>
 <Z6Vtz/Bb8wsIH0pG@yilunxu-OptiPlex-7050>
 <7b9bd24f-8f89-4d6c-a079-47c4c0b88a35@amd.com>
 <Z6WO2Ktc9HoqdUSU@yilunxu-OptiPlex-7050>
 <e68be2e2-7fdd-4f09-b479-4b0e31af5be5@amd.com>
 <Z6sT20uzjes7SGzr@yilunxu-OptiPlex-7050>
 <84281771-52d8-4b1d-8478-1fedb6f31608@amd.com>
 <Z8LDSjhcXvwnyeiF@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <Z8LDSjhcXvwnyeiF@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|CH3PR12MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b5dee1-5db6-4ce6-d972-08dd58f3c230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eENVaWZocGZKS3dCWEl4aERFMEV0V04wSGtNZEJjVnYza2srd3lYd0E5U29H?=
 =?utf-8?B?eXd2MkJJT2pZckR0SmdTLzRxY2pJci9QSWdTZ1ZJZXE4aERVQSt0ckFuc0RS?=
 =?utf-8?B?Wmlldzk2bytSQW42VlhEV0VNRndWNW9GZWhYV0I0ZXNPcmFTbFVkRjJRQlQ1?=
 =?utf-8?B?aFZVMzN0TW1TUDNEb1BZR0RjTFR5ZW9MblowczhmaWt2dXIxa2JONURFcnFF?=
 =?utf-8?B?a2ZhYmVoK0l6UWVMb0ZxNzBnZVBjVm45R1lPekM4L1hIbTFKMkliS2Q5NkhY?=
 =?utf-8?B?WWF5RzB0bEpyUmwwSkZXS0lQTk9EZUEyblZVdXVNQnUvZXBTZ3Mvdm4xQmVE?=
 =?utf-8?B?NmpnSDZJZHJSN2E5MGttbHR3NVZzTnBpblBrRWpTWjRrWTdVZHlXUHVKZnAz?=
 =?utf-8?B?Q1plUEEzbU4wNVBYcTdRWENEbFhKTy9xVGhOaTVqTldLMTlMZFV6NkF0a3Fs?=
 =?utf-8?B?Q1p2cjVZVEV5UjducXpoSW5YQTFVWVE3aSt0ZHJ4b0NjU2FxQ0hyTi9xYXNu?=
 =?utf-8?B?MkVRc1h4dWpwVm5uQ2NpVHNqQVk3L3J4WEc3VzRrQU43R1U5Q2prODlhYTJX?=
 =?utf-8?B?WmJvRnIySDdpbEJpTCtvdGxEY0xCL2N1U3FURUJ5dUgzaHdDSVcrK2hSWEFs?=
 =?utf-8?B?Wk4ybWN6UGFaZFF3bHY3N3hieGh0ZHA1ZUVsdVdvanFJMHg2NE93bVJnYnBZ?=
 =?utf-8?B?bVZxU2tXVXRSb3lpQkVQS0h4T3pwSDQrcEh4MDJMbW5BVEp0SFhYNmNlclVU?=
 =?utf-8?B?cENKNjQ5S21YdFpRR3htN1lBMktkb2JjMGpTKzdJTm9UN3AxK1ZpdVFLVVd1?=
 =?utf-8?B?L0VuanhHYnRhTWM2MXBVNGRIR2xmMUdaVjBFaFl4M09PL21tYTB4QzBuOWFC?=
 =?utf-8?B?bnhHRnlvWUU4YjZuc3FOTkRtSFV3VGlxWGRDUkt1NkFNSUVZVWtmaUN4bHVI?=
 =?utf-8?B?SXRIb01hY1NCRFNjdjljT0YwWXVBUmxISUg4R2RLY1MyU0NPUHFjRE1qb2Nz?=
 =?utf-8?B?dDJHSHI2TWlDSWEvSS9HL0F6aGxzRmRMNlZWM1o3UzdabHk3dmx0Uy90QTBL?=
 =?utf-8?B?UzgwNGpkaFN2VDNDRHJUZFlRQmFTaEpTRE5LRm9HdWZkODhlc0YzQWNVNnFN?=
 =?utf-8?B?QTRtSGZTWDUwT1JZWnFmeXZPSVVqRVd1ZGYzbHRVaUtjK1pxenIwbFpSUzFW?=
 =?utf-8?B?SnVmSnB3cTdsSlFYQjh2K0RiK2ppQnRuWWR6aUNaY1BnMFByUWV6aC9NUkFy?=
 =?utf-8?B?NXRZbFNRYUs0QkhOcGxiM3BESVBmTFc4RnNTVktaU2UxSURRS2VkOGNBNUxo?=
 =?utf-8?B?RXBteWpYaWw5OGVmZUtZanFXTC9WYy8zMzhabXZ3Nzd1a2hKeDZrUzFmZkM3?=
 =?utf-8?B?ekN1Q2FNdytmQk51ZU1IMGNjenVscHVZVXBWaGk5WlJiYVhpV2ovT2V6dzNn?=
 =?utf-8?B?NXpjTTA5RU4rdVQvSnA4a0wrZEdqakh2NDFYeFFZZ0ZiaWEzZUxyNjg5cEpZ?=
 =?utf-8?B?WWpNM0JkNHJWZ2gxRlI4T0U3eDlFbFZlbnFZU0ZoODY5ei9xektzNUY2bVhY?=
 =?utf-8?B?L3RHSjNSL1RXNmJJdUtvY04rYWYrbTVtdkk0TkxZRW9jWjNweFRpdzZFblVm?=
 =?utf-8?B?M2U4T1IxTTdPSlllZGVyVCttU0NBUmswL0FSSHFHbGxKVW1DWW1NQmV4cjV2?=
 =?utf-8?B?Y0pMRTZJLzRsQnMyZkNaYnZSVXA3aTQrM056LzVxVktaSElKMEd0OHRWNUV6?=
 =?utf-8?B?Nm5IVHpNY3NzdW11Mnk0Q25RTUJLZy8rR0hVVVdaNTlkZEpzV0VyVmxYNHRu?=
 =?utf-8?B?TEdVeHNvbGhzd2xLSlpoZndzMzBpNmtWVWQ2aWxQRFk0US9qRXVIbHVQSHJK?=
 =?utf-8?B?dFMzRXhNcGFTWFBSdkxKQ29NcGs3Y1B3UlJ3VXF1dHA4K3FzcnNjTkpRdVhj?=
 =?utf-8?B?eXl1VS9Bc3p0SzBpMGZjS1NhWHk3L211dHdINFhlM0RZSW8rS2o1QUlGR3BF?=
 =?utf-8?Q?AKzbkZv+fAcoq9zk2XUXHYvOsV8Jss=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 19:03:31.3038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b5dee1-5db6-4ce6-d972-08dd58f3c230
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9021



On 3/1/25 00:20, Xu Yilun wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
>> My last question for this topic:
>> If we decide to upstream both userPF and mgmtPF driver together, could them
>> be both within the drivers/fpga/amd as in-tree driver? This will help user
> 
> I don't look into your full driver stack. Generally, if your drivers are
> all about reprogramming, then yes. If they are also about all kinds of
> accelaration functions you'd better split them out in different domains.
> I may not have enough knowledge to make them correct.
> 

The driver has more features than just re-programing. The re-programing 
is already done in the embedded firmware that's why the mgmtPF driver is 
just a utility driver.

The userPF driver has features such as:
   xdma (already in drivers/xilinx/xdma as platform driver)
   qdma (already in drivers/amd/qdma as platform driver)
   mailbox and more which have not been upstreamed in linux kernel yet.

The driver architecture is:

   userPF driver (as pci_driver)
     qdma (as platform_driver)
     ..
     mailbox (as platform_driver)
        /\
        ||
        \/
     mailbox (as platform_driver)
   mgmtPF driver (as pci_driver)
        /\
        ||
        \/
     Embedded firmware (re-programing done here)

Right now, I am working on upstreaming the mgmtPF driver as pci_driver.
In the future, I think the userPF driver should be fitting into the
"drivers/fpga", given that should manage all these platform_drivers and 
utilize the fpga_region callbacks to online/offline services due to 
hardware changes after re-programing.

Thanks,
David

> Thanks,
> Yilun
> 
>> find source code easily.

