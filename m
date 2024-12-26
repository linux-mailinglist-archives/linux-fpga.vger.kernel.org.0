Return-Path: <linux-fpga+bounces-990-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 137839FC8D7
	for <lists+linux-fpga@lfdr.de>; Thu, 26 Dec 2024 07:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FCA163407
	for <lists+linux-fpga@lfdr.de>; Thu, 26 Dec 2024 06:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D2B155312;
	Thu, 26 Dec 2024 06:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A8R8KLH1"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC254648;
	Thu, 26 Dec 2024 06:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735193432; cv=fail; b=n+3KHLf0TmxZUv0c6jWbO5WQH4+D1sJmT5DkNnSOHZvsAUvJbNTUegMXJHvQGUy/td99g5pprdozSEYM5lmYZVrHcB7++E7Zunk7ds2D+WleyroNrtaSkaNFnsCVkNLIDxp1XTx9eW28ChG9nLu6vy1z5JX5mIo5v0lYmyEb4mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735193432; c=relaxed/simple;
	bh=r5hFxZ631nRwcrjWVyf4Jvzc7/X4SHDzlR2o3o9dMUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Idv3KYrIXdOXV1GPKuBYOagVm0HjzBaAdJgNV3I63zicZRzrubgIgpIjbiOO5A1P31YKhePvVQQQ5oe6wvYlJDwmAN4K2UPWjl2CXCZaFhlO/aj95gUj3cXWM7tnZ3i3YUk3oSMZiI5qfJGve8MiSOhFlhDkUNPSpEpCMwJTOj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A8R8KLH1; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaXcIdEOqD8tAkDRPF8XnKA+PctgBeFuXQH/iWZxeIZzTJTjyUX4/5N+w2GnHRT5bUVi3XhqkCcVvgO4F+SCVVWMez7YsDWtiNUFF8hC+xSkZEowSyUS8JAeaWtbwNpdrzYUj+TAK7hJ3GdcEDwKPM0L0EW1FpAiOF09rJ5W1+VoPG8JKi/5qOp7aGiLiqhFM1ZaqwmOPlp0lPcre5Kb18eoZj1eFeQyfip+ATDgO/nJssbPWoSI+5tbTlBljonvNu2NzSPq3LWLj7ViLX9cWm4IEgENcQku2DAAJ1Leh/lGpHa9jKfaxJo01Y49W3jquub4Epsni8zIUDvJibhVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6Oyb7a4kTE6NgZzketjN7jdZmbZTtj5s+0Zl9pisjI=;
 b=B1pdcK5W8aNBSRAkKMbp2VUDiyHQupBjUw00t2wpRtgxx0F78RxgUMZ9QJlNBU/keUgeXyZYDStosPbPwokKyy5IxErKxvcdm0FG6zpYE0KAYKiXC4EhFf6zFLozp0m88aDthHFHZPST02wFiCyGSXMFTFJV/NHX+hWVDat/RwAL+qYBKEHDWRn/bb4jm6QLnGXt/mtQFgumtzsu97q6/JyB/w7P6mrMqZWuopFVh7a6eLwV49SMVfaDEDj05umYYeu8TwNpIT27jCsy8Sm6+vLqJD6eydZi+sUfnWOyTd4bqXQ5RuQNAbEIskLHv31LU4ar+E+t1D9xMLO/2emFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6Oyb7a4kTE6NgZzketjN7jdZmbZTtj5s+0Zl9pisjI=;
 b=A8R8KLH1Lili6Sto08fgGF9RSUfQjID+dw1IN3tGuN5KvwO5VMGPqeOJT4gdrwcWJlc0jJE5tuRqLtdW5D00GSOQUZVUAN7olRfIazuVAzVGnOg+63pMDOPCcLSNftTYjhExS0PGvN66uA/gDmVm4XBh1QC3qRGB3ZqIpPyhiZo=
