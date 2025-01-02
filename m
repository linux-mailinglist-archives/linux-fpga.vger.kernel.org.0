Return-Path: <linux-fpga+bounces-993-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 187299FF642
	for <lists+linux-fpga@lfdr.de>; Thu,  2 Jan 2025 06:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1423D3A1E12
	for <lists+linux-fpga@lfdr.de>; Thu,  2 Jan 2025 05:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E6B14EC4E;
	Thu,  2 Jan 2025 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4n8SpjgC"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA08158DD9;
	Thu,  2 Jan 2025 05:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735795868; cv=fail; b=p3DRXIgwf49LY3baBWrMPIDk7gcDh/yO3cdt8hN5YClVoccbq7J7oCLe9WFWE0aqpHuYtJ7Mygy4wNvHDFf5eNxnzviGyUYxLvJ2hPzxPaqG60T1RSm4dNPU7FpzWEnqOWo68vHlRuVzlqzeqZEfv0/nW0zOBaKCDSjZO1QTggQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735795868; c=relaxed/simple;
	bh=4H/p+prn6GaY/n6uj80t90NoatDJrdbCdWPXJ0k4Go0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MMjiwP07FTqaplwb10n64mwwBlHD1+dVADpmHlL/Sr7ilC18uWYHSe0coG4PIQBnpBcIWV41fGbuhJRTco/Bjc82bmHCEmhqH8rqqewgtru9qDhKN7V43EhhDmqU/TwhfTfg6iXk/9CfgW1zxMJ5gp43t7xjZ0oUwgrbsGbSOgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4n8SpjgC; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOcwhGPKlOOLAZXciacyWWsgDmbhdcTQhcW4b/o9y6WvTcn6ukPiioSVY9F0hcORNFxJQDu9XrSW0psGmfvBmsrRUVjsFCATL4tZ36XVU/F1SoB/huNpenEjKB9zM6jZEsLiP2LoAcgfRVNUR6PDKVrzN4efKlH5J857wKUwtNANxl0txU1o/pvr3g+tWnSOfQSOUcrS2vT4trdODeaDdC8jmgxn6nw5TstFCGK2Ib27G+A/J1eFTLMYi/0k4SfHcfwfG+6syZxmOZhNcTHJIn3xbNQvYk1zSE/rQKBZnWjub9bhN+7HsUl0dpgo/Ub+JIvSq8JRZl411/xazKdhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lucIQcRwUiC4em3xfFuy77CmKNGJvAfzohBMtN5G9H0=;
 b=n7GHrAGCAliVIzz9tgHiYfNTr107ukNZGnfj0ueBzHY43yYwZrFGgrHiPhSI1QDEG41y32qz846emtSpbC91HQALhMNsv4kpAr45Tb0pQOwEfL+LttBfb7ssoh8/ZQcc+PZ2AuaPQ2fGg4X3z6uoYB8Gvr7PgR99TYhvJqiHAgVEhUvD7e1w26+833TSLX1NhbwuQxSkFp+ojsfSiTIY+/LFGJAz96+Cpg3QE/wHMEbtYaHgYJ0Abhq2HQwpdErk2ybCBr82npSPwptHZh3i0A3vO5WZxkw+f1PxsijMGhlrYKFu/dkg39QTx6FvlUhJo+MmsU+uVQ82ZHxwDaiKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lucIQcRwUiC4em3xfFuy77CmKNGJvAfzohBMtN5G9H0=;
 b=4n8SpjgCeTY/rCbp2eARXv5Sv6j7Js/tIcPYUoJbqiCOYOViMnKj8Iv88Ct1Hy0kXPZbmoypk4nJMPZg8s9rcL8BqTQO6/1VnedAtBXC1jCRaoWLTRzJvttXZdn6YD5Jxxm7ujbBiL9UeEnLUyxxKvv67eBhvSjwWVSaLiAP7n8=
Received: from MW4PR03CA0089.namprd03.prod.outlook.com (2603:10b6:303:b6::34)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.11; Thu, 2 Jan
 2025 05:30:56 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::42) by MW4PR03CA0089.outlook.office365.com
 (2603:10b6:303:b6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Thu,
 2 Jan 2025 05:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 05:30:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 1 Jan
 2025 23:30:54 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 1 Jan
 2025 23:30:54 -0600
Received: from [172.19.74.139] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 1 Jan 2025 23:30:53 -0600
Message-ID: <be4fca2e-dfc5-40b0-8c41-e4ce0773e3a1@amd.com>
Date: Wed, 1 Jan 2025 21:30:48 -0800
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/3] drivers/fpga/amd: Add new driver for AMD Versal
 PCIe card
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
	<lizhi.hou@amd.com>, DMG Karthik <Karthik.DMG@amd.com>, Nishad Saraf
	<nishads@amd.com>, Prapul Krishnamurthy <prapulk@amd.com>
