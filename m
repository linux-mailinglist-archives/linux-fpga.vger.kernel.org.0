Return-Path: <linux-fpga+bounces-1092-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E307AA4C935
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 18:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2215C17BB41
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A617E235BF8;
	Mon,  3 Mar 2025 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rnh2iLvL"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B1321B9D9;
	Mon,  3 Mar 2025 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021213; cv=fail; b=JAbdhTDc8UC7xm6e+4tjnEX7GFd6tA6F66tqD6wPvZc4yVREOrj6Mpa9qJo0EvXGpd8nRLKvBWCBXs5YcbEFtaaViTehhq+mjvAam9TUyanIi6JUpvfsubUWgRULP9kUaPDmZ8CwU7jfZupU6OIDcg0qS90Vhcm4jZ/coGWphwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021213; c=relaxed/simple;
	bh=6C5RkUTeE84juFKF44uMIfmRuno/m7OuQk60PtQ2lws=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EhyQaTClc/7q2LFCJlX1OgFGfSbtwoGcWy+cJzUh9NFFF0oGG+qXAAoxoaPt3fqlRp+SJp/TpkJNdu5L8efRgWApzCoX+P7nxojirKd901f8fehs0YuGSyxwfbVfnxbdrNeXYfT+eM571s5/hMVBpIjVcR1OTOaDy2gDXRP97vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rnh2iLvL; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukziqCeKXmQ5RNmHz/MHl7Q9geirMe0rPWL86+9UVZ6VJtd7KrhSVmf2q7UHSFiKfOnCI8Uv/DXfUfJTBnxMP0O8WwbRfEmgfIoHgF9df2VWEZ+8fH8T7PXBHCM1tERTk7Zgi8Fb14fuaA5seYwZyIuOsGEpGPoz8eWMrzWgMUVUiWx6x7OLi6AO3ZDjXpCjUuC/xyrp3df7F0VQPg6APyt27D8JY2MJEEfkh2PCyT9fySTIUgM2aMslTSAkr0vR2CQNoyUFGTpsKfS4O4/wE3JohyK5pm/3LGX6e1IMMnxgMcuDJjpfViRntThXdWSv44rHSBSzQZkUAV7zx+McQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1FK87fFhbcY9LDH52bTXwrgxX4LzD1G3BselZzCPWY=;
 b=E/jC3r7Ped4HPUfVKbkdZ3BITtk/C260f1Vm9Auj3aB9Sv1b8nejT/ciGzQvWXiN9vKNsVD0GPOzeI/Vkf56bcvM1CehmGxawokjv4Uip51h+s6cK+voYRkt8ZUiULatBxE6Un9+0Gv57HgCwn1juTaC2v2sk1FDpPSeRhxaVYYGONffpzEJGoad4oLwNChgpPL12AK4K6PHv4lwsnzRMtGA+0BiBsuExXFePGpnuo6CiC0/+D4vH0kl0w1KyoChaWZyXeC9pq0gQ2oEwlJomA8ff1lDJgB51vidPApk8iLQC1gbtw52uTZBnJN47ZB+gIOdAzF4PGFHMky3d0YZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1FK87fFhbcY9LDH52bTXwrgxX4LzD1G3BselZzCPWY=;
 b=rnh2iLvL45f6/q/azP3pq7W+kSjPY0dX4EM0YZ4IZAPchTjh0bvfZrca9S8RGAsV68+k2VxQ09Rv9LXH2UxJL2eknxzzW6SZEYyYydWnzpgelX7NsTHEVp9cLliYpfUUDClWbEEqs7h/8Pjp3TMkNFfa+fL1oOZ0AW2+nI6TTO0=