Received: from BLAPR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:36e::10)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 26 Dec
 2024 06:10:22 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::f9) by BLAPR05CA0003.outlook.office365.com
 (2603:10b6:208:36e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.15 via Frontend Transport; Thu,
 26 Dec 2024 06:10:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Thu, 26 Dec 2024 06:10:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Dec
 2024 00:10:20 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Dec
 2024 00:10:07 -0600
Received: from [172.19.74.139] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 26 Dec 2024 00:10:06 -0600
Message-ID: <f5994bad-afa1-4268-b631-0afcc7c8ce75@amd.com>
Date: Wed, 25 Dec 2024 22:10:06 -0800
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
From: Yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <ZA4T3rawY7rEIhxp@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe60e83-1887-42c8-759a-08dd2573faf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXc2RS9CREpoVnBHR0Y3SWgrWng4SFJDcjZHUnN6WVRLMW8rSzNBSll5eE1I?=
 =?utf-8?B?L3RiNDRzNjF1clFzMVZpMXNrOVVnK1RmWlhpcVcvYmN1VmpmTC90bU5YT3Bj?=
 =?utf-8?B?UER2NGdoSEhyNzBDME5NTTRBWGoyRXFlQS9oSFF0VDNPMmkyNFhTdGVhVm1K?=
 =?utf-8?B?WmYxK293VWdJb0ZlZVp3eWpDcFhzWlh1c1IwL01BNFdFNVppSnVGQ1NpNGZi?=
 =?utf-8?B?QkZxN0M2UGo1ZHlyaFpYRXRaM0pvUVE1ekw5elUyb3krV2lCQ2NBZkVPMW0r?=
 =?utf-8?B?aTFQTFN2VFVVcGJLU0s5aHQ5NHROcTJVQys3ZWZLdXByVm5mQUJySEUydm9w?=
 =?utf-8?B?N3lWVzZveTVzRHhzWnhRZld2N04wanp2NC9qMXp5Y3hsbHdKUWVXN3hxcVVa?=
 =?utf-8?B?T252U1FRamg5VGRiMUFrenc0WWlLUTRubkd2cTBWZk96WnpLK0pXUFFkbjVT?=
 =?utf-8?B?QzhBeGRWbHZvUTVTbmp5OGE1eFFQUW5rOUQ3R2RzZVdIbWt2ek1qTmlldXRq?=
 =?utf-8?B?bGcrb0ZaNldDZWRGWUFjcnE3bzJ5b2ZxR2VPMStLbk9OOGZIblNkT2p0WkZE?=
 =?utf-8?B?NENnYW5BODV6ZDJ4dXVXdGtyTGJsK1RuVkRiN1o4cjlmMzdBODhoSWVNVmZO?=
 =?utf-8?B?bnROZ0dibWgzUGV2ZFVKWkQ4YkYzbGpSYW5ITGhMa3g1a3FJS2dGK1NtN3ov?=
 =?utf-8?B?TUFZcVRYeWUyLytnRjdZa0xoYk9BUjhWWElUMHNDaUhBS2o2bXpnU2VidFFX?=
 =?utf-8?B?dkpXa0tpTWQyZFRPVTBjWDNTK2xmam5saTQ1aTBnMkpXVEc2ZHpmTU9lSExx?=
 =?utf-8?B?TTZvU21LR2hWSTFvV0hGOWhDbFFBNWxlazVZZGZCdnFYNXcxYURRRXlTNnVv?=
 =?utf-8?B?c3pTb3BFT1BGeVpWZmVDcDE5UWFOQWNCbzVtT2Zra0NMWnZGTHlaQVdDWk5a?=
 =?utf-8?B?ZTU1UWdRRlQrRG5HQlNYSUl3V3R6WHBpVndGVUprMldMZmlrRXFXYXFjc0E0?=
 =?utf-8?B?VHpGbk4xNjhHelJlNy9IQUlpQlhGM3lVYXFBeS9nMkRXbERCUEdnOE9GZy9R?=
 =?utf-8?B?dnpCT2xHZk1GNVgrdGt0TVA5L1Vpeld0YytySjFiVk45QnJGWFRvSHpKbWg5?=
 =?utf-8?B?RWY5OGNxMDc0cW1NSlhLcmxaSlNmRkM2WGVrdWg5RE9kQWFwMmM5dnNVMENL?=
 =?utf-8?B?dFVXOEhDM2QwMW1BNTlXRGd0aEV0QzRTOUNSUXFHOE5xcFVoN2VQWFN4U2xY?=
 =?utf-8?B?OStzVWtvd1pMQVc3NHlYN1Nlb21nNGswVllzMlZta2RPUjBWTnBIZmJ5dE1z?=
 =?utf-8?B?WGFRdnpla0ViUVp2TTBUN2s0Wlp1cUY2T0tVbndYL2ZiU1hhRlI5cVE4eE9B?=
 =?utf-8?B?RHJQMzY0S21JbHZrNlRkNnRuc0dwWnVlQ3FaU0V1NkJST0ViYU8zZjcvQVcw?=
 =?utf-8?B?WEY4TUp6V3FHblFYSHY3T3pYOGFISSsyNkwyTERRakxaQWxIWUJnemQxbXFQ?=
 =?utf-8?B?NlYrK3Uzc25KT2g2N1VVV05jd2xwQk84UTl1U0tnT29saGdVai8wRit2YkZo?=
 =?utf-8?B?aDg1NWRCY1loSnVSSEpOWklEaHZMZHhoUjU1aFlVRUhoNElEampFQWowcElt?=
 =?utf-8?B?djN0ZUVlTzhRSkhkWmhXOWNzVDhSSGFSSWZJenZtaDdoTDVaL2RFT3JDQjQ4?=
 =?utf-8?B?NFV3eFhLVWZQQzNTbVZVc0I0SVh5L2RqMWdJczZ1VHFWb2lmd051TWdzTG1n?=
 =?utf-8?B?bmo3My9zczlhYXV6UjdHdGRQNmVFelY0TmxHT3k1YTZ4YXEwT1NtVWl6TEhk?=
 =?utf-8?B?STZ2RWxBdjY2QU1nSE00Qkc1ZXhLYkFiSG9NWm1RZjJtRUtoS2Rtc2JGeFQ5?=
 =?utf-8?B?WUcxNFpBZFZZbU9uWXNsRkJsWWVvR3V5V0M3MjFwaDhqTzFsS3BhcHE1dGlm?=
 =?utf-8?B?dGhMNFF3MWNMeUJvaUE5cUw4cFNEZ0lHV3VsOHdab2VrTXc1MTRZallzeVl1?=
 =?utf-8?Q?okulGlZrtgYaTSIODmxlsvTItyrJac=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2024 06:10:21.7070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe60e83-1887-42c8-759a-08dd2573faf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169



On 3/12/23 11:03, Xu Yilun wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Sun, Dec 22, 2024 at 05:53:30PM -0800, Yidong Zhang wrote:
>>
>>
>> On 11/18/24 23:07, Xu Yilun wrote:
>>>
>>>>>> +obj-$(CONFIG_AMD_VERSAL_MGMT)                        += amd-vmgmt.o
>>>>> IMHO the naming vmgmt is hard to understand, any better idea?
>>>> The "v" stand for Versal. We would change to amd-vpci for Versal based pcie
>>> "v" + "pci" is quite a misleading term, maybe just versal-pci?
>>
>> Hi Yilun,
>>
>> I sent the V2 patch and refactored the driver as versal-pci now.
>> One more thing that I kept in V2 was the firmware_upload. I forgot to
>> mention that I'd love to switch to the newly proposed interface once
>> it is ready. I saw the proposal was now as config_fs and it was not merged
> 
> Good to know that.
> 
> I didn't start reviewing the v2 yet. But one thing is that now the
> versal-pci FPGA manager has no user because of the ongoing uAPI, so
> cannot be merged, and I won't pay much effort on this series for now.

Hi Yilun,

Can we add this as TODO in the future when the uAPI solution is ready to 
switch? We spent some time to refactor the driver and address most of 
your comments in the V2. Hopefully, can you please start reviewing the 
fpga_mgr and other driver code?

We'd think that we use the firmware_upload for 1st approach and start 
letting user use this driver.

We definitely will switch to the new uAPI as soon as it is ready in the 
linux fpga driver. But we'd not like this uAPI holds up everything we 
already spent times.

Thanks,
David
> 
> Thanks,
> Yilun
> 
>> yet.
>>
>> Happy Holidays.
>>
>> Thanks,
>> David