References: <20241007220128.3023169-1-yidong.zhang@amd.com>
 <ZxH9Xjd0eU/7IDGC@yilunxu-OptiPlex-7050>
 <56421e2e-062c-407b-b731-0c1d585a1277@amd.com>
 <Zzw5MOb6dUD6BLYh@yilunxu-OptiPlex-7050>
 <f9abc70d-2d07-4506-a227-af297eb77058@amd.com>
 <ZA4T3rawY7rEIhxp@yilunxu-OptiPlex-7050>
 <f5994bad-afa1-4268-b631-0afcc7c8ce75@amd.com>
 <ZA5EWexVjo7onYuR@yilunxu-OptiPlex-7050>
From: Yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <ZA5EWexVjo7onYuR@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|SA1PR12MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: a923233a-c3d3-476a-b2ba-08dd2aeea176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZCtrc25WbEgrSm5IMm1FdWw0ejJoSHh0cVRoaXBGVGQ5THY0QnpXU3M0OVlW?=
 =?utf-8?B?UmpnMWFEbXhDZXFjcjZ0U2lxWU5CbHpSWDlJa1A3a3dzbUtvUkZvaVl4a1RG?=
 =?utf-8?B?YnVxTzZYREN3MytzRFg0Vkphbm95bGNQZk82VC9hdFk2TXhrdDdqUUdiMTA5?=
 =?utf-8?B?UkQ0bEFmeTNOVnUwZEpiUHordXJueXBKdE9McitPdytRaWVuMTZWNzJ1eDJV?=
 =?utf-8?B?Mkl6aWtqZTI0Y1VvckNKS1N1TFZUZEM4aFhPUW9PZDR6R2s3a1B3RGpUWlJu?=
 =?utf-8?B?MmdKVlpVTENMUWhYNUV6aW9wSW1GRHpJbG9WRSs5citFU0JDZkJlMmdEQUFa?=
 =?utf-8?B?ZVNXVkhxWUdvQ2IwazJQeGZTQUdwT3Q4ZjRUOG01UzN3bWZ5aWZ5d3NjV2kv?=
 =?utf-8?B?RDk1MTViaUFmTXJnam5adnhsakZyUTgyaThjUm9HbGlXeWZkOHJqUDQ1STVR?=
 =?utf-8?B?bDlxU3RCK3hOYWx3M3pUL3ZXSXN6ai9WK2ZrUXBqNHFabDBMcjM0SjlDNFNV?=
 =?utf-8?B?UXQwMklncWFYSFduRklOdWhYVmdiUmVhazhqa2daZE8wK1pNdTdPMUxrWjFu?=
 =?utf-8?B?L1IwcFlVSmFGVjhwN2ZaT3kwSFFmd1NvMkRiVlYxendva2k0QnZxTUJtc25H?=
 =?utf-8?B?ZXAveENNTmlWaExFTEdIZVQ4MnNKVzJ2VEpKWndmeWd4MXNOamV4ZDdzNzJQ?=
 =?utf-8?B?ZStzbnROc2wxbktwVXNYTmF6QXU5anQzMjhKK1RNSzRsQjdmblVxaE96bG5o?=
 =?utf-8?B?cnlCaktHSzZZckkrdkFncCsvakYwUktuYkJQb2tsbm9kY2FHR0s2TGI4QU0v?=
 =?utf-8?B?MnFhYnZIMUpsTnFTY3RHUU1IK0NEUkVaSlUvb01WdmN4UlQrUzg3QUFIUXJK?=
 =?utf-8?B?WEY2S1ZRRy9NTkdOaWFaSGJKTGJFalZnSWNDL1VjNEZ1SU92QWFaZWlrd3hj?=
 =?utf-8?B?aWFmME9VdFlEYkJoUlNQajlxaTFUaGg2V0RrbEhzVlQvQUJvaEpReE9Ib2Jo?=
 =?utf-8?B?aElxZjdzQ2lKOXg4Y0orZ2t5TzI5c2liRUF0R3Z5MnRBWi8zQWYyaXMvbVRr?=
 =?utf-8?B?UmlNMHludS9qZUdBbWVzdmtGV3locWRaekpscGNKWm1IQlBQV3h5ZlJSZmto?=
 =?utf-8?B?MVB0N05jcCtEajNnVWVlOUFXZDFqOUQ5ZUZiekJoeHpPRG1tTW5WNlRIcG94?=
 =?utf-8?B?d3hkVUlIQ01SazdXUWhIamR1Q2JJQUlzRko3YU1vaHZPZ3JLNjVQbGlBYnll?=
 =?utf-8?B?ME9JY0tuS3BWeFNDbGpqNzUvejZZSjZCWkIxcGdvaHJFSjV1d1VLZHdTRUox?=
 =?utf-8?B?SVh1K2twVngvQW9wRW51ejRLd2kwdEsyN3hzNlhYL1hheFAzNWVkQ0FTVVFK?=
 =?utf-8?B?a0d6T1pEb0NGQ1laalNXSFlybGY2K0hQY1pWMzE0MWtjaDhIb1FadTlacU5J?=
 =?utf-8?B?NURhRGovTXpneXo1K1ZhbWtlaHJPajVGSGFQTnZ5b09ta0EwSGsvSy9yOHM1?=
 =?utf-8?B?T0ZLaXJGS004MGc4RDdtNkVIMy9WeWRmSjBHU0lJSUZWaEpGQmd5cUJkMFEz?=
 =?utf-8?B?RW9lN1QyVGp2dHI1MDdrVTA3eHFBMEZMQ2ovdGpxdTRLdU4wb2RmcVlGc2VR?=
 =?utf-8?B?SXZzNEhsM1BpekQraG1OS0QyTFdYOU9RMkZkdHhCSG02TEJBV3lpVk9Ma1BJ?=
 =?utf-8?B?ZlljMzRZbWh1cWhXdCswblZXaS9Ub2o1QVVCckxaUnoybm1ybHU5T0RDK2V5?=
 =?utf-8?B?QUJrNkhsaG5KMUhJcGtycDEvU1ZZeVR2SWw1ZmsrU2JWaHZwMjlIZXRKVFht?=
 =?utf-8?B?RHFteGs1eUczVTZCdmNxeEJwZzlPeFVJL1R5VmdMNVlJRmJZZGhkaHpHN2s1?=
 =?utf-8?B?WVVORTAzV1lTUGtoZ3JKMXcwbGVNTHk3TXJBa1JVYTdsY2t6c1J2RGFKWS9C?=
 =?utf-8?B?OGtKN2JBdXZoNXRZVmhzM25jUG1ObEIramRkMnZ4VjJ6c2R4c0x1VUVzUG1P?=
 =?utf-8?Q?Kln5k1hZJ30uW4nQFjVj44sxK7gSeU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 05:30:55.4409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a923233a-c3d3-476a-b2ba-08dd2aeea176
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842