Received: from BL0PR0102CA0023.prod.exchangelabs.com (2603:10b6:207:18::36) by
 SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 17:00:07 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::7f) by BL0PR0102CA0023.outlook.office365.com
 (2603:10b6:207:18::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Mon,
 3 Mar 2025 17:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 17:00:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 11:00:01 -0600
Received: from [172.19.74.139] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 3 Mar 2025 11:00:00 -0600
Message-ID: <e7c69353-0146-46e0-9f93-27fdae6791f5@amd.com>
Date: Mon, 3 Mar 2025 09:00:00 -0800
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
References: <Z6Q3W2mUw/ZbtnWV@yilunxu-OptiPlex-7050>
 <796e2826-a423-4d0c-977a-105ed236e067@amd.com>
 <Z6Vtz/Bb8wsIH0pG@yilunxu-OptiPlex-7050>
 <7b9bd24f-8f89-4d6c-a079-47c4c0b88a35@amd.com>
 <Z6WO2Ktc9HoqdUSU@yilunxu-OptiPlex-7050>
 <e68be2e2-7fdd-4f09-b479-4b0e31af5be5@amd.com>
 <Z6sT20uzjes7SGzr@yilunxu-OptiPlex-7050>
 <84281771-52d8-4b1d-8478-1fedb6f31608@amd.com>
 <Z8LDSjhcXvwnyeiF@yilunxu-OptiPlex-7050>
 <790910eb-4876-49de-b8eb-0ac50868bc1f@amd.com>
 <Z8Vg0nJ2T9ezHDVf@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <Z8Vg0nJ2T9ezHDVf@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: yidong.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|SJ2PR12MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e717e0f-c8c1-4750-dab0-08dd5a74d8e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlFvQlhXQmdBS0xCL0djZit5R04rVEpVeFRqWTkrNnkvT2NhZVpKVkh0aU4y?=
 =?utf-8?B?THdkTEY2enhaemJuMzIrZmlvNldmSi82Y2NoQmVGbGw2R2xza3BGNTExUFQr?=
 =?utf-8?B?VDlmbElsL21yNGFxMkJKaXdCbDR1TzFrRjVrR2pVNmZqbGV4dXllWEdGT1Jz?=
 =?utf-8?B?ZFUzWFdrNDRrclEwZ3lhRHdPTlFGMFRHTVZ2UDg2RUQwZkUzZk50SEs5dEUx?=
 =?utf-8?B?VnNzek5RaSszTGtybU9mYUNkRFpPcjNlS2hSS2pLWitOcE5mSGdGaU5MMFBx?=
 =?utf-8?B?djFxcUp1TTJ2cTVWUFROc3pJUjBMbEhRSW00NEtSZExGTWs3YktxSWNOUEVh?=
 =?utf-8?B?TGJmNkFMSVpDMEVJeXA5RzZYWFV4d0pvY3d5Tzkxa1hZV1ZlNzlmcG45bDAw?=
 =?utf-8?B?VUdZdDJuYzJhMk9nSlVhbEZRb1l4QUhNbSs2ZGZwZzFJRlFMeVBZQXdaUXFK?=
 =?utf-8?B?SmErS2VtZ2EvOHpEeTA4QUxhbGp4cWRJMnJ0WW0wV2Nvd2ZHSExDU0sraUpV?=
 =?utf-8?B?aDBPZ0oweThWZjcrYkpaNnF6WTZIRk5LTEJzVUdlNzZvVXRyWWhqU0lZZ212?=
 =?utf-8?B?aHhlM1ZMYW9wK3Z2QUpqRjQ5a0lZOHc0cDNGc1lmajBxV1ZhRWFoanlLYmE0?=
 =?utf-8?B?c080T1lhejJjTGFGMjhGV1ZtUGd2VzhObXZUUDhJakJGZFlLS1RKRDErRkZx?=
 =?utf-8?B?ZDZiNjhOemhhZjY3MU1qaWNwQlcyLzh4d0Q1VkFEN0pyYXNHMjJ1OVA3R1Q2?=
 =?utf-8?B?eDZ6ZFh4cWdzZmovUkZIRzRkc0ZLSVpHWms5UDBNZ1ZvUUZKTXM4d1kvaVNK?=
 =?utf-8?B?eWFUdU9rbVp6L0ozeHMzallDMkd4U1Iwc1RHZXVIZ2xtejBlZnMzUERwU3Zm?=
 =?utf-8?B?Q3Q5UVEwcUFjRmRCTDdGQStXS0YvZC9qQUwvS21nNUJCNlNXQ1B2c2xRalUv?=
 =?utf-8?B?anJVaW4yY1lvamI0ckFNMEJKelQyVFRnOXYzbVRPN1VWR3BURjlHNWFlZHhE?=
 =?utf-8?B?VWQyZEVPQ2RHTzl1ZlBZZ0FhaStVd004M3NDcEFaTG5qMGkzVFpuSktJeFJt?=
 =?utf-8?B?a3MvQlJKOExSZXRnNjZxRFNSY3lEMjhUWEt6QmlaZ2lGMjJ0NHIxY0t0ampY?=
 =?utf-8?B?SnNqcExMNjc4eGJRTTFvd1VpRHJ0cWRwV25vUkZ0SkRFNEsxNm83a1UzT2Vn?=
 =?utf-8?B?YTVUN2hwb09MZnA3MCtsRFNSR2E3OFFnaFlYLzVtTzFYMWhCdFk5WlIxTnJ1?=
 =?utf-8?B?dGJ0YVRZVUVvV0d5aUQ1K3NVQmoySTJqTnJ3K1lzbGh4SmhLSU5veHRubVFN?=
 =?utf-8?B?RFltUE1KVUd6ZXlWNVJqRXVHTVk4OEZHdDNYK0s2Szl0aWVzN1R5RHUrVDNy?=
 =?utf-8?B?MjNudWNPdDZ5WUplOWZ4bnRET1RiU2xjVEovZUNHbWVqZnJmK3ZDbGxya3NY?=
 =?utf-8?B?NkVuaGVUYVpuU2JyaysybDVTNE5Uamh6bXhnMWlhVEdpUFdZRHFVS3VtSVlI?=
 =?utf-8?B?ZTV2UTlBS0hYS29ENU5BMFFMb0NZVGdLZVRzMmw2dzZ6a2Y1aVF5Q3JlYVRI?=
 =?utf-8?B?dHRxc1dRQldCbHVPWmsvbnZMQVd3UXBZNlVlVVdHL1hrdEVaR3l0RldhaDBH?=
 =?utf-8?B?Z3YwQzFFNzNWM0dIdmtrbXlwa2NmNkk5VjVTNGJWcGkwZXlBTXdhcTZmTW1N?=
 =?utf-8?B?SFV0ak9lcFlQb0xkVlFpZzR2QWZLalJVck93cVRjOHhFZE51akZNR0UvdWlV?=
 =?utf-8?B?M0lDTUZJNXB3bVprTlN0TnIrSmVrUzVSTG1TUFVTMjFZdXlDaFdIQlYxbVg3?=
 =?utf-8?B?WDNZZmhCYXl1YU42RGFWdUVWcWhRb0pkejQ5VDBITjNHU1lZYVNQUkxmNzRu?=
 =?utf-8?B?alRVZ0ZyTWNjSDFiQU05UklLRElpVk1mNWJZdTY2bWIya29aWldlRnkzWjJW?=
 =?utf-8?B?WGJ5WjBaZ01jWk5yU3p6WWlwb284RHBOcWorbDF6M2VFQm95eVF6THlsSTFM?=
 =?utf-8?Q?JY+rz0w+DeYw0mAlWp31xBQIrM/oxc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:00:05.7527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e717e0f-c8c1-4750-dab0-08dd5a74d8e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182



On 3/2/25 23:57, Xu Yilun wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Sat, Mar 01, 2025 at 11:03:29AM -0800, Yidong Zhang wrote:
>>
>>
>> On 3/1/25 00:20, Xu Yilun wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>>> My last question for this topic:
>>>> If we decide to upstream both userPF and mgmtPF driver together, could them
>>>> be both within the drivers/fpga/amd as in-tree driver? This will help user
>>>
>>> I don't look into your full driver stack. Generally, if your drivers are
>>> all about reprogramming, then yes. If they are also about all kinds of
>>> accelaration functions you'd better split them out in different domains.
>>> I may not have enough knowledge to make them correct.
>>>
>>
>> The driver has more features than just re-programing. The re-programing is
>> already done in the embedded firmware that's why the mgmtPF driver is just a
>> utility driver.
>>
>> The userPF driver has features such as:
>>    xdma (already in drivers/xilinx/xdma as platform driver)
>>    qdma (already in drivers/amd/qdma as platform driver)
>>    mailbox and more which have not been upstreamed in linux kernel yet.
>>
>> The driver architecture is:
>>
>>    userPF driver (as pci_driver)
>>      qdma (as platform_driver)
>>      ..
>>      mailbox (as platform_driver)
>>         /\
>>         ||
>>         \/
>>      mailbox (as platform_driver)
>>    mgmtPF driver (as pci_driver)
>>         /\
>>         ||
>>         \/
>>      Embedded firmware (re-programing done here)
>>
>> Right now, I am working on upstreaming the mgmtPF driver as pci_driver.
>> In the future, I think the userPF driver should be fitting into the
>> "drivers/fpga", given that should manage all these platform_drivers and
> 
> No I think userPF driver should manage all these *platform_devices*.
Yes, userPF driver manage all these "platform_devices" by leveraging the 
fpga_region callback ops. That's why I am thinking the userPF should be 
in drivers/fpga.

> Platform_drivers could be independent and put into proper domain folders.
Yes. All these "platform_devices" - drivers - should be put into proper 
domain. Aka, not in the drivers/fpga.

> 
>> utilize the fpga_region callbacks to online/offline services due to hardware
> 
> fpga_region should online/offline platform devices. Not services, which is the
> job of each platform_driver.

Yes. I think we are thinking the same concept - online/offline platform 
devices. Not the services like probe/remove. The online/offline are 
separate ops just designed for the platform_devices to be online/offline.

Thanks,
David

> 
> Thanks,
> Yilun
> 
>> changes after re-programing.
>>
>> Thanks,
>> David
>>
>>> Thanks,
>>> Yilun
>>>
>>>> find source code easily.