On 3/12/23 14:30, Xu Yilun wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Wed, Dec 25, 2024 at 10:10:06PM -0800, Yidong Zhang wrote:
>>
>>
>> On 3/12/23 11:03, Xu Yilun wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> On Sun, Dec 22, 2024 at 05:53:30PM -0800, Yidong Zhang wrote:
>>>>
>>>>
>>>> On 11/18/24 23:07, Xu Yilun wrote:
>>>>>
>>>>>>>> +obj-$(CONFIG_AMD_VERSAL_MGMT)                        += amd-vmgmt.o
>>>>>>> IMHO the naming vmgmt is hard to understand, any better idea?
>>>>>> The "v" stand for Versal. We would change to amd-vpci for Versal based pcie
>>>>> "v" + "pci" is quite a misleading term, maybe just versal-pci?
>>>>
>>>> Hi Yilun,
>>>>
>>>> I sent the V2 patch and refactored the driver as versal-pci now.
>>>> One more thing that I kept in V2 was the firmware_upload. I forgot to
>>>> mention that I'd love to switch to the newly proposed interface once
>>>> it is ready. I saw the proposal was now as config_fs and it was not merged
>>>
>>> Good to know that.
>>>
>>> I didn't start reviewing the v2 yet. But one thing is that now the
>>> versal-pci FPGA manager has no user because of the ongoing uAPI, so
>>> cannot be merged, and I won't pay much effort on this series for now.
>>
>> Hi Yilun,
>>
>> Can we add this as TODO in the future when the uAPI solution is ready to
>> switch? We spent some time to refactor the driver and address most of your
>

Hi Yilun,

Happy New Year!

> Sorry, generally kernel won't merge code that has no user, which means
> the code are not tested.

Just confirm "the code are not tested".

We use XRT opensource userPF driver (called xocl.ko) to test the 
versal-pci driver. You can find the source code here:
https://github.com/xdavidz/XRT1/commits/dtb

We are planing to let user use this mgmtPF driver + our open-sourced 
userPF driver + our library as full stack. I will provide full test
result if needed.

We are also working on some linux drm driver. We use the similar way
to prove that the drive has been tested.

Or, you are referring the "user" as user PF driver?
We do have user PF driver as a separate driver.

Please confirm if you are thinking that only userPF + mgmtPF as one 
driver? We architect our driver to 2 drivers due to cloud vendor 
specific requirement.

> 
>> comments in the V2. Hopefully, can you please start reviewing the fpga_mgr
>> and other driver code?
> 
> Yes, I can review the code when possible. But will not merge it.

Thanks. Please see questions above.

> 
>>
>> We'd think that we use the firmware_upload for 1st approach and start
>> letting user use this driver.
>>
>> We definitely will switch to the new uAPI as soon as it is ready in the
>> linux fpga driver. But we'd not like this uAPI holds up everything we
>> already spent times.
> 
> If you want speed up, then collaborate to develop/review the dependent
> patchset, that's how the community works. I actually don't want to be
> the only reviewer in this mail list, and others just send patches.

I'd like to help for the patchset. Let me ping the developer and see how
he would need help on this.

Thanks,
David

> 
> Thanks,
> Yilun

